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
    func fetchNextPokeList()
    var isLoading: PublishSubject<Bool> { get }
}

final class PKListUseCaseImp: PKListUseCase {
    // MARK: - Properties
    private let pokeListRepository: PKListRepository
    
    private let pokeListItem: BehaviorRelay<[PKListItem]> = BehaviorRelay<[PKListItem]>(value: [])
    private var nextPage: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    
    init(pokeListRepository: PKListRepository) {
        self.pokeListRepository = pokeListRepository
    }
    
    func fetchPokeList() {
        isLoading.onNext(true)
        
        pokeListRepository.fetchPokeList()
            .map(updateNextPokeListPage)
            .map(mapToPokeListItem)
            .do(onDispose: { [weak self] in
                self?.isLoading.onNext(false)
            })
            .bind(to: pokeListItem)
            .disposed(by: disposeBag)
    }
    
    func fetchNextPokeList() {
        guard let nextPage = nextPage.value else { return }
        
        isLoading.onNext(true)
        
        pokeListRepository.fetchNextPokeList(endPoint: nextPage)
            .map(updateNextPokeListPage)
            .map(mapToPokeListItem)
            .map(accumulatePokeListItem)
            .do(onDispose: { [weak self] in
                self?.isLoading.onNext(false)
            })
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
    
    private func updateNextPokeListPage(list: PKListPage) -> [PKContent] {
        nextPage.accept(list.next)
        return list.contents
    }
    
    private func mapToPokeListItem(pokemons: [PKContent]) -> [PKListItem] {
        return pokemons.map { item in
            PKListItem(
                id: item.id,
                title: item.name,
                imageUrl: item.sprite
            )
        }
    }
    
    private func accumulatePokeListItem(_ newList: [PKListItem]) -> [PKListItem] {
        return pokeListItem.value + newList
    }
}
