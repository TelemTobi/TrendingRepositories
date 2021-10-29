//
//  UIView+Ext.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

extension UIView {
	
//	MARK: - Constraints
	
	func pinEdgesToSuperview(padding: UIEdgeInsets = .zero) {
		guard let superView = superview else { return }
		
		anchor(
			top: superView.topAnchor,
			leading: superView.leadingAnchor,
			bottom: superView.bottomAnchor,
			trailing: superView.trailingAnchor,
			padding: padding
		)
	}
	
	func anchor(
		top: NSLayoutYAxisAnchor? = nil,
		leading: NSLayoutXAxisAnchor? = nil,
		bottom: NSLayoutYAxisAnchor? = nil,
		trailing: NSLayoutXAxisAnchor? = nil,
		padding: UIEdgeInsets = .zero) {
		
		translatesAutoresizingMaskIntoConstraints = false
		
		if let top = top {
			self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
		}
		
		if let leading = leading {
			self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
		}
		
		if let bottom = bottom {
			self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
		}
		
		if let trailing = trailing {
			self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
		}
	}
}
