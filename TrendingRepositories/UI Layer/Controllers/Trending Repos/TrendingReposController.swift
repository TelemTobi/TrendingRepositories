//
//  TrendingReposController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

class TrendingReposController: UIViewController {
	
	weak var coordinator: TrendingCoordinator?
	
	private let viewModel = TrendingReposViewModel()
	private var reposList: ReposListController!
	
	@IBOutlet private weak var timeframeControl: UISegmentedControl!
	@IBOutlet private weak var listContainerView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupReposList()
	}
	
//	MARK: - Setup Methods
	
	private func setupReposList() {
		reposList = ReposListController(dataProvider: viewModel)
		
		addChild(reposList)
		reposList.didMove(toParent: self)
		listContainerView.addSubview(reposList.collectionView)
		reposList.collectionView.pinEdgesToSuperview()
	}
	
}
