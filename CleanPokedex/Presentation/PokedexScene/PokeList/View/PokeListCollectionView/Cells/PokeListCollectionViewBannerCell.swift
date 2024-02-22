//
//  PokeListCollectionViewBannerCell.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/21.
//

import UIKit

final class PokeListCollectionViewBannerCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: PokeListCollectionViewBannerCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViews()
    }
    
    private func setupViews() {
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = contentView.frame.height / 2
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    func configure(item: PKListBanner){
        titleLabel.text = item.title
    }
}
