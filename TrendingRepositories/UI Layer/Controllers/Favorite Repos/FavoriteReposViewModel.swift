//
//  FavoriteReposViewModel.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

class FavoriteReposViewModel: BaseViewModel, ReposDataProvider {
	
	var repos: [Repository] = []
	
	func repo(for indexPath: IndexPath) -> Repository {
		return repos[indexPath.item]
	}
}
