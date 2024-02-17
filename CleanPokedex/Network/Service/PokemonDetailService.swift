//
//  PokemonDetailService.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/15.
//

import Foundation
import RxSwift
import RxCocoa

protocol PokemonDetailServiceProtocol {
    func fetchPokemonDetail() -> Observable<PokemonDetailResponse>
}

final class PokemonDetailService: PokemonDetailServiceProtocol {

    deinit {
        print("deinit - \(self)")
    }
    
    var disposeBag = DisposeBag()

    let baseURL: String = "https://pokeapi.co/api/v2/pokemon/"
    let id: String
    
    init(with id: String) {
        self.id = id
    }
    
    func fetchPokemonDetail() -> Observable<PokemonDetailResponse> {
        guard let url = URL(string: "\(baseURL+id)") else {
            return Observable.error(URLError.init(.unsupportedURL))
        }
        
        return Observable.create { observer in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    print(">>> Error - \(self): \n \(error.localizedDescription) ")
                    observer.onError(error)
                } else if let data {
                    do {
                        let pokemons = try JSONDecoder().decode(PokemonDetailResponse.self, from: data)
                        observer.onNext(pokemons)
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
