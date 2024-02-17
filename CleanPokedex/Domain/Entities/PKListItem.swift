//
//  PokeListItem.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation

struct PKListItem {
    let number: String
    let title: String
    let imageUrl: PKSpriteItemResponseDTO
    
    static let mock: [PKListItem] = [
        PKListItem(number: "1", title: "이상해씨", imageUrl: .init(default: "")),
        PKListItem(number: "2", title: "파이리", imageUrl: .init(default: "")),
        PKListItem(number: "3", title: "꼬부기", imageUrl: .init(default: "")),
    ]
}