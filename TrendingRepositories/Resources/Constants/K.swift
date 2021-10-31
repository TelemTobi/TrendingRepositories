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
	
	enum Message {
		static let networkError = "A network error has occured"
		static let loadingMore = "Loading more results..."
	}
	
	enum Image {
		static let bookmark = "bookmark"
		static let bookmarkFill = "bookmark.fill"
	}
	
	enum NotificationName {
		static let bookmarksChange = Notification.Name("BookmarksChange")
	}
	
	enum DateFormats: String {
		case yyyyMMdd = "yyyy/MM/dd"
	}
	
	static let Title: [TimeFrame: String] = [
		.week: "Trending this week",
		.month: "Trending this month",
		.year: "Trending this year"
	]
	
	enum RepositoryDetails {
		static let NA = "N/A"
		static let forks = "%d Forks"
		static let stars = "%d Stars"
		static let issues = "%d Open issues"
		static let date = "Created %d days ago at %@"
	}
}
