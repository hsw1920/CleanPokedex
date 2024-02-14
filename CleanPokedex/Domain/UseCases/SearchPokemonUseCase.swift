//
//  SearchPokemonUseCase.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchPokemonUseCase {
    func fetchPokemonList()
    func filterPokemonList(with searchText: String) -> Observable<[Pokemon]>
    var pokeList: BehaviorRelay<[Pokemon]> { get set }
}

final class SearchPokemonUseCaseImp: SearchPokemonUseCase {
    private let disposeBag = DisposeBag()
    
    // MARK: - 의존성 주입
    private let pokemonRepository: PokemonRepository
    var pokeList: BehaviorRelay<[Pokemon]> = BehaviorRelay(value: [])
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    func fetchPokemonList() {
        pokemonRepository.fetchPokemonList()
            .subscribe(onNext: { [weak self] items in
                self?.pokeList.accept(items)
            })
            .disposed(by: disposeBag)
    }
    
    func filterPokemonList(with searchText: String) -> Observable<[Pokemon]> {
        return pokeList
            .map { pokemons in
                if searchText.isEmpty {
                    return pokemons
                } else {
                    return pokemons.filter { $0.name.contains(searchText) }
                }
            }
    }
}
