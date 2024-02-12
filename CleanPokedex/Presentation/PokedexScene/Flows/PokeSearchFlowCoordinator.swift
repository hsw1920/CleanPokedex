//
//  PokeSearchFlowCoordinator.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit

final class PokeSearchFlowCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinator: [Coordinator] = []
    
    private weak var moviesListVC: PokeListViewController?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = PokeListViewController.create(with: PokeListViewModelImp())
        navigationController.pushViewController(vc, animated: false)
        
    }

}
