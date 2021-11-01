//
//  ConnectionErrorView.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 01/11/2021.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
	func reload()
}

class ConnectionErrorView: UIView {
	
	weak var delegate: ErrorViewDelegate?
	
	@IBOutlet private weak var messageLabel: UILabel!
	
	@IBAction func tryAgainTapped(_ sender: Any) {
		delegate?.reload()
		dismiss()
	}
	
	func show(on superView: UIView, with message: String) {
		messageLabel.text = message
		
		alpha = 0
		transform = .init(scaleX: 1.5, y: 1.5)
		
		superView.addSubview(self)
		pinEdgesToSuperview()
		
		UIView.animate(withDuration: 0.25) {
			self.alpha = 1
			self.transform = .identity
		}
	}
	
	private func dismiss() {
		UIView.animate(withDuration: 0.25) {
			self.alpha = 0
			self.transform = .init(scaleX: 1.5, y: 1.5)
		} completion: { [weak self] _ in
			self?.removeFromSuperview()
		}
	}
	
}
