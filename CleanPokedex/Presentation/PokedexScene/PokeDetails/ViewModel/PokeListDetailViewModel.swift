//
//  PokeListDetailViewModel.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/15.
//

import UIKit
import RxSwift
import RxCocoa

final class PokeListDetailViewModel {
    deinit {
        print("deinit - \(self)")
    }
    let id: String
    init(id: String) {
        self.id = id
        let disposeBag = DisposeBag()
        let service = PokemonDetailService()
        let relay = BehaviorRelay<PokemonDetailResponse>(value: PokemonDetailResponse.init(id: 0, name: "", sprites: .init(default: ""), types: [], stats: []))
        
        service.fetchPokemonDetail(id: "\(id)")
            .bind(to: relay)
            .disposed(by: disposeBag)
    }
}
