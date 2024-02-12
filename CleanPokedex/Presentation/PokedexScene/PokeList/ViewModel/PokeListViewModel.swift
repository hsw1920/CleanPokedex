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
        let load: Observable<Void>
    }

    struct Output {
        // "Usecase에게 받고, View에게 줄 수 있어야함" & "View의 TableView UI 요소임" -> Relay를 써야함이 마땅하다.
        var items: BehaviorRelay<[PokeListItem]> = BehaviorRelay<[PokeListItem]>(value: [])
        let screenTitle: Observable<String> = .just("Pokedex")
        let searchBarPlaceholder: Observable<String> = .just("Search results")
    }

    private let searchPokemonUseCase: SearchPokemonUseCase
    private var disposeBag = DisposeBag()
    
    // MARK: Init
    init(
        searchPokemonUseCase: SearchPokemonUseCase
    ) {
        self.searchPokemonUseCase = searchPokemonUseCase
    }

    // MARK: Transform
    func transform(input: Input) -> Output {
        let output = Output()
        // MARK: Mock
        //let pokemonFetchObservableMock = Observable.just(PokeListItem.mock)
        //self.items.accept(PokeListItem.mock)
        
        input.load
            .flatMap(searchPokemonUseCase.fetchPokemonList)
            .map { $0.map {
                PokeListItem(
                    number: self.extractPokemonNumber(from: $0.url),
                    title: $0.name
                )}
            }
            .bind(to: output.items)
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
}
