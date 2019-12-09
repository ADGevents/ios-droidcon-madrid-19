//
//  GetFavouriteSessions.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 09/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation
import RxSwift

class GetFavouriteSessions {
	private let sessionsBusinessLogic: SessionsBusinessLogic

	init(sessionsBusinessLogic: SessionsBusinessLogic) {
		self.sessionsBusinessLogic = sessionsBusinessLogic
	}
}

extension GetFavouriteSessions {

	func invoke() -> Observable<[Session]> {
		return sessionsBusinessLogic.getFavourites()
	}
}
