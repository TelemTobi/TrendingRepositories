//
//  ReposDataProvider.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

protocol ReposDataProvider: BaseViewModel {
	
	var repos: [Repository] { get }
	
	func repo(for indexPath: IndexPath) -> Repository
}
