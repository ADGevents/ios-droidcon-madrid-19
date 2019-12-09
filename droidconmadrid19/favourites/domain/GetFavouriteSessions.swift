//
//  GetFavouriteSessions.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 09/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class GetFavouriteSessions {
	private let sessionizeRepository: SessionizeRepository

	init(sessionizeRepository: SessionizeRepository) {
		self.sessionizeRepository = sessionizeRepository
	}
}

extension GetFavouriteSessions {

	func invoke(completion: @escaping (Either<SessionizeError, [Session]>) -> Void) {
		sessionizeRepository.getFavouriteSessions(completion: completion)
	}
}
