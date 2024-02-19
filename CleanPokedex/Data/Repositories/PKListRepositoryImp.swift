//
//  PokemonRepositoryImp.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation
import RxSwift

final class PKListRepositoryImp {
    private let pokeListService: PKListService
    init(
        pokeListService: PKListService
    ) {
        self.pokeListService = pokeListService
    }
}

extension PKListRepositoryImp: PKListRepository {
    func fetchPokeList() -> Observable<[PKContent]> {
        let endPoint = "https://pokeapi.co/api/v2/pokemon/"
        return pokeListService.fetchPokemons(endPoint: endPoint)
    }
}


