//
//  PokemonDetail.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/17.
//

import Foundation

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
