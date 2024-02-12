//
//  PokeListViewController.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit

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
    
    private var tableView: PokeListTableView = PokeListTableView()

    private var viewModel: PokeListViewModel!
    
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
        title = "Pokedex"
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
        tableView.viewModel = self.viewModel
        tableView.view.backgroundColor = .systemGray
        tableView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView.view)
        
        NSLayoutConstraint.activate([
            tableView.view.topAnchor.constraint(equalTo: searchBarContainer.bottomAnchor),
            tableView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bind(to viewModel: PokeListViewModel){
        
    }

}

extension PokeListViewController {
    func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = viewModel.searchBarPlaceholder
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
