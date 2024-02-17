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
        let viewWillAppear: Observable<Void>
    }

    struct Output {
        let screenTitle: Observable<String> = .just("Detail")
        let id: BehaviorRelay<String> = BehaviorRelay<String>(value: "...")
        let name: BehaviorRelay<String> = BehaviorRelay<String>(value: "...")
        let hp: BehaviorRelay<String> = BehaviorRelay<String>(value: "...")
        let attack: BehaviorRelay<String> = BehaviorRelay<String>(value: "...")
        let defense: BehaviorRelay<String> = BehaviorRelay<String>(value: "...")
        let specialAttack: BehaviorRelay<String> = BehaviorRelay<String>(value: "...")
        let specialDefense: BehaviorRelay<String> = BehaviorRelay<String>(value: "...")
        let speed: BehaviorRelay<String> = BehaviorRelay<String>(value: "...")
        let image: BehaviorRelay<String> = BehaviorRelay<String>(value: "...")
        let types: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    }
    
    deinit {
        print("deinit - \(self)")
    }
    
    let pokeDetailUseCase: PokemonDetailUseCase
    
    private var disposeBag = DisposeBag()
    
    init(pokeDetailUseCase: PokemonDetailUseCase) {
        self.pokeDetailUseCase = pokeDetailUseCase
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        input.viewWillAppear
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.fetchPokeDetail(to: output)
            })
            .disposed(by: disposeBag)
        return output
    }
}

extension PokeListDetailViewModel {
    func fetchPokeDetail(to output: PokeListDetailViewModel.Output) {
        pokeDetailUseCase.fetchPokeDetail()
            .map(mapToPokeDetail)
            .subscribe(onNext: { item in
                output.id.accept(item.id)
                output.name.accept(item.name)
                output.hp.accept(item.hp)
                output.attack.accept(item.attack)
                output.defense.accept(item.defense)
                output.specialAttack.accept(item.specialAttack)
                output.specialDefense.accept(item.specialDefense)
                output.speed.accept(item.speed)
                output.image.accept(item.image)
                output.types.accept(item.types)
            })
            .disposed(by: disposeBag)
    }
    
    func mapToPokeDetail(_ response: PKDetailResponseDTO) -> PokeDetail {
        return PokeDetail(
            name: response.name,
            id: "\(response.id)",
            hp: "\(response.stats[0].baseStat)",
            attack: "\(response.stats[1].baseStat)",
            defense: "\(response.stats[2].baseStat)",
            specialAttack: "\(response.stats[3].baseStat)",
            specialDefense: "\(response.stats[4].baseStat)",
            speed: "\(response.stats[5].baseStat)",
            image: response.sprites.default, 
            types: response.types.map { $0.type.name }
        )
    }
}
