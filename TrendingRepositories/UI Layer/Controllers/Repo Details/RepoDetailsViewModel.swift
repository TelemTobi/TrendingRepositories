//
//  RepoDetailsViewModel.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import Foundation

class RepoDetailsViewModel: BaseViewModel {
	
	let repository: Repository
	
	init(repository: Repository) {
		self.repository = repository
		
		
	}
}
