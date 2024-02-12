//
//  PokeListItemCell.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/12.
//

import UIKit

final class PokeListItemCell: UITableViewCell {
    static let reuseIdentifier = String(describing: PokeListItemCell.self)
    static let height = CGFloat(130)
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    func configure(item: PokeListItem){
        numberLabel.text = item.number
        titleLabel.text = item.title
    }
}
