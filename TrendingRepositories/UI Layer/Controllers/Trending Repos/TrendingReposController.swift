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
	
	@IBOutlet private weak var timeframesControl: UISegmentedControl!
	@IBOutlet private weak var listContainerView: UIView!
	
	private var selectedTimeFrame: TimeFrame = .week
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupReposList()
		setupTimeframsControl()
		viewModel.fetchTrendingRepos(timeFrame: selectedTimeFrame)
	}
	
//	MARK: - Setup Methods
	
	private func setupReposList() {
		reposList = ReposListController(dataProvider: viewModel)
		
		addChild(reposList)
		reposList.didMove(toParent: self)
		listContainerView.addSubview(reposList.collectionView)
		reposList.collectionView.pinEdgesToSuperview()
	}
	
	private func setupTimeframsControl() {
		timeframesControl.addTarget(self, action: #selector(timeframeChanged), for: .valueChanged)
	}
	
	
//	MARK: - Private Methods
	
	@objc private func timeframeChanged() {
		selectedTimeFrame = TimeFrame(rawValue: timeframesControl.selectedSegmentIndex) ?? .week
		viewModel.fetchTrendingRepos(timeFrame: selectedTimeFrame)
	}
	
}
