//
//  Coordinator.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinator: [Coordinator] { get set }
    func start()
}
