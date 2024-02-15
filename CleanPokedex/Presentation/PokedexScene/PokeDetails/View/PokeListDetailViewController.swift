//
//  PokeListDetailViewController.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/15.
//

import UIKit
import RxSwift
import RxCocoa

final class PokeListDetailViewController: UIViewController {
    private var viewModel: PokeListDetailViewModel!
    
    var disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    static func create(with viewModel: PokeListDetailViewModel) -> PokeListDetailViewController {
        let view = PokeListDetailViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .red

    }
    
    private func bind(to viewModel: PokeListViewModel) {
        
    }
    
    
}
