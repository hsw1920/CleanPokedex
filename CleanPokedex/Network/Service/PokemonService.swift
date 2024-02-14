//
//  PokemonService.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation
import RxSwift
import RxCocoa

struct PokemonResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}

struct PokemonDetailResponse: Decodable {
    let sprites: PokemonSprite
    
    enum CodingKeys: String, CodingKey {
        case sprites
    }
}

struct PokemonSprite: Decodable {
    let `default`: String
    enum CodingKeys: String, CodingKey {
        case `default` = "front_default"
    }
}

protocol PokemonServiceProtocol {
    func fetchPokemons() -> Observable<[Pokemon]>
    func loadPokeImage(_ urlString: String) -> Observable<PokemonSprite>
    var imageUrls: BehaviorRelay<[PokemonSprite]> { get }
}

class PokemonService: PokemonServiceProtocol {
    var disposeBag = DisposeBag()
    var imageUrls: BehaviorRelay<[PokemonSprite]> = BehaviorRelay<[PokemonSprite]>(value: [])
    
    let url = "https://pokeapi.co/api/v2/pokemon/"

    
    func fetchPokemons() -> Observable<[Pokemon]> {
        return Observable.create { observer in
            if let url = URL(string: self.url) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print(">>> Error - \(self): \n \(error.localizedDescription) ")
                        observer.onError(error)
                    } else if let data = data {
                        do {
                            let pokemons = try JSONDecoder().decode(PokemonResponse.self, from: data)
                            observer.onNext(pokemons.results)
                            
                            let urls = pokemons.results.map{$0.url}
//                            urls.forEach {
//                                self.loadPokeImage($0)
//                                    .map { [weak self] item in
//                                        guard let self = self else { return [] }
//                                        var images = self.imageUrls.value
//                                        images.append(item)
//                                        return images
//                                    }
//                                    .bind(to: self.imageUrls)
//                                    .disposed(by: self.disposeBag)
//                            }
                            
                            Observable.from(urls)
                                .flatMap { url in
                                    return self.loadPokeImage(url)
                                }
                                .scan([]) { (acc, item) in
                                    return acc + [item]
                                }
                                .bind(to: self.imageUrls)
                                .disposed(by: self.disposeBag)

                            observer.onCompleted()
                        } catch {
                            print(">>> Error - \(self): \n \(error.localizedDescription) ")
                            observer.onError(error)
                        }
                    }
                }.resume()
            }
            return Disposables.create()
        }
    }
    
    func loadPokeImage(_ urlString: String) -> Observable<PokemonSprite> {
        let url = URL(string: urlString)
        
        return Observable.create { observer in
            if let url {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print(">>> Error - \(self): \n \(error.localizedDescription) ")
                        observer.onError(error)
                    } else if let data = data {
                        do {
                            let pokemons = try JSONDecoder().decode(PokemonDetailResponse.self, from: data)
                            observer.onNext(pokemons.sprites)
                            observer.onCompleted()
                        } catch {
                            print(">>> Error - \(self): \n \(error.localizedDescription) ")
                            observer.onError(error)
                        }
                    }
                }.resume()
            }
            
            return Disposables.create()
        }
        
        
    }
    
    
}
