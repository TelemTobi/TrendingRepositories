//
//  Date+Ext.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

extension Date {
	
	func toString(format: String = "YYYY-MM-dd") -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: self)
	}
	
	func daysPassed() -> Int {
		return Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
	}
}
