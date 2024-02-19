//
//  PokemonDetailRepository.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation
import RxSwift

protocol PKDetailRepository {
    func fetchPokemonDetail() -> Observable<PKDetailResponseDTO>
}
