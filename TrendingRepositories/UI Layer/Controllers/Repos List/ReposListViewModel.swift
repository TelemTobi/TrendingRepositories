//
//  ReposListViewModel.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import Foundation
import Combine
import Moya

class ReposListViewModel: BaseViewModel {

	private let provider = MoyaProvider<Github>()
	private var selectedTimeFrame: TimeFrame = .week
	private var repos: [Repository] = []
	
	var isLoadingMorePublisher = CurrentValueSubject<Bool, Never>(false)
	var currentPage: Int = 1
	
	var pageTitle: String { K.Title[selectedTimeFrame] ?? "" }
	
	init(timeFrame: TimeFrame, initialData: [Repository]) {
		super.init()
		
		selectedTimeFrame = timeFrame
		repos = initialData
	}
	
	private func fetchRepos(timeFrame: TimeFrame, page: Int = 1) {
		selectedTimeFrame = timeFrame
		currentPage = page
		
		if currentPage == 1 {
			isLoadingPublisher.value = true
			repos = []
		}
		
		provider.request(.searchRepositories(timeFrame, currentPage)) { [weak self] result in
			guard let self = self else { return }
			
			defer { self.isLoadingPublisher.value = false }
			
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
		isLoadingPublisher.value = true
		fetchRepos(timeFrame: selectedTimeFrame, page: currentPage + 1)
	}
}
	
extension ReposListViewModel: ReposDataProvider {
	
	func isLoadingSection(_ section: Int) -> Bool {
		return false
	}
	
	func numberOfItems(in section: Int) -> Int {
		return repos.count
	}
	
	func repo(for indexPath: IndexPath) -> Repository? {
		return repos[indexPath.item]
	}
}
