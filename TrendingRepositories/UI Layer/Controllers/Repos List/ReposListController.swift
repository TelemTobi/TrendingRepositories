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
	weak var coordinator: TabBarEmbeddedCoordinator?
	
	private var subscriptions = Set<AnyCancellable>()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
		registerSubscribers()
	}
	
//	MARK: - Setup Methods
	
	private func setupTableView() {
		tableView.contentInset.bottom = 0
		tableView.tableFooterView?.isHidden = true
		tableView.register(cellType: RepoTableViewCell.self)
	}
	
	private func registerSubscribers() {
		viewModel?.isLoadingPublisher
			.sink { [weak self] _ in
				self?.reloadData()
			}
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
				self?.tableView.tableFooterView?.isHidden = self?.viewModel?.isLoading != true
			} else {
				self?.tableView.reloadDataWithAnimation()
			}
		}
	}
}

//	MARK: - TableView Delegate

extension ReposListController {

	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let repository = viewModel?.repo(for: indexPath) else { return }
		coordinator?.pushRepoDetailsController(repository)
	}
	
	override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		navigationController?.view.endEditing(true)
		
		if viewModel?.isLoading != true, tableView.reachedEnd(offset: 150) {
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
