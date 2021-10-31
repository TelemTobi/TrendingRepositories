//
//  String+Ext.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import Foundation

extension String {
	
	func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.date(from: self)
	}
}
