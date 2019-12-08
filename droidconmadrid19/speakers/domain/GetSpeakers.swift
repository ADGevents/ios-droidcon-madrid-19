//
//  GetSpeakers.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 08/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class GetSpeakers {
	private let sessionizeRepository: SessionizeRepository

	init(sessionizeRepository: SessionizeRepository) {
		self.sessionizeRepository = sessionizeRepository
	}
}

extension GetSpeakers {

	func invoke(completion: @escaping (Either<SessionizeError, [Speaker]>) -> Void) {
		sessionizeRepository.getSpeakers(completion: completion)
	}
}
