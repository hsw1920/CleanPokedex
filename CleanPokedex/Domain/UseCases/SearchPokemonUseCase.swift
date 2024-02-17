//
//  SearchPokemonUseCase.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchPokemonUseCase {
    func fetchPokemonList()
    func filterPokemonList(with searchText: String) -> Observable<[PokeListItem]>
}

final class SearchPokemonUseCaseImp: SearchPokemonUseCase {

    // MARK: - Properties
    private let pokemonRepository: PokemonRepository
    
    private let pokeList: BehaviorRelay<[PKContentResponseDTO]> = BehaviorRelay<[PKContentResponseDTO]>(value: [])
    private let pokeImgList: BehaviorRelay<[PKSpriteItemResponseDTO]> = BehaviorRelay<[PKSpriteItemResponseDTO]>(value: [])
    private let pokeItems: BehaviorRelay<[PokeListItem]> = BehaviorRelay<[PokeListItem]>(value: [])
    private let disposeBag = DisposeBag()
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    func fetchPokemonList() {
        pokemonRepository.fetchPokemonList()
            .bind(to: pokeList)
            .disposed(by: disposeBag)
        
        pokemonRepository.fetchPokeImgUrls()
            .debounce(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: pokeImgList)
            .disposed(by: disposeBag)
        
        Observable.zip(pokeList, pokeImgList)
            .map(mapToPokeListItems)
            .bind(to: pokeItems)
            .disposed(by: disposeBag)
    }
    
    func filterPokemonList(with searchText: String) -> Observable<[PokeListItem]> {
        if searchText.isEmpty {
            return pokeItems.asObservable()
        }
        
        return pokeItems.map { items in
            items.filter { item in
                return item.title.contains(searchText)
            }
        }
    }
}

extension SearchPokemonUseCase {
    func extractPokemonNumber(from urlString: String) -> String {
        var components = urlString.components(separatedBy: "/")
        components.removeLast()
        return components.last!
    }
    
    func mapToPokeListItems(pokemons: [PKContentResponseDTO], images: [PKSpriteItemResponseDTO]) -> [PokeListItem] {
        guard pokemons.count == images.count else { return [] }
        
        return pokemons.enumerated()
            .map { idx, item in
                PokeListItem(
                    number: extractPokemonNumber(from: item.url),
                    title: item.name,
                    imageUrl: images[idx]
                )
            }
    }
}
