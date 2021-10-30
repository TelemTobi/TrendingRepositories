//
//  UIImageView.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
	
	func setImage(with urlString: String) {
		guard let url = URL(string: urlString) else { return }
		kf.setImage(with: url)
	}
}
