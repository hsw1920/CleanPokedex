//
//  PokemonType.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/17.
//

import Foundation

struct PKTypeSlotResponseDTO: Decodable {
    let slot: Int
    let type: PKTypeResponseDTO
    
    enum CodingKeys: CodingKey {
        case slot
        case type
    }
}

struct PKTypeResponseDTO: Decodable {
    let name: String
    enum CodingKeys: CodingKey {
        case name
    }
}
