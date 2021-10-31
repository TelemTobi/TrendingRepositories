//
//  TrendingCoordinator.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

class TrendingCoordinator: TabBarEmbeddedCoordinator {
	
	override func start() {
		let trendingReposVC = TrendingReposController.instantiate(storyboardName: .main)
		trendingReposVC.coordinator = self
		rootViewController.pushViewController(trendingReposVC, animated: false)
	}
	
	func pushReposListController(timeFrame: TimeFrame, _ viewModel: TrendingReposViewModel) {
		let initialData = viewModel.repos(for: timeFrame)
		let viewModel = ReposListViewModel(timeFrame: timeFrame, initialData: initialData)
		
		let reposListController = ReposListController.instantiate(storyboardName: .main)
		reposListController.viewModel = viewModel
		reposListController.coordinator = self
		reposListController.navigationItem.title = viewModel.pageTitle
		
		rootViewController.hero.isEnabled = false
		rootViewController.pushViewController(reposListController, animated: true)
	}
}
