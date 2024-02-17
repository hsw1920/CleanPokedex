//
//  PokemonStat.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/17.
//

import Foundation

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
