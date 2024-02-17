//
//  Pokemon.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/17.
//

import Foundation

struct PKListResponseDTO: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PKContentResponseDTO]
}

struct PKContentResponseDTO: Decodable {
    let name: String
    let url: String
}
