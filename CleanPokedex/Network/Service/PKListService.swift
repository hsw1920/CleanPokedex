//
//  PKListService.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/19.
//

import RxSwift
import RxCocoa

protocol PKListService: URLSessionNetworkService {
    func fetchPokemons(endPoint: String) -> Observable<[PKContent]>
}

final class PKListServiceImp: PKListService {
    func fetchPokemons(endPoint: String) -> Observable<[PKContent]> {
        let decodeTarget = PKListResponseDTO.self
        return get(url: endPoint)
            .flatMap { result in
                switch result {
                case .success(let data):
                    guard let list = self.decode(data: data, to: decodeTarget) else { throw URLSessionNetworkServiceError.responseDecodingError }
                    return self.fetchWithSprites(for: list)
                case .failure(let error):
                    throw error
                }
            }
    }
}

extension PKListServiceImp {
    private func fetchWithSprites(for list: PKListResponseDTO) -> Observable<[PKContent]> {
        let decodeTarget = PKSpritesResponseDTO.self
        
        let tasks = list.results.map{ $0.url }
            .map { endPoint in
                self.get(url: endPoint)
                    .map { result in
                        switch result {
                        case .success(let data):
                            guard let sprites = self.decode(data: data, to: decodeTarget) else { throw URLSessionNetworkServiceError.responseDecodingError }
                            return sprites
                        case .failure(let error):
                            throw error
                        }
                    }
            }
        
        return Observable.zip(tasks)
            .map { sprites in
                return self.parseToDomain(list: list, sprites: sprites)
            }
    }
    
    private func parseToDomain(list: PKListResponseDTO, sprites: [PKSpritesResponseDTO]) -> [PKContent] {
        guard list.results.count == sprites.count else {
            return []
        }
        
        return list.results.enumerated()
            .map { idx, item in
                item.toDomain(with: sprites[idx].sprites.toDomain())
            }
    }

}
