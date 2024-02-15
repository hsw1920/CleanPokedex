//
//  PokeListViewController.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit
import RxSwift
import RxCocoa

final class PokeListViewController: UIViewController {
    private var searchController = UISearchController(searchResultsController: nil)
    private let tableView: UITableView = UITableView(frame: .zero)

    private var viewModel: PokeListViewModel!
    
    var disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    static func create(with viewModel: PokeListViewModel) -> PokeListViewController {
        let view = PokeListViewController()
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
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PokeListItemCell.self,
                           forCellReuseIdentifier: PokeListItemCell.reuseIdentifier)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bind(to viewModel: PokeListViewModel){
        let input = PokeListViewModel.Input( 
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in },
            searchBarTextEvent: self.searchController.searchBar.rx.text.orEmpty.asObservable(), 
            didTapDetailCell: self.tableView.rx.itemSelected.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(to: tableView.rx.items(cellIdentifier: PokeListItemCell.reuseIdentifier,
                                         cellType: PokeListItemCell.self)
            ){ _, item, cell in
                cell.configure(item: item)
            }
            .disposed(by: disposeBag)
        
        output.screenTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.searchBarPlaceholder
            .bind(to: searchController.searchBar.rx.placeholder)
            .disposed(by: disposeBag)
    }

}

extension PokeListViewController {
    func setupSearchController() {
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.hidesNavigationBarDuringPresentation = false
    }
}

