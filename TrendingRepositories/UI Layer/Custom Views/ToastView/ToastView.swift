//
//  ToastView.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import UIKit

class ToastView: UIView {
	
	enum ToastDuration {
		case short
		case long
		case fixed
	}
	
	private var duration: ToastDuration = .short
	private let animationTime: Double = 0.3
	
	@IBOutlet private weak var messageLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		isHidden = true
	}
	
	func show(inside container: UIView,
			  with message: String,
			  duration: ToastDuration) {
		
		self.duration = duration
		messageLabel.text = message
		
		container.addSubview(self)
		anchor(
			leading: container.safeAreaLayoutGuide.leadingAnchor,
			bottom: container.safeAreaLayoutGuide.bottomAnchor,
			trailing: container.safeAreaLayoutGuide.trailingAnchor,
			padding: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
		)
		
		if duration != .fixed {
			addPanGesture()
		}
		
		animateIn()
	}
	
	func dismiss() {
		animateOut()
	}
	
//	MARK: - Private Methods
	
	private func addPanGesture() {
		let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onToastDrag))
		addGestureRecognizer(panGestureRecognizer)
	}
	
	private func animateIn() {
		alpha = 0
		isHidden = false
		
		UIView.animate(withDuration: animationTime) {
			self.alpha = 1
		} completion: { (_) in
			self.beatAnimation(completion: { [weak self] in
				guard self?.duration != .fixed else { return }
				self?.animateOut(delay: self?.duration == .short ? 2 : 8)
			})
		}
	}
	
	private func animateOut(delay: Double = 0) {
		DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
			UIView.animate(withDuration: self.animationTime) {
				self.alpha = 0
				self.transform.ty = self.frame.height * 2
			} completion: { [weak self] _ in
				self?.removeFromSuperview()
			}
		}
	}
	
	@objc private func onToastDrag(sender: UIPanGestureRecognizer) {
		let threshold = frame.size.height * 0.5
		let translatedPoint = CGPoint(x: sender.translation(in: self).x, y: sender.translation(in: self).y)
		let velocityY = sender.velocity(in: self).y * 0.5
		let finalY = translatedPoint.y + velocityY
		let hasCrossedThreshold = finalY > threshold
		
		transform.ty = min(
			max(CGAffineTransform.identity.ty, translatedPoint.y),
			frame.maxY
		)
		
		guard sender.state == .ended else { return }
		
		if hasCrossedThreshold {
			self.animateOut()
		} else {
			UIView.animate(withDuration: animationTime) {
				self.transform = .identity
			}
		}
	}
	
}
