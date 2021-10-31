//
//  K.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import Foundation

struct K {
	
	enum Storyboard: String {
		case main = "Main"
	}
	
	static let Title: [TimeFrame: String] = [
		.week: "Trending this week",
		.month: "Trending this month",
		.year: "Trending this year"
	]
	
	enum Message {
		static let networkError = "A network error has occured"
		static let loadingMore = "Loading more results..."
	}
	
	enum Image {
		static let bookmark = "bookmark"
		static let bookmarkFill = "bookmark.fill"
	}
}
