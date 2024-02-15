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

final class PokeSearchFlowCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinator: [Coordinator] = []
    
    weak var delegate: AppCoordinator?
    
    private weak var pokeListVC: PokeListViewController?
    private weak var pokeListDetailVC: PokeListDetailViewController?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit{
        print("deinit - \(self)")
    }
    
    func start() {
        let service = PokemonService()
        let repository = PokemonRepositoryImp(pokemonService: service)
        let usecase = SearchPokemonUseCaseImp(pokemonRepository: repository)
        let viewModel = PokeListViewModel(coordinator: self, searchPokemonUseCase: usecase)
        pokeListVC = PokeListViewController.create(with: viewModel)
        navigationController.pushViewController(pokeListVC!, animated: false)
    }

}

extension PokeSearchFlowCoordinator: PokeListViewControllerDelegate {
    func didTapDetailCell(with index: Int) {
        print("index: \(index)")
        let viewModel = PokeListDetailViewModel()
        pokeListDetailVC = PokeListDetailViewController.create(with: viewModel)
        navigationController.pushViewController(pokeListDetailVC!, animated: true)
    }
}
