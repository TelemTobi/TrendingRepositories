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
	
	@IBOutlet private weak var listContainerView: UIView!
	
	private var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionView()
		registerSubscribers()
		
		viewModel.fetchTrendingRepos()
	}
	
//	MARK: - Setup Methods
	
	private func setupCollectionView() {
		let layout = TrendingReposLayout.create()
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		
		listContainerView.addSubview(collectionView)
		collectionView.pinEdgesToSuperview()
		
		collectionView.delegate = self
		collectionView.dataSource = self
		
		collectionView.register(cellType: RepoCollectionViewCell.self)
		collectionView.register(reusableViewType: TitleSectionHeader.self, ofKind: .header)
	}
	
	private func registerSubscribers() {
		viewModel.isLoadingSection
			.sink(receiveValue: { [weak self] _ in
				self?.collectionView.animatedReload()
			})
			.store(in: &subscriptions)
		
		NotificationCenter.default
			.publisher(for: K.NotificationName.bookmarksChange, object: nil)
			.sink(receiveValue: { [weak self] _ in
				self?.collectionView.animatedReload()
			})
			.store(in: &subscriptions)
	}
}

//	MARK: - CollectionView Data Source

extension TrendingReposController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.isLoadingSection(section) ? 9 : viewModel.numberOfItems(in: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let repoCell = collectionView.dequeueReusableCell(with: RepoCollectionViewCell.self, for: indexPath)
		repoCell.configure(with: viewModel, indexPath)
		return repoCell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let timeFrame = TimeFrame(rawValue: indexPath.section) ?? .week
		let titleHeader = collectionView.dequeueReusableView(with: TitleSectionHeader.self, for: indexPath)
		
		titleHeader.configure(timeFrame: timeFrame)
		titleHeader.buttonTapCallback = { [weak self] in
			guard let self = self else { return }
			self.coordinator?.pushReposListController(timeFrame: timeFrame, self.viewModel)
		}
		
		return titleHeader
	}
}

//	MARK: - CollectionView Delegate

extension TrendingReposController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let repository = viewModel.repo(for: indexPath) else { return }
		coordinator?.pushRepoDetailsView(repository)
	}
}
