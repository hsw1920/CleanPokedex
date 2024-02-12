//
//  PokemonRepositoryImp.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation
import RxSwift


final class PokemonRepositoryImp {
    private let pokemonService: PokemonService

    init(pokemonService: PokemonService) {
        self.pokemonService = pokemonService
    }
}

extension PokemonRepositoryImp: PokemonRepository {
    func fetchPokemonList() -> Observable<[Pokemon]> {
        return pokemonService.fetchPokemons()
    }
}


