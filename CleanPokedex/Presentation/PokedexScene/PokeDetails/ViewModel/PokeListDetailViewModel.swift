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
    
    struct Input {
        
    }

    struct Output {
        let screenTitle: Observable<String> = .just("Detail")
        let id: Observable<String> = .just("idMock")
        let name: Observable<String> = .just("nameMock")
        let hp: Observable<String> = .just("hpMock")
        let attack: Observable<String> = .just("attackMock")
        let defense: Observable<String> = .just("defenseMock")
        let specialAttack: Observable<String> = .just("SPAMock")
        let specialDefense: Observable<String> = .just("SPDMock")
        let spped: Observable<String> = .just("sppedMock")
    }
    
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
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
}
