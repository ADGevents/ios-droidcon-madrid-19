//
//  GetSessions.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class GetSessions {
	
	private let sessionizeRepository: SessionizeRepository
	
	init(sessionizeRepository: SessionizeRepository) {
		self.sessionizeRepository = sessionizeRepository
	}
}

extension GetSessions {
	
	func invoke(completion: @escaping (Either<SessionizeError, [Session]>) -> Void) {
		sessionizeRepository.getSessions(completion: completion)
	}
}
