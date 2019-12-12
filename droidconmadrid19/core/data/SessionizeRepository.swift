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
	private let sessionizeDao: SessionizeDao

	init(sessionizeApiClient: SessionizeApiClient,
		 sessionizeDao: SessionizeDao) {
		self.sessionizeApiClient = sessionizeApiClient
		self.sessionizeDao = sessionizeDao
	}
}

// MARK: Sessions

extension SessionizeRepository {

	func getSessions(completion: @escaping (Either<SessionizeError, [SessionData]>) -> Void) {
		sessionizeDao.getSessions().fold(leftBy: { error in
			getSessionsFromApi(completion: completion)
		}, rightBy: { storedSessions in
			if (storedSessions.count > 0) {
				completion(Either.right(storedSessions))
			} else {
				getSessionsFromApi(completion: completion)
			}
		})
	}

	func getFavouriteSessions(completion: @escaping (Either<SessionizeError, [SessionData]>) -> Void) {
		completion(sessionizeDao.getFavouriteSessions().mapLeft { _ in return .generic})
	}

	func updateSessionIsStarredValue(sessionId: String, isStarred: Bool) -> Try<Void> {
		return sessionizeDao.updateSessionStarredValue(sessionId: sessionId, isStarred: isStarred)
	}

	private func getSessionsFromApi(completion: @escaping (Either<SessionizeError, [SessionData]>) -> Void) {
		sessionizeApiClient.getSessions { getSessionsResult in
			getSessionsResult.run { sessions in
				self.sessionizeDao.insertSessions(sessions: sessions).fold(
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

// MARK: Speakers

extension SessionizeRepository {

	func getSpeakers(completion: @escaping (Either<SessionizeError, [Speaker]>) -> Void) {
		sessionizeDao.getSpeakers().fold(leftBy: { error in
			getSpeakersFromApi(completion: completion)
		}, rightBy: { storedSpeakers in
			if (storedSpeakers.count > 0) {
				completion(Either.right(storedSpeakers))
			} else {
				getSpeakersFromApi(completion: completion)
			}
		})
	}

	private func getSpeakersFromApi(completion: @escaping (Either<SessionizeError, [Speaker]>) -> Void) {
		return sessionizeApiClient.getSpeakers { getSpeakersResult in
			getSpeakersResult.run { speakers in
				self.sessionizeDao.insertSpeakers(speakers: speakers).fold(
					{ error in os_log("Error inserting speakers...") },
					{ os_log("Speakers inserted successfully") }
				)
			}
			completion(getSpeakersResult.mapLeft { _ in
				return SessionizeError.generic
			})
		}
	}
}
