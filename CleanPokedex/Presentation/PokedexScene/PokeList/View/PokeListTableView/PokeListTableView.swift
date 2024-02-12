//
//  PokeListTableView.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import UIKit

class PokeListTableView: UITableViewController {
    
    var viewModel: PokeListViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        tableView.register(PokeListItemCell.self, forCellReuseIdentifier: PokeListItemCell.reuseIdentifier)
        tableView.estimatedRowHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension PokeListTableView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeListItemCell.reuseIdentifier, for: indexPath) as? PokeListItemCell else {
            return UITableViewCell()
        }
        
        cell.configure(item: viewModel.items[indexPath.row])
        
        return cell
    }
}
