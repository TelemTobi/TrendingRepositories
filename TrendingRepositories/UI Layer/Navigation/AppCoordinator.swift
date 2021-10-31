//
//  ApplicationCoordinator.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

class AppCoordinator: Coordinator {
	
	var childCoordinators: [Coordinator] = []
	var rootViewController: UINavigationController
	
	let window: UIWindow
	
	init(window: UIWindow) {
		self.window = window
		
		let mainTabBarVC = MainTabBarController.instantiate(storyboardName: .main)
		rootViewController = UINavigationController(rootViewController: mainTabBarVC)
		rootViewController.setNavigationBarHidden(true, animated: false)
		mainTabBarVC.coordinator = self
		
		initChildCoordinators()
	}
	
	private func initChildCoordinators() {
		childCoordinators = [TrendingCoordinator(), FavoritesCoordinator()]
		
		childCoordinators.forEach {
			$0.rootViewController.navigationBar.prefersLargeTitles = true
			$0.rootViewController.hero.isEnabled = true
			$0.rootViewController.heroNavigationAnimationType = .fade
		}
	}
	
	func start() {
		window.rootViewController = rootViewController
		window.makeKeyAndVisible()
		
		childCoordinators.forEach { $0.start() }
	}
}
