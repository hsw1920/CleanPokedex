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
    private let searchBarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()
    
    private var tableView: UITableView = UITableView(frame: .zero)

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
        setupSearchController()
        bind(to: self.viewModel)
    }

    private func setupViews(){
        view.backgroundColor = .systemBackground
        view.addSubview(searchBarContainer)

        NSLayoutConstraint.activate([
            searchBarContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBarContainer.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .systemGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PokeListItemCell.self,
                           forCellReuseIdentifier: PokeListItemCell.reuseIdentifier)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBarContainer.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bind(to viewModel: PokeListViewModel){
        let input = PokeListViewModel.Input.init(
            load: .just(())
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
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.barStyle = .black
        searchController.hidesNavigationBarDuringPresentation = false
        searchBarContainer.layoutIfNeeded()
        searchController.searchBar.frame = searchBarContainer.bounds
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        searchBarContainer.addSubview(searchController.searchBar)
        definesPresentationContext = true
    }
}

extension PokeListViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
//        updateQueriesSuggestions()
    }

    func willDismissSearchController(_ searchController: UISearchController) {
//        updateQueriesSuggestions()
    }

    func didDismissSearchController(_ searchController: UISearchController) {
//        updateQueriesSuggestions()
    }
}

extension PokeListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
//        viewModel.didSearch(query: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        viewModel.didCancelSearch()
    }
}
