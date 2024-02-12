//
//  PokemonService.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation
import RxSwift

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

protocol PokemonServiceProtocol {
    func fetchPokemons() -> Observable<[Pokemon]>
}

class PokemonService: PokemonServiceProtocol {
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
