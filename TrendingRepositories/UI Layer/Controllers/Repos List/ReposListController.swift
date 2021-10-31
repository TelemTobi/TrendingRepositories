//
//  ReposCollectionViewController.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 29/10/2021.
//

import UIKit
import Combine

class ReposListController: UITableViewController {
	
	var viewModel: ReposListViewModel?
	private var subscriptions = Set<AnyCancellable>()
	
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
		registerSubscribers()
	}
	
//	MARK: - Setup Methods
	
	private func setupTableView() {
		tableView.register(cellType: RepoTableViewCell.self)
		tableView.tableFooterView?.isHidden = viewModel?.shouldLoadMoreResults != true
	}
	
	private func registerSubscribers() {
		viewModel?.isLoadingPublisher
			.sink { [weak self] _ in self?.reloadData() }
			.store(in: &subscriptions)
		
		viewModel?.errorMsgPublisher
			.sink(receiveValue: { [weak self] message in
				self?.showToast(with: message, duration: .short)
			})
			.store(in: &subscriptions)
	}
	
//	MARK: - Private Methods
	
	private func reloadData() {
		DispatchQueue.main.async { [weak self] in
			if (self?.viewModel?.currentPage ?? 0) > 1 {
				self?.tableView.reloadData()
			} else {
				self?.tableView.reloadDataWithAnimation()
			}
		}
	}
}

//	MARK: - TableView Delegate

extension ReposListController {

	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
	override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		navigationController?.view.endEditing(true)
		
		if viewModel?.shouldLoadMoreResults == true, tableView.reachedEnd(offset: 150) {
			viewModel?.loadMoreResults()
		}
	}
}

//	MARK: - TableView DataSource

extension ReposListController {
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.numberOfItems(in: section) ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(with: RepoTableViewCell.self, for: indexPath)
		cell.configure(with: viewModel, indexPath)
		return cell
	}
}

//	MARK: - SearchBar Delegate

extension ReposListController: UISearchBarDelegate {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		navigationController?.view.endEditing(true)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel?.executeSearch(text: searchText)
	}
}
