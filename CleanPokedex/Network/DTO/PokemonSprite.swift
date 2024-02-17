//
//  PokemonSprite.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/17.
//

import Foundation

struct PokemonSpritesResponse: Decodable {
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
