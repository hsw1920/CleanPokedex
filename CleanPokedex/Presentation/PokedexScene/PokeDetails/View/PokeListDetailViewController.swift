//
//  PokeListDetailViewController.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/15.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class PokeListDetailViewController: UIViewController {
    
    private lazy var pokemonImageView: UIImageView = {
        let imgView = UIImageView(image: .none)
        imgView.translatesAutoresizingMaskIntoConstraints = false
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
    private let typeLabel: UILabel = UILabel()
    
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
    
    private let typesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 24
        return stackView
    }()
    
    private let typesDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 4
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
        
        [typeLabel, typesDataStackView].forEach {
            typesStackView.addArrangedSubview($0)
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
        
        [idStackView, nameStackView, typesStackView, hpStackView, attackStackView, defenseStackView, specialAttackStackView, specialDepensestackView, speedStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(pokemonImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            pokemonImageView.heightAnchor.constraint(equalToConstant: 200),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 200),
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -16),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
        
        idLabel.text = "도감번호"
        nameLabel.text = "이름"
        hpLabel.text = "체력"
        attackLabel.text = "공격"
        defenseLabel.text = "방어"
        specialAttackLabel.text = "특수공격"
        specialDefenseLabel.text = "특수방어"
        speedLabel.text = "스피드"
        typeLabel.text = "타입"
    }
    
    private func bind(to viewModel: PokeListDetailViewModel) {
        let input = PokeListDetailViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in }
        )
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
        
        output.speed
            .bind(to: speed.rx.text)
            .disposed(by: disposeBag)
        
        output.image
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, image in
                guard let url = URL(string: image) else { return }
                owner.pokemonImageView.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)
        
        output.types
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] types in
                guard let self = self else { return }
                types.forEach { item in
                    let label = UILabel()
                    label.text = item
                    self.typesDataStackView.addArrangedSubview(label)
                }
            })
            .disposed(by: disposeBag)
    }

}
