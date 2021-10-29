//
//  ReposCollectionViewController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

class ReposCollectionViewController: UICollectionViewController {
	
	let searchBarHeaderID = "SearchBarHeader"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionLayout()
	}
	
	private func setupCollectionLayout() {
		var config = UICollectionLayoutListConfiguration(appearance: .grouped)
		config.showsSeparators = false
		config.headerMode = .supplementary
		config.backgroundColor = .systemBackground
		let layout = UICollectionViewCompositionalLayout.list(using: config)
		collectionView.collectionViewLayout = layout
		
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
	}
}

//	MARK: - CollectionView Delegate

extension ReposCollectionViewController {

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
	override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
		
	}
	
	override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
		
	}
}

//	MARK: - CollectionView DataSource

extension ReposCollectionViewController {
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		20
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
	}
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: searchBarHeaderID, for: indexPath)
	}
}

//	MARK: - SearchBar Delegate

extension ReposCollectionViewController: UISearchBarDelegate {
	
}
