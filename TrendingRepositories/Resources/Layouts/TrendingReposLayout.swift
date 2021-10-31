//
//  TrendingReposLayout.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import Foundation
import UIKit

class TrendingReposLayout {

	static func create() -> UICollectionViewLayout {
		
		let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

			let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(67)))
			item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
			let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
			
			let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),  heightDimension: .absolute(225))
			let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize, subitems: [group])
			containerGroup.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 24)
  
			let section = NSCollectionLayoutSection(group: containerGroup)
			section.orthogonalScrollingBehavior = .groupPagingCentered
			section.contentInsets = .init(top: 0, leading: 0, bottom: 24, trailing: 0)

			let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
			let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
			headerElement.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 8, trailing: 8)
			section.boundarySupplementaryItems = [headerElement]
			
			return section
		}
		return layout
	}
}
