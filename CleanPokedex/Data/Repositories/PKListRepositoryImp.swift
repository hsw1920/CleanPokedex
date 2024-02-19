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
    
    var nextPokeListEndPoint: String?
}

extension PKListRepositoryImp: PKListRepository {
    func fetchPokeList() -> Observable<PKListPage> {
        let endPoint = "https://pokeapi.co/api/v2/pokemon/"
        return pokeListService.fetchPokemons(endPoint: endPoint)
    }
    
    func fetchNextPokeList(endPoint: String) -> Observable<PKListPage> {
        return pokeListService.fetchPokemons(endPoint: endPoint)
    }
}


