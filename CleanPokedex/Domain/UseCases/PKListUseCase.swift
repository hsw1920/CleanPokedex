//
//  SearchPokemonUseCase.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation
import RxSwift
import RxCocoa

protocol PKListUseCase {
    func fetchPokeList()
    func filterPokeList(with searchText: String) -> Observable<[PKListItem]>
}

final class PKListUseCaseImp: PKListUseCase {
    
    // MARK: - Properties
    private let pokeListRepository: PKListRepository
    
    private let pokeListItem: BehaviorRelay<[PKListItem]> = BehaviorRelay<[PKListItem]>(value: [])
    private let disposeBag = DisposeBag()
    
    init(pokeListRepository: PKListRepository) {
        self.pokeListRepository = pokeListRepository
    }
    
    func fetchPokeList() {
        pokeListRepository.fetchPokeList()
            .map(mapToPokeListItem)
            .bind(to: pokeListItem)
            .disposed(by: disposeBag)
    }
    
    func filterPokeList(with searchText: String) -> Observable<[PKListItem]> {
        if searchText.isEmpty {
            return pokeListItem.asObservable()
        }
        
        return pokeListItem.map { items in
            items.filter { item in
                return item.title.contains(searchText)
            }
        }
    }
}

extension PKListUseCase {
    func mapToPokeListItem(pokemons: [PKContent]) -> [PKListItem] {
        return pokemons.map { item in
            PKListItem(
                id: item.id,
                title: item.name,
                imageUrl: item.sprite
            )
        }
    }
}
