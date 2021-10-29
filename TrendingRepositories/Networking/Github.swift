//
//  Github.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import Foundation
import Moya

public enum TimeFrame {
	case week
	case month
	case year
}

extension TimeFrame {
	var dateString: String {
		var timeComponent: Calendar.Component
		
		switch self {
		case .week: timeComponent = .weekOfMonth
		case .month: timeComponent = .month
		case .year: timeComponent = .year
		}
		
		let date = Calendar.current.date(
			byAdding: timeComponent,
			value: -1,
			to: Date()
		) ?? Date()
		return date.toString()
	}
}

public enum Github {
	case searchRepositories(TimeFrame, Int)
}

extension Github: TargetType {
	
	public var baseURL: URL {
		return URL(string: "https://api.github.com")!
	}
	
	public var path: String {
		switch self {
		case .searchRepositories: return "/search/repositories"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .searchRepositories: return .get
		}
	}
	
	public var task: Task {
		switch self {
		case .searchRepositories(let timeFrame, let page):
			return .requestParameters(
				parameters: [
					"q": "created:>=\(timeFrame.dateString)",
					"sort": "stars",
					"order": "desc",
					"per_page": "50",
					"page": "\(page)"
				],
				encoding: URLEncoding.default
			)
		}
	}
	
	public var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	public var validationType: ValidationType {
		return .successCodes
	}
}
