//
//  PokeListViewController.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit
import RxSwift
import RxCocoa

final class PKListViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private let activityIndicator = UIActivityIndicatorView()
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private var dataSource: UICollectionViewDiffableDataSource<PKListSection, SectionItem>!
    private var snapshot: NSDiffableDataSourceSnapshot<PKListSection, SectionItem>!
    
    private var viewModel: PKListViewModel!
    
    private var disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    static func create(with viewModel: PKListViewModel) -> PKListViewController {
        let view = PKListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: self.viewModel)
    }
    
    private func setupViews(){
        view.backgroundColor = .systemBackground
        setupSearchController()
        setupCollectionView()
        setupActivityView()
    }
    
    private func bind(to viewModel: PKListViewModel){
        let input = PKListViewModel.Input(
            viewDidLoad: .just(()),
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in },
            searchBarTextEvent: self.searchController.searchBar.rx.text.orEmpty.asObservable(),
            didTapDetailCell: self.collectionView.rx.itemSelected.asObservable(),
            updateNextPokeList: self.collectionView.rx.reachedBottom().map { _ in }
        )
        let output = viewModel.transform(input: input)

        output.screenTitle
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.searchBarPlaceholder
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: searchController.searchBar.rx.placeholder)
            .disposed(by: disposeBag)
        
        output.isLoading
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.viewState
            .observe(on: MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { owner, state in
                switch state {
                case .list:
                    owner.collectionView.collectionViewLayout = PKListCollectionViewLayout.createLayoutList()
                case .grid:
                    owner.collectionView.collectionViewLayout = PKListCollectionViewLayout.createLayoutGrid()
                }
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.viewState, output.items)
            .observe(on: MainScheduler.asyncInstance)
            .distinctUntilChanged { $0 == $1 }
            .bind(onNext: { [weak self] state , items in
                guard let self = self else { return }
                drawPokeList(with: items, state: state)
            })
            .disposed(by: disposeBag)
    }
}

extension PKListViewController {
    private func setupSearchController() {
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(
            PokeListCollectionViewItemCell.self,
            forCellWithReuseIdentifier: PokeListCollectionViewItemCell.reuseIdentifier
        )
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        configureDataSource()
    }
    
    private func setupActivityView() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - DiffableDataSource

extension PKListViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration
        <PokeListCollectionViewItemCell, PKListItem> { (cell, indexPath, item) in
            cell.configure(item: item)
        }
        
        let cellRegistrationBanner = UICollectionView.CellRegistration
        <PokeListCollectionViewBannerCell, PKListBanner> { (cell, indexPath, item) in
            cell.configure(item: item)
        }
        
        dataSource = UICollectionViewDiffableDataSource<PKListSection, SectionItem> (
            collectionView: collectionView
        ) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             identifier: SectionItem) -> UICollectionViewCell? in
            switch identifier {
            case .grid(let item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: item
                )
            case .list(let item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: item
                )
            case .bannerItem(let item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistrationBanner,
                    for: indexPath,
                    item: item
                )
            }
        }
    }
    
    private func drawPokeList(with list: [PKListItem], state: PKListState) {
        if snapshot == nil {
            applyInitialSnapshot(with: list)
        } else {
            applyNextSnapshot(with: list, state: state)
        }
    }
    
    private func applyInitialSnapshot(with items: [PKListItem]) {
        snapshot = NSDiffableDataSourceSnapshot<PKListSection, SectionItem>()
        snapshot.appendSections([.banner, .main])
        
        snapshot.appendItems(PKListBanner.mock.map{.bannerItem($0)}, toSection: .banner)
        snapshot.appendItems(items.map{.list($0)}, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applyNextSnapshot(with items: [PKListItem], state: PKListState) {
        let prevItems = snapshot.itemIdentifiers(inSection: .main)
        snapshot.deleteItems(prevItems)
        snapshot.deleteSections([.main])

        switch state {
        case .list:
            snapshot.appendSections([.main])
            
            let listItems = items.map { SectionItem.list($0) }
            snapshot.appendItems(listItems, toSection: .main)
        case .grid:
            snapshot.appendSections([.main])
            
            let girdItems = items.map { SectionItem.grid($0) }
            snapshot.appendItems(girdItems, toSection: .main)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

enum PKListSection: CaseIterable {
    case banner, main
}

enum SectionItem: Hashable {
    case bannerItem(PKListBanner)
    case list(PKListItem)
    case grid(PKListItem)
}
