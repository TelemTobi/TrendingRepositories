//
//  ClassName.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation

public protocol ClassNameProtocol {
	static var className: String { get }
	var className: String { get }
}

public extension ClassNameProtocol {
	
	static var className: String {
		return String(describing: self)
	}

	var className: String {
		return type(of: self).className
	}
}

extension NSObject: ClassNameProtocol {}
