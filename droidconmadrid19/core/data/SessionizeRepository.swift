//
//  SessionizeRepository.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 08/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

enum SessionizeError {
	case generic
}

class SessionizeRepository {

	private let sessionizeApiClient: SessionizeApiClient

	init(sessionizeApiClient: SessionizeApiClient) {
		self.sessionizeApiClient = sessionizeApiClient
	}
}

extension SessionizeRepository {
	func getSessions(completion: @escaping (Either<SessionizeError, [SessionGroup]>) -> Void) {
		return sessionizeApiClient.getSessions { getSessionsResult in
			completion(getSessionsResult.mapLeft { _ in
				return SessionizeError.generic
			})
		}
	}

	func getSpeakers(completion: @escaping (Either<SessionizeError, [Speaker]>) -> Void) {
		return sessionizeApiClient.getSpeakers { getSpeakersResult in
			completion(getSpeakersResult.mapLeft { _ in
				return SessionizeError.generic
			})
		}
	}
}
