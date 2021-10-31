//
//  ReposCollectionViewController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit
import Combine

class ReposListController: UICollectionViewController {
	
	private let viewModel: ReposListViewModel
	private var subscriptions = Set<AnyCancellable>()
	
	private weak var showingToast: ToastView?
	
	init(viewModel: ReposListViewModel) {
		self.viewModel = viewModel
		
		let config = UICollectionLayoutListConfiguration.baseConfiguration
		let layout = UICollectionViewCompositionalLayout.list(using: config)
		super.init(collectionViewLayout: layout)
		
		navigationItem.title = viewModel.pageTitle
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionView()
		registerSubscribers()
	}
	
//	MARK: - Setup Methods
	
	private func setupCollectionView() {
		collectionView.showsVerticalScrollIndicator = false
		collectionView.contentInsetAdjustmentBehavior = .automatic
		
		collectionView.register(cellType: RepoCollectionViewCell.self)
		collectionView.register(reusableViewType: SearchBarHeader.self, ofKind: .header)
	}
	
	private func registerSubscribers() {
		viewModel.isLoadingPublisher
			.sink { [weak self] _ in
				self?.collectionView.reloadData()
				self?.showingToast?.dismiss()
			}
			.store(in: &subscriptions)
		
		viewModel.errorMsgPublisher
			.sink(receiveValue: { [weak self] in
				self?.showToast(with: $0, duration: .short)
			})
			.store(in: &subscriptions)
	}
}

//	MARK: - CollectionView Delegate

extension ReposListController {

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
	override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if !viewModel.isLoading, collectionView.reachedEnd(offset: 50) {
			showingToast = showToast(with: K.Message.loadingMore, duration: .fixed)
			viewModel.loadMoreResults()
		}
	}
}

//	MARK: - CollectionView DataSource

extension ReposListController {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.numberOfItems(in: section)
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let repoCell = collectionView.dequeueReusableCell(with: RepoCollectionViewCell.self, for: indexPath)
		repoCell.configure(with: viewModel, indexPath)
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
