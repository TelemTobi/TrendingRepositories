//
//  FavoritesCoordinator.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

class FavoritesCoordinator: TabBarEmbeddedCoordinator {
	
	override func start() {
		let favoriteReposVC = FavoriteReposController.instantiate(storyboardName: .main)
		favoriteReposVC.coordinator = self
		rootViewController.pushViewController(favoriteReposVC, animated: false)
	}
}
