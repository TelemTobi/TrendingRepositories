//
//  Repository.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

struct Repository: Codable {
	
	let id: Int
	let name: String
	let fullName: String
	let url: String
	let owner: Owner
	let creationDate: String
	
	var language: String?
	var description: String?
	
	let starsCount: Int
	let forksCount: Int
	let watchersCount: Int
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case fullName = "full_name"
		case url = "html_url"
		case owner
		case creationDate = "created_at"
		case language
		case description
		case starsCount = "stargazers_count"
		case forksCount = "forks_count"
		case watchersCount = "watchers_count"
	}
}

extension Repository {
	
	struct Owner: Codable {
		let id: Int
		let name: String
		let avatarUrl: String
		let profileUrl: String
		
		enum CodingKeys: String, CodingKey {
			case id
			case name = "login"
			case avatarUrl = "avatar_url"
			case profileUrl = "html_url"
		}
	}
}

extension Repository: Equatable {
	
	static func == (lhs: Repository, rhs: Repository) -> Bool {
		return lhs.id == rhs.id
	}
}
