//
//  RepoCollectionViewCell.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import UIKit

class RepoCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet private weak var avatarImageView: UIImageView!
	@IBOutlet private weak var fullNameLabel: UILabel!
	@IBOutlet private weak var starsCountLabel: UILabel!
	
	@IBOutlet private weak var languageView: UIStackView!
	@IBOutlet private weak var languageLabel: UILabel!
	
	@IBOutlet private weak var bookmarkButton: UIButton!
	
	private var repository: Repository?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		bookmarkButton.setImage(UIImage(systemName: K.Image.bookmark), for: .normal)
		bookmarkButton.setImage(UIImage(systemName: K.Image.bookmarkFill), for: .selected)
	}
	
	func configure(with dataProvider: ReposDataProvider, _ indexPath: IndexPath) {
		guard !dataProvider.isLoading else {
			bookmarkButton.isHidden = true
			contentView.smartShimmer()
			return
		}
		contentView.stopSmartShimmer()
		bookmarkButton.isHidden = false
		configure(with: dataProvider.repo(for: indexPath))
	}
	
	private func configure(with repository: Repository) {
		self.repository = repository
		
		avatarImageView.setImage(with: repository.owner.avatarUrl)
		
		fullNameLabel.text = repository.fullName
		starsCountLabel.text = String(repository.starsCount)
		
		languageView.isHidden = repository.language == nil
		languageLabel.text = repository.language
		
		bookmarkButton.isSelected = UserDefaults.bookmarkedRepos.contains(repository)
	}
	
	@IBAction func bookmarkButtonTapped(_ sender: Any) {
		guard let repository = repository else { return }
		
		if bookmarkButton.isSelected {
			UserDefaults.removeBookmark(repository)
		} else {
			UserDefaults.addBookmark(repository)
		}
		
		bookmarkButton.isSelected = !bookmarkButton.isSelected
	}
}
