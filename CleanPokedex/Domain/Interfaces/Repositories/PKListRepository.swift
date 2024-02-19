//
//  PokemonRepository.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation
import RxSwift

protocol PKListRepository {
    func fetchPokeList() -> Observable<PKListPage>
    func fetchNextPokeList(endPoint: String) -> Observable<PKListPage>
}
