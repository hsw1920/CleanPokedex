//
//  PokemonDetailRepositoryImp.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/16.
//

import Foundation
import RxSwift

final class PKDetailRepositoryImp {
    private let pokemonDetailService: PKDetailService
    
    deinit {
        print("deinit - \(self)")
    }
    
    init(
        pokeDetailService: PKDetailService
    ) {
        self.pokemonDetailService = pokeDetailService
    }
}

extension PKDetailRepositoryImp: PKDetailRepository {
    func fetchPokemonDetail() -> Observable<PKDetailResponseDTO> {
        return pokemonDetailService.fetchPokemonDetail()
    }
}
