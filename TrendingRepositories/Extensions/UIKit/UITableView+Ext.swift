//
//  UITableView+Ext.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import UIKit

extension UITableView {
	
	public func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
		let className = cellType.className
		let nib = UINib(nibName: className, bundle: bundle)
		register(nib, forCellReuseIdentifier: className)
	}

	public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
		return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
	}
	
	public func reloadDataWithAnimation(animation: RowAnimation = .automatic) {
		
		if numberOfSections > 1 {
			reloadData()
		}
		
		let range = NSMakeRange(0, numberOfSections)
		let sections = NSIndexSet(indexesIn: range)
		reloadSections(sections as IndexSet, with: animation)
	}
	
	public func reachedEnd(offset: CGFloat = 0) -> Bool {
		contentOffset.y > contentSize.height - frame.size.height - offset
	}
}
