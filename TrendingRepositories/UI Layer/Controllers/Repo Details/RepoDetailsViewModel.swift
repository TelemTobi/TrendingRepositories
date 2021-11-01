//
//  RepoDetailsViewModel.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import Foundation

class RepoDetailsViewModel: BaseViewModel {
	
	private let repository: Repository
	
	var avatarUrl: String {
		repository.owner.avatarUrl
	}
	
	var repoName: String {
		repository.name
	}
	
	var ownerName: String {
		repository.owner.name
	}
	
	var description: String? {
		repository.description
	}
	
	var language: String {
		repository.language ?? K.RepositoryDetails.NA
	}
	
	var forks: String {
		String(format: K.RepositoryDetails.forks, repository.forksCount)
	}
	
	var stars: String {
		String(format: K.RepositoryDetails.stars, repository.starsCount)
	}
	
	var issues: String {
		String(format: K.RepositoryDetails.issues, repository.issuesCount)
	}
	
	var githubUrl: String {
		repository.url
	}
	
	var profileUrl: String {
		repository.owner.profileUrl
	}
	
	var heroID: String {
		repository.heroID
	}
	
	var creationDate: String {
		let date = repository.creationDate.toDate() ?? Date()
		let dateString = date.toString(format: "dd/MM/yyy")
		return String(format: K.RepositoryDetails.date, date.daysPassed(), dateString)
	}
	
	init(repository: Repository) {
		self.repository = repository
		
	}
}
