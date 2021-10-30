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
	
	func hideKeyboardWhenTappedAround() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	@discardableResult
	func showToast(with message: String, duration: ToastView.ToastDuration) -> ToastView {
		let toastView = ToastView.instance
		toastView.show(inside: view, with: message, duration: duration)
		return toastView
	}
}


