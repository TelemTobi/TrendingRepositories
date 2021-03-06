//
//  TabBarEmbeddedCoordinator.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import UIKit
import SafariServices

class TabBarEmbeddedCoordinator: NSObject, Coordinator {
	
	var childCoordinators: [Coordinator] = []
	var rootViewController: UINavigationController
	
	override init() {
		rootViewController = UINavigationController()
		super.init()
	}
	
	func start() {
		fatalError("Must be overriden")
	}
	
	func pushRepoDetailsController(_ repository: Repository) {
		let repoDetailsController = RepoDetailsController.instantiate(storyboardName: .main)
		repoDetailsController.viewModel = RepoDetailsViewModel(repository: repository)
		
		repoDetailsController.coordinator = self
		repoDetailsController.navigationItem.title = repository.name
		
		rootViewController.hero.isEnabled = true
		rootViewController.pushViewController(repoDetailsController, animated: true)
	}
	
	func presentSafariController(with urlString: String?) {
		guard let url = URL(string: urlString ?? "") else { return }
		
		let vc = SFSafariViewController(url: url)
		vc.delegate = self

		rootViewController.present(vc, animated: true)
	}
	
	func presentShareSheet(_ viewModel: RepoDetailsViewModel?) {
		guard let viewModel = viewModel,
			  let repoLink = URL(string: viewModel.githubUrl)
		else { return }

		let attachedText = String(format: K.Message.shareFormat, viewModel.repoName, viewModel.ownerName)
		let items: [Any] = [attachedText, repoLink]
		let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
		rootViewController.present(activityVC, animated: true)
	}
}

extension TabBarEmbeddedCoordinator: SFSafariViewControllerDelegate {
	
	func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
		rootViewController.dismiss(animated: true)
	}
}
