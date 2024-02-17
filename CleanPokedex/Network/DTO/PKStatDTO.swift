//
//  PokemonStat.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/17.
//

import Foundation

struct PKStatResponseDTO: Decodable {
    let baseStat: Int
    let stat: PKStatDetailResponseDTO
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct PKStatDetailResponseDTO: Decodable {
    let name: String
    enum CodingKeys: CodingKey {
        case name
    }
}
