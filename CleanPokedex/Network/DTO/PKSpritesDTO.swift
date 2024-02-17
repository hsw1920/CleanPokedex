//
//  PokemonSprite.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/17.
//

import Foundation

struct PKSpritesResponseDTO: Decodable {
    let sprites: PKSpriteItemResponseDTO
    
    enum CodingKeys: String, CodingKey {
        case sprites
    }
}

struct PKSpriteItemResponseDTO: Decodable {
    let `default`: String
    enum CodingKeys: String, CodingKey {
        case `default` = "front_default"
    }
}
