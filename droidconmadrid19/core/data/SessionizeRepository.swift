//
//  SessionizeRepository.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 08/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation
import Bow
import os

enum SessionizeError {
	case generic
}

class SessionizeRepository {

	private let sessionizeApiClient: SessionizeApiClient
	private let sessionsDao: SessionsDao

	init(sessionizeApiClient: SessionizeApiClient,
		 sessionsDao: SessionsDao) {
		self.sessionizeApiClient = sessionizeApiClient
		self.sessionsDao = sessionsDao
	}
}

extension SessionizeRepository {
	func getSessions(completion: @escaping (Either<SessionizeError, [Session]>) -> Void) {
		sessionsDao.getAll().fold(leftBy: { error in
			getSessionsFromApi(completion: completion)
		}, rightBy: { storedSessions in
			if (storedSessions.count > 0) {
				completion(Either.right(storedSessions))
			} else {
				getSessionsFromApi(completion: completion)
			}
		})
	}

	func getSpeakers(completion: @escaping (Either<SessionizeError, [Speaker]>) -> Void) {
		return sessionizeApiClient.getSpeakers { getSpeakersResult in
			completion(getSpeakersResult.mapLeft { _ in
				return SessionizeError.generic
			})
		}
	}
}

private extension SessionizeRepository {
	func getSessionsFromApi(completion: @escaping (Either<SessionizeError, [Session]>) -> Void) {
		sessionizeApiClient.getSessions { getSessionsResult in
			getSessionsResult.run { sessions in
				self.sessionsDao.insert(sessions: sessions).fold(
					{ error in os_log("Error inserting sessions...") },
					{ os_log("Sessions inserted successfully") }
				)
			}
			completion(getSessionsResult.mapLeft { _ in
				return SessionizeError.generic
			})
		}
	}
}
