//
//  CodableResponses.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

struct GithubResponse<T: Codable>: Codable {
	let items: [T]
}
