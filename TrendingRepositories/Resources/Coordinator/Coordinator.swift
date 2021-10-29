//
//  Coordinator.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

protocol Coordinator {
	
	var childCoordinators: [Coordinator] { get set }
	var rootViewController: UINavigationController { get }
	
	func start()
}
