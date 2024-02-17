//
//  PokemonDetailRepositoryImp.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/16.
//

import Foundation
import RxSwift

final class PokemonDetailRepositoryImp {
    private let pokemonDetailService: PokemonDetailService
    
    deinit {
        print("deinit - \(self)")
    }
    
    init(
        pokemonDetailService: PokemonDetailService
    ) {
        self.pokemonDetailService = pokemonDetailService
    }
}

extension PokemonDetailRepositoryImp: PokemonDetailRepository {
    func fetchPokemonDetail() -> Observable<PKDetailResponseDTO> {
        return pokemonDetailService.fetchPokemonDetail()
    }
}
