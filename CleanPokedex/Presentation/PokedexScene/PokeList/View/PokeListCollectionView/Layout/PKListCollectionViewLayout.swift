//
//  PKListCollectionViewLayout.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/20.
//

import UIKit

final class PKListCollectionViewLayout {
    
    static func createLayoutGrid() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let currentSection = PKListSection.allCases[sectionIndex]
            
            switch currentSection {
            case .banner:
                return createSectionBanner()
            case .main:
                return createSectionGrid()
            }
        }
        return layout
    }
    
    static func createLayoutList() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let currentSection = PKListSection.allCases[sectionIndex]
            
            switch currentSection {
            case .banner:
                return createSectionBanner()
            case .main:
                return createSectionList()
            }
        }
        return layout
    }
    
    static func createSectionBanner() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(110.0), heightDimension: .absolute(38.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(38.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10.0)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        return section
    }
    
    static func createSectionList() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10.0)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        return section
    }
    
    static func createSectionGrid() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10.0)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        return section
    }
    
}
