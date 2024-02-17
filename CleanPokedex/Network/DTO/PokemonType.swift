//
//  PokemonType.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/17.
//

import Foundation

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
