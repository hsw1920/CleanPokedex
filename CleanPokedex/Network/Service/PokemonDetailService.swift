//
//  PokemonDetailService.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/15.
//

import Foundation
import RxSwift
import RxCocoa

struct PokemonDetailResponse: Decodable {
    let id: Int
    let name: String
    let sprites: PokemonSprite
    let types: [PokemonTypes]
    let stats: [PokemonStats]
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case sprites
        case types
        case stats
    }
}

struct PokemonTypes: Decodable {
    let slot: Int
    let type: PokemonType
    
    enum CodingKeys: CodingKey {
        case slot
        case type
    }
}

struct PokemonType: Decodable {
    let name: String
    enum CodingKeys: CodingKey {
        case name
    }
}

struct PokemonStats: Decodable {
    let baseStat: Int
    let stat: PokemonStat
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct PokemonStat: Decodable {
    let name: String
    enum CodingKeys: CodingKey {
        case name
    }
}

protocol PokemonDetailServiceProtocol {
    func fetchPokemonDetail(id: String) -> Observable<PokemonDetailResponse>
}

class PokemonDetailService: PokemonDetailServiceProtocol {

    var disposeBag = DisposeBag()

    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    func fetchPokemonDetail(id: String) -> Observable<PokemonDetailResponse> {
        guard let url = URL(string: baseURL + id) else {
            return Disposables.create() as! Observable<PokemonDetailResponse>
        }
        
        return Observable.create { observer in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(">>> Error - \(self): \n \(error.localizedDescription) ")
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let pokemons = try JSONDecoder().decode(PokemonDetailResponse.self, from: data)
                        
                        observer.onNext(pokemons)
                        print(pokemons)
                        
                        observer.onCompleted()
                    } catch {
                        print(">>> Error - \(self): \n \(error.localizedDescription) ")
                        observer.onError(error)
                    }
                }
            }.resume()
            return Disposables.create()
        }
    }
}
