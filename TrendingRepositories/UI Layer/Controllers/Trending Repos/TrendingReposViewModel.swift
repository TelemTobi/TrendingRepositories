//
//  TrendingReposViewModel.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation
import Moya

class TrendingReposViewModel: BaseViewModel, ReposDataProvider {

	var repos: [Repository] = []
	
	private let provider = MoyaProvider<Github>()
	
	private var currentPage: Int = 1
	
	func fetchTrendingRepos(timeFrame: TimeFrame) {
		isLoadingPublisher.value = true
		
		provider.request(.searchRepositories(timeFrame, currentPage)) { [weak self] result in
			guard let self = self else { return }
			
			defer { self.isLoadingPublisher.value = false }
			
			switch result {
			case .success(let response):
				do {
					self.repos = try response.map(GithubResponse<Repository>.self).items
				} catch {
					self.errorMsgPublisher.send(K.Message.networkError)
				}
			case .failure:
				self.errorMsgPublisher.send(K.Message.networkError)
			}
		}
	}
	
	func repo(for indexPath: IndexPath) -> Repository {
		return repos[indexPath.item]
	}
}
