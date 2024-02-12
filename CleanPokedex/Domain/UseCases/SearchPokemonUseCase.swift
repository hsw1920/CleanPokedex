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
    func fetchPokemonList() -> Observable<[Pokemon]>
}

final class SearchPokemonUseCaseImp: SearchPokemonUseCase {

    // MARK: - 의존성 주입
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    //private let pokemonQueriesRepository: PokemonQueriesRepository
    
    // PokemonRepository에서 ~~ 함
    // PokemonQueriesRepository에서 ~~ 함
    
    func fetchPokemonList() -> Observable<[Pokemon]> {
        return pokemonRepository.fetchPokemonList()
    }
    
//    func execute() -> Observable<Void> {
//        return BehaviorRelay.create { observer in
//            print("zzz")
//            return Disposables.create()
//        }
//    }
    
    
}
