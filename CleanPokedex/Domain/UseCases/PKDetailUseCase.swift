//
//  PokeDetailUseCase.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/16.
//

import Foundation
import RxSwift
import RxCocoa

protocol PKDetailUseCase {
    func fetchPokeDetail() -> Observable<PKDetailResponseDTO>
}

final class PKDetailUseCaseImp {

    // MARK: - Properties
    private let pokeDetailRepository: PKDetailRepository
    
    deinit {
        print("deinit - \(self)")
    }
    
    init(pokeDetailRepository: PKDetailRepository) {
        self.pokeDetailRepository = pokeDetailRepository
    }
}

extension PKDetailUseCaseImp: PKDetailUseCase {
    func fetchPokeDetail() -> Observable<PKDetailResponseDTO> {
        return pokeDetailRepository.fetchPokemonDetail()
    }
}

