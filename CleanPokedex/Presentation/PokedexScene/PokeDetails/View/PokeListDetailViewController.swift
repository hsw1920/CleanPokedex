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
    
    private lazy var pokemonImageView: UIImageView = {
        let imgView = UIImageView(image: .none)
        return imgView
    }()
    
    private let idLabel: UILabel = UILabel()
    private let nameLabel: UILabel = UILabel()
    private let hpLabel: UILabel = UILabel()
    private let attackLabel: UILabel = UILabel()
    private let defenseLabel: UILabel = UILabel()
    private let specialAttackLabel: UILabel = UILabel()
    private let specialDefenseLabel: UILabel = UILabel()
    private let speedLabel: UILabel = UILabel()
    
    private lazy var id: UILabel = UILabel()
    private lazy var name: UILabel = UILabel()
    private lazy var hp: UILabel = UILabel()
    private lazy var attack: UILabel = UILabel()
    private lazy var defense: UILabel = UILabel()
    private lazy var specialAttack: UILabel = UILabel()
    private lazy var specialDefense: UILabel = UILabel()
    private lazy var speed: UILabel = UILabel()
    
    private let idStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let hpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let attackStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let defenseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let specialAttackStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let specialDepensestackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let speedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private var viewModel: PokeListDetailViewModel!
    
    var disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    static func create(with viewModel: PokeListDetailViewModel) -> PokeListDetailViewController {
        let view = PokeListDetailViewController()
        view.viewModel = viewModel
        return view
    }
    
    deinit {
        print("deinit - \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind(to: viewModel)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        [idLabel, id].forEach {
            idStackView.addArrangedSubview($0)
        }
        
        [nameLabel, name].forEach {
            nameStackView.addArrangedSubview($0)
        }
        
        [hpLabel, hp].forEach {
            hpStackView.addArrangedSubview($0)
        }
        
        [attackLabel, attack].forEach {
            attackStackView.addArrangedSubview($0)
        }
        
        [defenseLabel, defense].forEach {
            defenseStackView.addArrangedSubview($0)
        }
        
        [specialAttackLabel, specialAttack].forEach { specialAttackStackView.addArrangedSubview($0)
        }
        
        [specialDefenseLabel, specialDefense].forEach { specialDepensestackView.addArrangedSubview($0)
        }
        
        [speedLabel, speed].forEach {
            speedStackView.addArrangedSubview($0)
        }
        
        [idStackView, nameStackView, hpStackView, attackStackView, defenseStackView, specialAttackStackView, specialDepensestackView, speedStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        idLabel.text = "ID:"
        nameLabel.text = "NAME:"
        hpLabel.text = "HP:"
        attackLabel.text = "ATTACK:"
        defenseLabel.text = "DEFENSE:"
        specialAttackLabel.text = "SPECIAL-ATTACK:"
        specialDefenseLabel.text = "SPECIAL-DEFENSE:"
        speedLabel.text = "SPEED:"
    }
    
    private func bind(to viewModel: PokeListDetailViewModel) {
        let input = PokeListDetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.screenTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.id
            .bind(to: id.rx.text)
            .disposed(by: disposeBag)
        
        output.name
            .bind(to: name.rx.text)
            .disposed(by: disposeBag)
        
        output.hp
            .bind(to: hp.rx.text)
            .disposed(by: disposeBag)
        
        output.attack
            .bind(to: attack.rx.text)
            .disposed(by: disposeBag)
        
        output.defense
            .bind(to: defense.rx.text)
            .disposed(by: disposeBag)
        
        output.specialAttack
            .bind(to: specialAttack.rx.text)
            .disposed(by: disposeBag)
        
        
        output.specialDefense
            .bind(to: specialDefense.rx.text)
            .disposed(by: disposeBag)
        
        output.spped
            .bind(to: speed.rx.text)
            .disposed(by: disposeBag)
    }

}
