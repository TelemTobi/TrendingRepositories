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
	
	var isLoadingSection = CurrentValueSubject<[Bool], Never>([Bool](repeating: false, count: 3))
	
	func isLoadingSection(_ section: Int) -> Bool {
		return isLoadingSection.value[section]
	}
	
	func repos(for timeFrame: TimeFrame) -> [Repository] {
		return repos[timeFrame] ?? []
	}
	
	func fetchTrendingRepos() {
		fetchRepos(timeFrame: .week)
		fetchRepos(timeFrame: .month)
		fetchRepos(timeFrame: .year)
	}
	
	func fetchRepos(timeFrame: TimeFrame) {
		isLoadingSection.value[timeFrame.rawValue] = true
		
		provider.request(.searchRepositories(timeFrame, 1)) { [weak self] result in
			guard let self = self else { return }

			defer { self.isLoadingSection.value[timeFrame.rawValue] = false }

			switch result {
			case .success(let response):
				do {
					let newRepos = try response.map(GithubResponse<Repository>.self).items
					self.repos[timeFrame] = newRepos
				} catch {
					self.errorMsgPublisher.send(K.Message.networkError)
				}
			case .failure:
				self.errorMsgPublisher.send(K.Message.networkError)
			}
		}
	}
}
	
extension TrendingReposViewModel: ReposDataProvider {
	
	func numberOfItems(in section: Int) -> Int {
		let timeFrame = TimeFrame(rawValue: section) ?? .week
		return repos(for: timeFrame).count
	}
	
	func repo(for indexPath: IndexPath) -> Repository? {
		let timeFrame = TimeFrame(rawValue: indexPath.section) ?? .week
		return repos(for: timeFrame)[indexPath.item]
	}
}
