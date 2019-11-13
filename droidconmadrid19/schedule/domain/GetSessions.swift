//
//  GetSessions.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class GetSessions {

	private let sessionizeApiClient: SessionizeApiClient

	init(sessionizeApiClient: SessionizeApiClient) {
		self.sessionizeApiClient = sessionizeApiClient
	}
}

extension GetSessions {

	func invoke(completion: @escaping (Either<ApiError, [SessionGroup]>) -> Void) {
		sessionizeApiClient.getSessions(completion: completion)
	}
}
