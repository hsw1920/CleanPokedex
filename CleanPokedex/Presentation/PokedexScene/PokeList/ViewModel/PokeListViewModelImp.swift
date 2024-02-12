//
//  PokeListViewModelImp.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit

final class PokeListViewModelImp: PokeListViewModel {
    let screenTitle: String = "title"
    let searchBarPlaceholder: String = "Search results"
    let items: [PokeListItem] = PokeListItem.mock
}
