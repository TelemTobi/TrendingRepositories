//
//  BaseViewModel.swift
//  TrendingRepositories
//
//  Created by Telem Tobi on 30/10/2021.
//

import Foundation
import Combine

class BaseViewModel {
	
	let isLoadingPublisher = CurrentValueSubject<Bool, Never>(false)
	let errorMsgPublisher = PassthroughSubject<String, Never>()
	
	var isLoading: Bool { isLoadingPublisher.value == true }
	
	deinit {
		print("Deinitialized viewmodel \(self)")
	}
}
