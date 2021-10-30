//
//  TrendingReposController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit
import Combine

class TrendingReposController: UIViewController {
	
	weak var coordinator: TrendingCoordinator?
	
	private let viewModel = TrendingReposViewModel()
	private var subscriptions = Set<AnyCancellable>()
	
	@IBOutlet private weak var timeframesControl: UISegmentedControl!
	@IBOutlet private weak var listContainerView: UIView!
	
	private var reposList: ReposListController!
	private var selectedTimeFrame: TimeFrame = .week
	private weak var showingToast: ToastView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupReposList()
		setupTimeframsControl()
		registerSubscribers()
		
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
	
	private func registerSubscribers() {
		viewModel.isLoadingMorePublisher
			.removeDuplicates()
			.sink { [weak self] _ in self?.handleLoadingToast() }
			.store(in: &subscriptions)
	}
	
	
//	MARK: - Private Methods
	
	@objc private func timeframeChanged() {
		selectedTimeFrame = TimeFrame(rawValue: timeframesControl.selectedSegmentIndex) ?? .week
		viewModel.fetchTrendingRepos(timeFrame: selectedTimeFrame)
	}
	
	private func handleLoadingToast() {
		if viewModel.isLoadingMorePublisher.value {
			showingToast = showToast(with: K.Message.loadingMore, duration: .fixed)
		} else {
			showingToast?.dismiss()
		}
	}
}
