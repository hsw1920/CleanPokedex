//
//  PokeListViewModel.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit

protocol PokeListViewModelInput {
    
}

protocol PokeListViewModelOutput {
    var screenTitle: String  { get }
    var searchBarPlaceholder: String { get }
    var items: [PokeListItem] { get }
}

typealias PokeListViewModel = PokeListViewModelInput & PokeListViewModelOutput



