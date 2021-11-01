//
//  FavoriteReposViewModel.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

class FavoriteReposViewModel: ReposListViewModel {
	
	var isEmpty: Bool {
		repos.count == 0
	}
	
	init() {
		super.init(timeFrame: .week, initialData: UserDefaults.bookmarkedRepos)
		reloadData()
	}
	
	func reloadData() {
		repos = UserDefaults.bookmarkedRepos
		isLoadingPublisher.value = false
	}
	
	override func loadMoreResults() {}
}
