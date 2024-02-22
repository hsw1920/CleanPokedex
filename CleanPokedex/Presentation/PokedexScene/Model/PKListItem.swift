//
//  PokeListItem.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import Foundation

struct PKListItem: Hashable {
    let id: String
    let title: String
    let imageUrl: String
    
    static let mock: [PKListItem] = [
        PKListItem(id: "1", title: "이상해씨", imageUrl: ""),
        PKListItem(id: "2", title: "파이리", imageUrl: ""),
        PKListItem(id: "3", title: "꼬부기", imageUrl: ""),
    ]
}
