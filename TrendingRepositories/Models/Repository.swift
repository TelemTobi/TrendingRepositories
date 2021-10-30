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
	var description: String?
	let url: String
	let owner: Owner

	let starsCount: Int
	let forksCount: Int
	let watchersCount: Int
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case description
		case url
		case owner
		case fullName = "full_name"
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
