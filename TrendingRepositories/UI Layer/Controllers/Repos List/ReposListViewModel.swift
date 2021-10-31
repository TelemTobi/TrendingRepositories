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
	var repos: [Repository] = []
	
	private var selectedTimeFrame: TimeFrame = .week
	
	private var searchText: String = ""
	private var filteredRepos: [Repository] = []
	private var isSearchActive: Bool { searchText.count > 1 }
	private var searchWorkItem: DispatchWorkItem!

	var currentPage: Int = 1
	var pageTitle: String { K.TimeFrameTitle[selectedTimeFrame] ?? "" }
	
	init(timeFrame: TimeFrame, initialData: [Repository]) {
		super.init()
		
		selectedTimeFrame = timeFrame
		repos = initialData
		
		setupSearchWorkItem()
	}
	
//	MARK: - Setup Methods
	
	private func setupSearchWorkItem() {
		searchWorkItem = DispatchWorkItem(block: { [weak self] in
			guard let self = self else { return }
			
			self.filteredRepos = self.repos.filter({
				$0.fullName.lowercased().contains(self.searchText.lowercased())
			})
			self.isLoadingPublisher.value = false
		})
	}
	
//	MARK: - Private Methods
	
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
	
//	MARK: - Public Methods
	
	func loadMoreResults() {
		guard !isSearchActive else { return }
		
		isLoadingPublisher.value = true
		fetchRepos(timeFrame: selectedTimeFrame, page: currentPage + 1)
	}
	
	func numberOfItems(in section: Int) -> Int {
		return isSearchActive ? filteredRepos.count : repos.count
	}
	
	func repo(for indexPath: IndexPath) -> Repository? {
		return isSearchActive ? filteredRepos[indexPath.item] : repos[indexPath.item]
	}
	
	func executeSearch(text: String) {
		self.searchText = text
		
		guard isSearchActive else {
			isLoadingPublisher.value = false
			return
		}
		
		DispatchQueue.global(qos: .userInitiated).async(execute: searchWorkItem)
	}
}
