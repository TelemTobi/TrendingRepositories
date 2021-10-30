//
//  TrendingReposViewModel.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation
import Combine
import Moya

class TrendingReposViewModel: BaseViewModel {

	private let provider = MoyaProvider<Github>()
	private var selectedTimeFrame: TimeFrame = .week
	
	var isLoadingMorePublisher = CurrentValueSubject<Bool, Never>(false)
	var currentPage: Int = 1
	var repos: [Repository] = []
	
	func fetchTrendingRepos(timeFrame: TimeFrame, page: Int = 1) {
		selectedTimeFrame = timeFrame
		currentPage = page
		
		if currentPage == 1 {
			isLoadingPublisher.value = true
			repos = []
		}
		
		provider.request(.searchRepositories(timeFrame, currentPage)) { [weak self] result in
			guard let self = self else { return }
			
			defer {
				self.isLoadingPublisher.value = false
				self.isLoadingMorePublisher.value = false
			}
			
			switch result {
			case .success(let response):
				do {
					let newRepos = try response.map(GithubResponse<Repository>.self).items
					self.repos.append(contentsOf: newRepos)
				} catch {
					self.errorMsgPublisher.send(K.Message.networkError)
				}
			case .failure:
				self.errorMsgPublisher.send(K.Message.networkError)
			}
		}
	}
	
	func loadMoreResults() {
		guard !isLoadingMorePublisher.value else { return }
		
		isLoadingMorePublisher.value = true
		fetchTrendingRepos(timeFrame: selectedTimeFrame, page: currentPage + 1)
	}
	
	func repo(for indexPath: IndexPath) -> Repository {
		return repos[indexPath.item]
	}
}
