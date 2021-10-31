//
//  UICollectionView+Ext.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import UIKit

extension UICollectionView {
	
	public enum ReusableViewKind {
		case header
		case footer
		
		var toString: String {
			switch self {
			case .header: return UICollectionView.elementKindSectionHeader
			case .footer: return UICollectionView.elementKindSectionFooter
			}
		}
	}
	
	public func register<T: UICollectionViewCell>(
		cellType: T.Type,
		bundle: Bundle? = nil) {
			
		let className = cellType.className
		let nib = UINib(nibName: className, bundle: bundle)
		register(nib, forCellWithReuseIdentifier: className)
	}
	
	public func register<T: UICollectionReusableView>(
		reusableViewType: T.Type,
		ofKind kind: ReusableViewKind,
		bundle: Bundle? = nil) {
			
		let className = reusableViewType.className
		let nib = UINib(nibName: className, bundle: bundle)
		register(nib, forSupplementaryViewOfKind: kind.toString, withReuseIdentifier: className)
	}

	public func dequeueReusableCell<T: UICollectionViewCell>(
		with type: T.Type,
		for indexPath: IndexPath) -> T {
			
		return self.dequeueReusableCell(
			withReuseIdentifier: type.className,
			for: indexPath
		) as! T
	}
	
	public func dequeueReusableView<T: UICollectionReusableView>(
		with type: T.Type,
		for indexPath: IndexPath,
		ofKind kind: ReusableViewKind = .header) -> T {
			
		return dequeueReusableSupplementaryView(
			ofKind: kind.toString,
			withReuseIdentifier: type.className,
			for: indexPath
		) as! T
	}
	
	public func reachedEnd(offset: CGFloat = 0) -> Bool {
		contentOffset.y > contentSize.height - frame.size.height - offset
	}
	
	public func animatedReload() {
		UIView.transitionSmoothly(from: self, to: self)
		reloadData()
		UIView.transitionSmoothly(from: self, to: self)
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
