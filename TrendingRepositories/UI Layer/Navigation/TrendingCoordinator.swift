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
		rootViewController.navigationBar.prefersLargeTitles = true
	}
	
	func start() {
		let trendingReposVC = TrendingReposController.instantiate(storyboardName: .main)
		trendingReposVC.coordinator = self
		rootViewController.pushViewController(trendingReposVC, animated: false)
	}
	
	func pushReposListController(timeFrame: TimeFrame, _ viewModel: TrendingReposViewModel) {
		let initialData = viewModel.repos(for: timeFrame)
		let viewModel = ReposListViewModel(timeFrame: timeFrame, initialData: initialData)
		let reposListController = ReposListController(viewModel: viewModel)
		reposListController.navigationItem.title = viewModel.pageTitle
		rootViewController.pushViewController(reposListController, animated: true)
	}
}
