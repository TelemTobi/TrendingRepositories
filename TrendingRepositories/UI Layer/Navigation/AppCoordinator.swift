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
		
		// add tab bar controller as root vc for this nav controller
		let rootVC = UIViewController()
		rootVC.view.backgroundColor = .red
		rootViewController = UINavigationController(rootViewController: rootVC)
		rootViewController.navigationBar.prefersLargeTitles = true
		
		initChildCoordinators()
	}
	
	private func initChildCoordinators() {
		
	}
	
	func start() {
		window.rootViewController = rootViewController
		window.makeKeyAndVisible()
	}
}
