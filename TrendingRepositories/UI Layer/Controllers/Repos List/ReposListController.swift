//
//  ReposCollectionViewController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit
import Combine

class ReposListController: UICollectionViewController {
	
	private let dataProvider: ReposDataProvider
	private var subscriptions = Set<AnyCancellable>()
	
	init(dataProvider: ReposDataProvider) {
		self.dataProvider = dataProvider
		
		let config = UICollectionLayoutListConfiguration.baseConfiguration
		let layout = UICollectionViewCompositionalLayout.list(using: config)
		super.init(collectionViewLayout: layout)
		
		collectionView.contentInsetAdjustmentBehavior = .automatic
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		registerReusableViews()
		registerSubscribers()
	}
	
//	MARK: - Setup Methods
	
	private func registerReusableViews() {
		collectionView.register(reusableViewType: SearchBarHeader.self)
		collectionView.register(cellType: RepoCollectionViewCell.self)
	}
	
	private func registerSubscribers() {
		dataProvider.isLoadingPublisher
			.sink { [weak self] _ in self?.reloadData() }
			.store(in: &subscriptions)
		
		dataProvider.errorMsgPublisher
			.sink(receiveValue: { print($0) })
			.store(in: &subscriptions)
	}
	
//	MARK: - Private Methods
	
	private func reloadData() {
		collectionView.reloadData()
		collectionView.setContentOffset(.zero, animated: true)
	}
}

//	MARK: - CollectionView Delegate

extension ReposListController {

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
	override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
		
	}
	
	override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
		
	}
	
	override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
	}
}

//	MARK: - CollectionView DataSource

extension ReposListController {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		dataProvider.isLoading ? 20 : dataProvider.repos.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let repoCell = collectionView.dequeueReusableCell(with: RepoCollectionViewCell.self, for: indexPath)
		repoCell.configure(with: dataProvider, indexPath)
		return repoCell
	}
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let searchBarHeader = collectionView.dequeueReusableView(with: SearchBarHeader.self, for: indexPath)
		searchBarHeader.delegate = self
		return searchBarHeader
	}
}

//	MARK: - SearchBar Delegate

extension ReposListController: UISearchBarDelegate {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
	}
}
