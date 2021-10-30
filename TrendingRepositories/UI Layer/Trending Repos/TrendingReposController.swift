//
//  TrendingReposController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit

class TrendingReposController: UIViewController {
	
	weak var coordinator: TrendingCoordinator?
	
	private var reposCollectionView: ReposCollectionViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let reposCV = segue.destination as? ReposCollectionViewController {
			reposCollectionView = reposCV
		}
	}
	
}
