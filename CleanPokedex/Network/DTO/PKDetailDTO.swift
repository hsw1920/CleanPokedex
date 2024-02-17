//
//  PokemonDetail.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/17.
//

import Foundation

struct PKDetailResponseDTO: Decodable {
    let id: Int
    let name: String
    let sprites: PKSpriteItemResponseDTO
    let types: [PKTypeSlotResponseDTO]
    let stats: [PKStatResponseDTO]
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case sprites
        case types
        case stats
    }
}
