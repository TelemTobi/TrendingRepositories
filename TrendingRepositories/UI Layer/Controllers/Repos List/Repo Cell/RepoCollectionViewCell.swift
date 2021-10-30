//
//  RepoCollectionViewCell.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import UIKit

class RepoCollectionViewCell: UICollectionViewCell {

	@IBOutlet private weak var containerView: UIStackView!
	
	@IBOutlet private weak var avatarImageView: UIImageView!
	@IBOutlet private weak var fullNameLabel: UILabel!
	@IBOutlet private weak var starsCountLabel: UILabel!
	
	@IBOutlet private weak var languageView: UIStackView!
	@IBOutlet private weak var languageLabel: UILabel!
	
	@IBOutlet private weak var bookmarkButton: UIButton!
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		avatarImageView.image = nil
		bookmarkButton.isHidden = false
	}
	
	func configure(with dataProvider: ReposDataProvider, _ indexPath: IndexPath) {
		guard !dataProvider.isLoading else {
			bookmarkButton.isHidden = true
			containerView.smartShimmer()
			return
		}
		containerView.stopSmartShimmer()
		configure(with: dataProvider.repo(for: indexPath))
	}
	
	private func configure(with repository: Repository) {
		avatarImageView.setImage(with: repository.owner.avatarUrl)
		
		fullNameLabel.text = repository.fullName
		starsCountLabel.text = String(repository.starsCount)
		
		languageView.isHidden = repository.language == nil
		languageLabel.text = repository.language
	}
}
