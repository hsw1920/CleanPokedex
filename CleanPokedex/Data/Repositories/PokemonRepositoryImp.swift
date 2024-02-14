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
    private var pokeImgUrls: [String] = []
    init(
        pokemonService: PokemonService
    ) {
        self.pokemonService = pokemonService
    }
}

extension PokemonRepositoryImp: PokemonRepository {
    func fetchPokemonList() -> Observable<[Pokemon]> {
        return pokemonService.fetchPokemons()
    }
    
    func fetchPokeImgUrls() -> Observable<[PokemonSprite]> {
        return pokemonService.imageUrls.asObservable()
    }
}


