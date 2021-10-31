//
//  RepoCollectionViewCell.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import UIKit

protocol ReposDataProvider: BaseViewModel {
	
	func numberOfItems(in section: Int) -> Int
	func repo(for indexPath: IndexPath) -> Repository?
	func isLoadingSection(_ section: Int) -> Bool
}

class RepoCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet private weak var avatarImageView: UIImageView!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var bookmarkButton: UIButton!
	
	private var repository: Repository?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		bookmarkButton.setImage(UIImage(systemName: K.Image.bookmark), for: .normal)
		bookmarkButton.setImage(UIImage(systemName: K.Image.bookmarkFill), for: .selected)
	}
	
	func configure(with dataProvider: ReposDataProvider, _ indexPath: IndexPath) {
		guard !dataProvider.isLoadingSection(indexPath.section) else {
			bookmarkButton.isHidden = true
			contentView.smartShimmer()
			return
		}
		contentView.stopSmartShimmer()
		bookmarkButton.isHidden = false
		configure(with: dataProvider.repo(for: indexPath))
	}
	
	private func configure(with repository: Repository?) {
		guard let repository = repository else { return }
		
		self.repository = repository
		
		avatarImageView.setImage(with: repository.owner.avatarUrl)
		avatarImageView.heroID = repository.heroID
		
		nameLabel.text = repository.fullName
		descriptionLabel.text = repository.description
		
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
		NotificationCenter.default.post(name: K.NotificationName.bookmarksChange, object: nil)
	}
}
