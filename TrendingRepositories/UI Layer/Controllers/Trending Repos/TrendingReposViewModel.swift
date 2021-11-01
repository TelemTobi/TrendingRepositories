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
	private var repos: [TimeFrame: [Repository]] = [:]
	
	private var loadingSections = [Bool](repeating: false, count: 3)
	
//	MARK: - Private Methods
	
	private func fetchRepos(timeFrame: TimeFrame) {
		loadingSections[timeFrame.rawValue] = true
		
		provider.request(.searchRepositories(timeFrame, 1)) { [weak self] result in
			guard let self = self else { return }

			switch result {
			case .success(let response):
				do {
					let newRepos = try response.map(GithubResponse<Repository>.self).items
					self.repos[timeFrame] = newRepos
					
					self.loadingSections[timeFrame.rawValue] = false
					self.isLoadingPublisher.value = false
				} catch {
					self.errorMsgPublisher.send(K.Message.networkError)
				}
			case .failure:
				self.errorMsgPublisher.send(K.Message.networkError)
			}
		}
	}
	
//	MARK: - Public Methods
	
	func repos(for timeFrame: TimeFrame) -> [Repository] {
		return repos[timeFrame] ?? []
	}
	
	func fetchTrendingRepos() {
		isLoadingPublisher.value = true
		
		fetchRepos(timeFrame: .week)
		fetchRepos(timeFrame: .month)
		fetchRepos(timeFrame: .year)
	}
	
	func isLoadingSection(_ section: Int) -> Bool {
		return loadingSections[section]
	}
	
	func numberOfItems(in section: Int) -> Int {
		let timeFrame = TimeFrame(rawValue: section) ?? .week
		return repos(for: timeFrame).count
	}
	
	func repo(for indexPath: IndexPath) -> Repository? {
		let timeFrame = TimeFrame(rawValue: indexPath.section) ?? .week
		return repos(for: timeFrame)[indexPath.item]
	}
}
