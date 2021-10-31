//
//  FavoriteReposViewModel.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

class FavoriteReposViewModel: BaseViewModel {
	
	private var repos: [Repository] = []
	
	func numberOfItems(in section: Int) -> Int {
		5
	}
	
	func repo(for indexPath: IndexPath) -> Repository? {
		return repos[indexPath.item]
	}
}
