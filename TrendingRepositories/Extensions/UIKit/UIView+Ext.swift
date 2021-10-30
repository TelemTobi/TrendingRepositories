//
//  UIView+Ext.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

extension UIView {
	
	static var instance: Self {
		return Bundle.main.loadNibNamed(
			identifier,
			owner: self,
			options: nil
		)?.first as! Self
	}
	
	static var identifier: String {
		let className = "\(self)"
		let components = className.split{$0 == "."}.map ( String.init )
		return components.last!
	}
	
// MARK: - IBInspectables
	
	@IBInspectable var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			clipsToBounds = newValue > 0
		}
	}
	
	@IBInspectable var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}
	
	@IBInspectable var borderColor: UIColor? {
		get {
			return UIColor(cgColor: layer.borderColor!)
		}
		set {
			layer.borderColor = newValue?.cgColor
		}
	}
	
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
