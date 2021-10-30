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
}
