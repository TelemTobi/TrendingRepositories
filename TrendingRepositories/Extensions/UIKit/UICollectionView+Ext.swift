//
//  UICollectionView+Ext.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import UIKit

extension UICollectionView {
	
	public func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
		let className = cellType.className
		let nib = UINib(nibName: className, bundle: bundle)
		register(nib, forCellWithReuseIdentifier: className)
	}

	public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
		return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
	}
	
	public func reachedEnd(withOffset offset: CGFloat = 0) -> Bool {
		contentOffset.y > contentSize.height - frame.size.height - offset
	}
}

extension UICollectionLayoutListConfiguration {
	
	static var baseConfiguration: UICollectionLayoutListConfiguration {
		var config = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
		config.showsSeparators = false
		config.headerMode = .supplementary
		config.backgroundColor = .systemBackground
		config.headerTopPadding = 0
		return config
	}
}
