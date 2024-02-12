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
        let service = PokemonService()
        let repository = PokemonRepositoryImp(pokemonService: service)
        let usecase = SearchPokemonUseCaseImp(pokemonRepository: repository)
        let viewModel = PokeListViewModel(searchPokemonUseCase: usecase)
        let vc = PokeListViewController.create(with: viewModel)
        
        navigationController.pushViewController(vc, animated: false)
        
    }

}
