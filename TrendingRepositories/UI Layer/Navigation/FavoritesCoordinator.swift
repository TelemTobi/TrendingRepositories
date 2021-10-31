//
//  FavoritesCoordinator.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

class FavoritesCoordinator: Coordinator {
	
	var childCoordinators: [Coordinator] = []
	var rootViewController: UINavigationController
	
	init() {
		rootViewController = UINavigationController()
	}
	
	func start() {
		let favoriteReposVC = FavoriteReposController.instantiate(storyboardName: .main)
		favoriteReposVC.coordinator = self
		rootViewController.pushViewController(favoriteReposVC, animated: false)
	}
	
	func pushRepoDetailsController(_ repository: Repository) {
		let repoDetailsController = RepoDetailsController.instantiate(storyboardName: .main)
		repoDetailsController.viewModel = RepoDetailsViewModel(repository: repository)
		repoDetailsController.navigationItem.title = repository.name
		
		rootViewController.hero.isEnabled = true
		rootViewController.pushViewController(repoDetailsController, animated: true)
	}
}
