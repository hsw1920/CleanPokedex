//
//  PokeListViewModel.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit
import RxSwift
import RxCocoa

final class PokeListViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let searchBarTextEvent: Observable<String>
    }

    struct Output {
        // "Usecase에게 받고, View에게 줄 수 있어야함" & "View의 TableView UI 요소임" -> Relay를 써야함이 마땅하다.
        var items: BehaviorRelay<[PokeListItem]> = BehaviorRelay<[PokeListItem]>(value: [])
        let screenTitle: Observable<String> = .just("Pokedex")
        let searchBarPlaceholder: Observable<String> = .just("Search results")
    }

    private let searchPokemonUseCase: SearchPokemonUseCase
    private var disposeBag = DisposeBag()
    private weak var coordinator: PokeSearchFlowCoordinator?
    
    // MARK: Init
    init(
        coordinator: PokeSearchFlowCoordinator?,
        searchPokemonUseCase: SearchPokemonUseCase
    ) {
        self.coordinator = coordinator
        self.searchPokemonUseCase = searchPokemonUseCase
    }
    
    deinit {
        print("deinit - \(self)")
    }

    // MARK: Transform
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewWillAppear
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.searchPokemonUseCase.fetchPokemonList()
            })
            .disposed(by: disposeBag)
        
        input.searchBarTextEvent
            .withUnretained(self)
            .flatMapLatest { owner, text in
                return owner.searchPokemonUseCase.filterPokemonList(with: text)
                    .map(owner.mapToPokeListItems)
            }
            .bind(to: output.items)
            .disposed(by: disposeBag)
        
        self.searchPokemonUseCase.pokeList
            .map(mapToPokeListItems)
            .bind(to: output.items)
            .disposed(by: disposeBag)
       
        searchPokemonUseCase.pokeImgList
            .subscribe(onNext: { item in
                print(item)
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

extension PokeListViewModel {
    func extractPokemonNumber(from urlString: String) -> String {
        var components = urlString.components(separatedBy: "/")
        components.removeLast()
        return components.last!
    }
    
    func mapToPokeListItems(pokemons: [Pokemon]) -> [PokeListItem] {
        return pokemons.map {
            PokeListItem(
                number: extractPokemonNumber(from: $0.url),
                title: $0.name
            )
        }
    }
}
