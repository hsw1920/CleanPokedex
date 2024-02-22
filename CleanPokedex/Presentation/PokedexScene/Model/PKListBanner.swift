//
//  PKListBanner.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/21.
//

import Foundation

struct PKListBanner: Hashable {
    let id: String
    let title: String
    
    static let mock: [PKListBanner] = [
        PKListBanner(id: "0", title: "리스트로 보기"),
        PKListBanner(id: "1", title: "격자로 보기"),
    ]
}
