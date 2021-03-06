//
//  RepoDetailsViewController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import UIKit

class RepoDetailsController: UIViewController {
	
	@IBOutlet private weak var avatarImageView: UIImageView!
	@IBOutlet private weak var ownerNameLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	
	@IBOutlet private weak var languageLabel: UILabel!
	@IBOutlet private weak var forksLabel: UILabel!
	@IBOutlet private weak var starsLabel: UILabel!
	@IBOutlet private weak var issuesLabel: UILabel!
	@IBOutlet private weak var dateLabel: UILabel!
	
	weak var coordinator: TabBarEmbeddedCoordinator?
	var viewModel: RepoDetailsViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupShareButton()
		setupElements()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		navigationController?.hero.isEnabled = false
	}
	
//	MARK: - Setup Methods
	
	private func setupShareButton() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .action,
			target: self,
			action: #selector(shareButtonTapped)
		)
	}
	
	private func setupElements() {
		avatarImageView.setImage(with: viewModel?.avatarUrl ?? "")
		avatarImageView.heroID = viewModel?.heroID
		
		ownerNameLabel.text = viewModel?.ownerName
		descriptionLabel.text = viewModel?.description
		
		languageLabel.text = viewModel?.language
		forksLabel.text = viewModel?.forks
		starsLabel.text = viewModel?.stars
		issuesLabel.text = viewModel?.issues
		dateLabel.text = viewModel?.creationDate
	}
	
//	MARK: - Private Methods
	
	@objc private func shareButtonTapped() {
		coordinator?.presentShareSheet(viewModel)
	}
	
//	MARK: - Interface Builder Actions
	
	@IBAction func githubButtonTapped(_ sender: Any) {
		coordinator?.presentSafariController(with: viewModel?.githubUrl)
	}
	
	@IBAction func profileButtonTapped(_ sender: Any) {
		coordinator?.presentSafariController(with: viewModel?.profileUrl)
	}
}
