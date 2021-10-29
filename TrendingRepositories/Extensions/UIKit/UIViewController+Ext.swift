//
//  UIViewController+Ext.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

extension UIViewController {
	
	static var identifier: String {
		let className = "\(self)"
		let components = className.split{$0 == "."}.map ( String.init )
		return components.last!
	}
	
	static func instantiate(storyboardName: K.Storyboard) -> Self {
		return UIStoryboard(name: storyboardName.rawValue, bundle: nil)
			.instantiateViewController(withIdentifier: identifier) as! Self
	}
}


