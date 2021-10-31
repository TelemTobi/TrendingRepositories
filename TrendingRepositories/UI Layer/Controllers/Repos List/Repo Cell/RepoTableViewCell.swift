//
//  RepoTableViewCell.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import UIKit
import Hero

class RepoTableViewCell: UITableViewCell {
	
	@IBOutlet private weak var avatarImageView: UIImageView!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var bookmarkButton: UIButton!
	
	private var repository: Repository?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		selectionStyle = .none
		bookmarkButton.setImage(UIImage(systemName: K.Image.bookmark), for: .normal)
		bookmarkButton.setImage(UIImage(systemName: K.Image.bookmarkFill), for: .selected)
	}
	
	func configure(with viewModel: ReposListViewModel?, _ indexPath: IndexPath) {
		guard let viewModel = viewModel else { return }
		configure(with: viewModel.repo(for: indexPath))
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
	
	@IBAction func bookmarkedButtonTapped(_ sender: Any) {
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
