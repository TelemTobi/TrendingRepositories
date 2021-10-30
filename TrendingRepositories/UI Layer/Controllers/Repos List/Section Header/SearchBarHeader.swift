//
//  SearchSectionHeader.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import UIKit

class SearchBarHeader: UICollectionReusableView {
	
	@IBOutlet private weak var searchBar: UISearchBar!
	
	weak var delegate: UISearchBarDelegate? {
		didSet {
			searchBar.delegate = delegate
		}
	}
	
}
