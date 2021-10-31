//
//  MainTabBarController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

class MainTabBarController: UITabBarController {
	
	weak var coordinator: AppCoordinator?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewControllers = coordinator?.childCoordinators.map { $0.rootViewController }
	}
}
