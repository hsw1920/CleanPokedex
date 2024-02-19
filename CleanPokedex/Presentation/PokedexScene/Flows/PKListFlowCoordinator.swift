//
//  PokeSearchFlowCoordinator.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit

protocol PokeSearchFlowCoordinatorDelegate {
    func didFinish(_ child: Coordinator)
}

final class PKListFlowCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinator: [Coordinator] = []
    
    weak var delegate: AppCoordinator?
    
    private weak var pokeListVC: PKListViewController!
    private weak var pokeListDetailVC: PKListDetailViewController!
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit{
        print("deinit - \(self)")
    }
    
    func start() {
        let service = PKListServiceImp()
        let repository = PKListRepositoryImp(pokeListService: service)
        let usecase = PKListUseCaseImp(pokeListRepository: repository)
        let viewModel = PKListViewModel(coordinator: self, pokeListUseCase: usecase)
        pokeListVC = PKListViewController.create(with: viewModel)
        
        navigationController.pushViewController(pokeListVC!, animated: false)
    }

}

extension PKListFlowCoordinator: PokeListViewDelegate {
    func didTapDetailCell(with id: String) {
        let service = PKDetailService(with: id)
        let repository = PKDetailRepositoryImp(pokeDetailService: service)
        let useCase = PKDetailUseCaseImp(pokeDetailRepository: repository)
        let viewModel = PKListDetailViewModel(pokeDetailUseCase: useCase)
        let detailVC = PKListDetailViewController.create(with: viewModel)

        navigationController.pushViewController(detailVC, animated: true)
    }
}
