//
//  FavouritesViewModel.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 09/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation
import RxSwift

class FavouritesViewModel {

	private let disposeBag = DisposeBag()

	var sessions: [SessionViewModel] = [] {
		didSet {
			mainDispatching.dispatch { [weak self] in
				self?.sessionsUpdatedCallback()
			}
		}
	}
	var sessionsUpdatedCallback: () -> Void = {}

	private let getFavouriteSessions: GetFavouriteSessions
	private let mainDispatching: Dispatching

	init(getFavouriteSessions: GetFavouriteSessions,
		 mainDispatching: Dispatching) {
		self.getFavouriteSessions = getFavouriteSessions
		self.mainDispatching = mainDispatching
	}
}

extension FavouritesViewModel {
	func onFavouritesVisible() {
		getFavouriteSessions.invoke().subscribe(onNext:{
			self.onGetFavouritesSuccess(sessions: $0)
		}).disposed(by: disposeBag)
	}
}

private extension FavouritesViewModel {
	func onGetFavouritesSuccess(sessions: [Session]) {
		self.sessions = sessions.map {
			SessionViewModel(session: $0, isBookmarkingEnabled: false)
		}
	}
}
