//
//  PokeListItemCell.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import UIKit
import Kingfisher

final class PokeListItemCell: UITableViewCell {
    static let reuseIdentifier = String(describing: PokeListItemCell.self)
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pokeImageView: UIImageView = {
        let imageView = UIImageView(image: .add)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(pokeImageView)
        
        NSLayoutConstraint.activate([
            pokeImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 10),
            pokeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pokeImageView.heightAnchor.constraint(equalToConstant: 100),
            pokeImageView.widthAnchor.constraint(equalToConstant: 100),

            numberLabel.topAnchor.constraint(greaterThanOrEqualTo: pokeImageView.bottomAnchor, constant: 10),
            numberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }

    func configure(item: PokeListItem){
        numberLabel.text = item.number
        titleLabel.text = item.title
    
        pokeImageView.kf.setImage(with: URL(string: item.imageUrl.default))
//        pokeImageView.kf.setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png"))
    }
}
