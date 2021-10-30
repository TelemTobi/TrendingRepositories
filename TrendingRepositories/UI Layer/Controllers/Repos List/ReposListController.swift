//
//  ReposCollectionViewController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

class ReposListController: UICollectionViewController {
	
	private let searchBarHeaderID = "SearchBarHeader"
	
	private let dataProvider: ReposDataProvider
	
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
		
		registerCells()
		registerSubscribers()
	}
	
//	MARK: - Setup Methods
	
	private func registerCells() {
		collectionView.register(cellType: RepoCollectionViewCell.self)
	}
	
	private func registerSubscribers() {
		
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
}

//	MARK: - CollectionView DataSource

extension ReposListController {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		20
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		collectionView.dequeueReusableCell(with: RepoCollectionViewCell.self, for: indexPath)
	}
	
//	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//		collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: searchBarHeaderID, for: indexPath)
//	}
}

//	MARK: - SearchBar Delegate

extension ReposListController: UISearchBarDelegate {
	
}
