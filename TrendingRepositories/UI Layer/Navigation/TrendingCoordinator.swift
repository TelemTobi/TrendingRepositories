//
//  TrendingCoordinator.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

class TrendingCoordinator: Coordinator {
	
	var childCoordinators: [Coordinator] = []
	var rootViewController: UINavigationController
	
	init() {
		rootViewController = UINavigationController()
	}
	
	func start() {
		let trendingReposVC = TrendingReposController.instantiate(storyboardName: .main)
		trendingReposVC.coordinator = self
		rootViewController.pushViewController(trendingReposVC, animated: false)
	}
	
	func pushReposListController(timeFrame: TimeFrame, _ viewModel: TrendingReposViewModel) {
		let initialData = viewModel.repos(for: timeFrame)
		let viewModel = ReposListViewModel(timeFrame: timeFrame, initialData: initialData)
		
		let reposListController = ReposListController.instantiate(storyboardName: .main)
		reposListController.viewModel = viewModel
		reposListController.navigationItem.title = viewModel.pageTitle
		
		rootViewController.hero.isEnabled = false
		rootViewController.pushViewController(reposListController, animated: true)
	}
	
	func pushRepoDetailsView(_ repository: Repository) {
		let repoDetailsController = RepoDetailsController.instantiate(storyboardName: .main)
		repoDetailsController.viewModel = RepoDetailsViewModel(repository: repository)
		repoDetailsController.navigationItem.title = repository.name
		
		rootViewController.hero.isEnabled = true
		rootViewController.pushViewController(repoDetailsController, animated: true)
	}
}
