//
//  ReposDataProvider.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

protocol ReposDataProvider: BaseViewModel {
	
	var repos: [Repository] { get }
	var currentPage: Int { get }
	
	func repo(for indexPath: IndexPath) -> Repository
	func loadMoreResults()
}

extension ReposDataProvider {
	
	var currentPage: Int { 1 }
	func loadMoreResults() {}
}
