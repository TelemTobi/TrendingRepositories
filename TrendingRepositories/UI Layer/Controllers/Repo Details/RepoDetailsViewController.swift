//
//  RepoDetailsViewController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 31/10/2021.
//

import UIKit

class RepoDetailsController: UIViewController {
	
	@IBOutlet weak var avatarImageView: UIImageView!
	
	var viewModel: RepoDetailsViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		avatarImageView.setImage(with: viewModel?.repository.owner.avatarUrl ?? "")
		avatarImageView.heroID = viewModel?.repository.heroID
	}
}
