//
//  PokeListViewModel.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/11.
//

import UIKit
import RxSwift
import RxCocoa

protocol PokeListViewDelegate {
    func didTapDetailCell(with id: String)
}

final class PKListViewModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let viewWillAppear: Observable<Void>
        let searchBarTextEvent: Observable<String>
        let didTapDetailCell: Observable<IndexPath>
        let updateNextPokeList: Observable<Void>
    }

    struct Output {
        // "Usecase에게 받고, View에게 줄 수 있어야함" & "View의 TableView UI 요소임" -> Relay를 써야함이 마땅하다.
        var items: BehaviorRelay<[PKListItem]> = BehaviorRelay<[PKListItem]>(value: [])
        let screenTitle: Observable<String> = .just("Pokedex")
        let searchBarPlaceholder: Observable<String> = .just("Search results")
    }

    private let pokeListUseCase: PKListUseCase
    
    private weak var coordinator: PKListFlowCoordinator?
    
    private var disposeBag = DisposeBag()
    
    // MARK: Init
    init(
        coordinator: PKListFlowCoordinator?,
        pokeListUseCase: PKListUseCase
    ) {
        self.coordinator = coordinator
        self.pokeListUseCase = pokeListUseCase
    }
    
    deinit {
        print("deinit - \(self)")
    }

    // MARK: Transform
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewDidLoad
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.pokeListUseCase.fetchPokeList()
            })
            .disposed(by: disposeBag)
        
        input.viewWillAppear
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                print(">>> PKListVC : viewWillAppear")
            })
            .disposed(by: disposeBag)
        
        input.searchBarTextEvent
            .withUnretained(self)
            .flatMapLatest { owner, text in
                return owner.pokeListUseCase.filterPokeList(with: text)
            }
            .bind(to: output.items)
            .disposed(by: disposeBag)
        
        input.didTapDetailCell
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                owner.coordinator?.didTapDetailCell(with: output.items.value[indexPath.row].id)
            })
            .disposed(by: disposeBag)

        input.updateNextPokeList
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.pokeListUseCase.fetchNextPokeList()
            })
            .disposed(by: disposeBag)
        return output
    }
}
