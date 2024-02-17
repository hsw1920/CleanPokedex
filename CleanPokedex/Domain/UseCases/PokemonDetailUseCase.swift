//
//  PokeDetailUseCase.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/16.
//

import Foundation
import RxSwift
import RxCocoa

protocol PokemonDetailUseCase {
    func fetchPokeDetail() -> Observable<PKDetailResponseDTO>
}

final class PokemonDetailUseCaseImp {

    // MARK: - Properties
    private let pokemonDetailRepository: PokemonDetailRepository
    
    deinit {
        print("deinit - \(self)")
    }
    
    init(pokemonDetailRepository: PokemonDetailRepository) {
        self.pokemonDetailRepository = pokemonDetailRepository
    }
}

extension PokemonDetailUseCaseImp: PokemonDetailUseCase {
    func fetchPokeDetail() -> Observable<PKDetailResponseDTO> {
        return pokemonDetailRepository.fetchPokemonDetail()
    }
}

