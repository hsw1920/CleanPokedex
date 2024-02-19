//
//  AppCoordinator.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinator: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let coordinator = PKListFlowCoordinator(navigationController)
        coordinator.delegate = self
        childCoordinator.append(coordinator)
        coordinator.start()
    }

}

extension AppCoordinator: PokeSearchFlowCoordinatorDelegate {
    func didFinish(_ child: Coordinator) {
        self.childCoordinator = self.childCoordinator.filter{ $0.self !== child }
    }
}
