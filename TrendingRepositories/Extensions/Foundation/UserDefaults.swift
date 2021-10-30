//
//  UserDefaults.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

extension UserDefaults {
	
	private struct Keys {
		static let bookmarkedRepos = "bookmarkedRepos"
	}
	
	class var bookmarkedRepos: [Repository] {
		guard let decodedData = UserDefaults.standard.object(forKey: Keys.bookmarkedRepos) as? Data
		else { return [] }
		
		return (try? PropertyListDecoder().decode([Repository].self, from: decodedData)) ?? []
	}
	class func set(bookmarkedRepos: [Repository]) {
		if let encodedData = try? PropertyListEncoder().encode(bookmarkedRepos) {
			UserDefaults.standard.set(encodedData, forKey: Keys.bookmarkedRepos)
		}
	}
	
	class func addBookmark(_ repository: Repository) {
		var bookmarks = bookmarkedRepos
		bookmarks.append(repository)
		set(bookmarkedRepos: bookmarks)
	}
	class func removeBookmark(_ repository: Repository) {
		var bookmars = bookmarkedRepos
		bookmars.removeAll(where: { $0 == repository })
		set(bookmarkedRepos: bookmars)
	}
}
