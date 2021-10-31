//
//  FavoriteReposController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit
import Combine

class FavoriteReposController: UIViewController {
	
	weak var coordinator: FavoritesCoordinator?
	
	private let viewModel = FavoriteReposViewModel()
	private var subscriptions = Set<AnyCancellable>()
	
	private var reposList: ReposListController!
	
	@IBOutlet private weak var listContainerView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupReposList()
		registerSubscribers()
	}
	
//	MARK: - Setup Methods
	
	private func setupReposList() {
		reposList = ReposListController(viewModel: viewModel)
		
		addChild(reposList)
		reposList.didMove(toParent: self)
		listContainerView.addSubview(reposList.collectionView)
		reposList.collectionView.pinEdgesToSuperview()
	}
	
	private func registerSubscribers() {
		NotificationCenter.default
			.publisher(for: K.NotificationName.bookmarksChange, object: nil)
			.sink(receiveValue: { [weak self] _ in
				self?.viewModel.reloadData()
			})
			.store(in: &subscriptions)
	}
}
