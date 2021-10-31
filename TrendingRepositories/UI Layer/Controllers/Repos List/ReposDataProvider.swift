//
//  ReposDataProvider.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

protocol ReposDataProvider: BaseViewModel {
	
	func isLoadingSection(_ section: Int) -> Bool
	
	func numberOfItems(in section: Int) -> Int
	func repo(for indexPath: IndexPath) -> Repository?
}
