//
//  PKListService.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/19.
//

import RxSwift
import RxCocoa

protocol PKListService: URLSessionNetworkService {
    func fetchPokemons(endPoint: String) -> Observable<([PKContentResponseDTO], [PKSpriteItemResponseDTO])>
    func fetchSprites(for list: PKListResponseDTO) -> Observable<([PKContentResponseDTO], [PKSpriteItemResponseDTO])>
}

final class PKListServiceImp: PKListService {
    func fetchPokemons(endPoint: String) -> Observable<([PKContentResponseDTO], [PKSpriteItemResponseDTO])> {
        let decodeTarget = PKListResponseDTO.self
        return get(url: endPoint)
            .flatMap { result in
                switch result {
                case .success(let data):
                    guard let list = self.decode(data: data, to: decodeTarget) else { throw URLSessionNetworkServiceError.responseDecodingError }
                    return self.fetchSprites(for: list)
                case .failure(let error):
                    throw error
                }
            }
    }
    
    func fetchSprites(for list: PKListResponseDTO) -> Observable<([PKContentResponseDTO], [PKSpriteItemResponseDTO])> {
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
                return self.parseContentSprite(list: list, sprites: sprites)
            }
    }
    
    private func parseContentSprite(list: PKListResponseDTO, sprites: [PKSpritesResponseDTO]) -> ([PKContentResponseDTO], [PKSpriteItemResponseDTO]) {
        return (list.results, sprites.map{ $0.sprites })
    }
}
