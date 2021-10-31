//
//  TrendingSectionHeader.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import UIKit

class TitleSectionHeader: UICollectionReusableView {
	
	@IBOutlet weak var titleLabel: UILabel!
	
	var buttonTapCallback: (() -> Void)?
	
	func configure(timeFrame: TimeFrame) {
		titleLabel.text = K.Title[timeFrame]
	}
	
	@IBAction func seeAllButtonTapped(_ sender: Any) {
		buttonTapCallback?()
	}
}
