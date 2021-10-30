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

// MARK: - Loop
	
	func loopViewHierarchy(block: ((_ view: UIView) -> Bool)?) {
		
		if block?(self) ?? true {
			for subview in subviews {
				subview.loopViewHierarchy(block: block)
			}
		}
	}

//	MARK: - Shimmer Loader
	
	public func smartShimmer() {
		addLoader(self, start: true)
	}
	
	public func stopSmartShimmer() {
		addLoader(self, start: false)
	}
	
	private func addLoader(_ view: UIView, start: Bool) {
		view.layoutIfNeeded()

		for subView in view.subviews {
			if subView.subviews.count > 0 && !(subView is UIStackView) {
				self.addLoader(subView, start: start)
			} else {
				DispatchQueue.main.async { [weak self] in
					self?.animateShimmer(view: subView, start: start)
				}
			}
		}
	}
	
	private func animateShimmer(view: UIView, start: Bool, repeatCount: Float = .infinity) {
		
		if start {
			
			isUserInteractionEnabled = false
			
			let firstColor: CGFloat = traitCollection.userInterfaceStyle == .dark ? 0.42 : 0.92
			let secondColor: CGFloat = traitCollection.userInterfaceStyle == .dark ? 0.46 : 0.96
			
			// 1. Add Color Layer
			let colorLayer = CALayer()
			colorLayer.backgroundColor = UIColor(white: firstColor, alpha: 1).cgColor
			colorLayer.frame = view.bounds
			colorLayer.name = "colorLayer"
			view.layer.addSublayer(colorLayer)
			view.autoresizesSubviews = true
			if view.cornerRadius == 0, !(view is UIImageView) {
				view.cornerRadius = 5
			}
			
			// 2. Add loader Layer
			let gradientLayer = CAGradientLayer()
			gradientLayer.colors = [
				UIColor(white: firstColor, alpha: 1).cgColor,
				UIColor(white: secondColor, alpha: 1).cgColor,
				UIColor(white: firstColor, alpha: 1).cgColor
			]
			gradientLayer.locations = [0,0.4,0.8, 1]
			gradientLayer.name = "loaderLayer"
			gradientLayer.startPoint = CGPoint(x: 0.0, y: view is UIImageView ? 0.4 : 0.5)
			gradientLayer.endPoint = CGPoint(x: 1.0, y: view is UIImageView ? 0.6 : 0.5)
			gradientLayer.frame = view.bounds
			view.layer.addSublayer(gradientLayer)
			
			// 3. Animate loader layer
			let animation = CABasicAnimation(keyPath: "locations")
			animation.duration = 1.2
			animation.fromValue = [-1.0, -0.6, -0.2, 0]
			animation.toValue = [1.0, 1.4, 1.8, 2]
			animation.repeatCount = repeatCount
			gradientLayer.add(animation, forKey: "smartLoader")
		}
		else {
			isUserInteractionEnabled = true
			
			if let smartLayers = view.layer.sublayers?.filter({$0.name == "colorLayer" || $0.name == "loaderLayer"}) {
				smartLayers.forEach({$0.removeFromSuperlayer()})
			}
		}
	}
}
