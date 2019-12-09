//
//  SessionsBusinessLogic.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 09/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation
import RxSwift

class SessionsBusinessLogic {

	private var sessions: [Session] = [] {
		didSet {
			sessionsStream.onNext(sessions)
		}
	}

	private var fetchingSessions = false

	private var stream: Observable<[Session]> {
		if (sessions.count == 0 && !fetchingSessions) {
			fetchingSessions = true
			sessionizeRepository.getSessions { getSessionsResult in
				getSessionsResult.fold(
					leftBy: {_ in self.fetchingSessions = false },
					rightBy:  { sessions in
						self.fetchingSessions = false
						self.sessions = sessions
				})
			}
		}
		return sessionsStream
	}

	private let sessionsStream = BehaviorSubject<[Session]>(value: [])
	private let sessionizeRepository: SessionizeRepository

	init(sessionizeRepository: SessionizeRepository) {
		self.sessionizeRepository = sessionizeRepository
	}
}

extension SessionsBusinessLogic {
	
	func getAll() -> Observable<[Session]> {
		return stream
	}

	func getFavourites() -> Observable<[Session]> {
		return stream.map { sessions in
			sessions.compactMap { session in
				if (session.isStarred ?? false) {
					return session
				} else {
					return nil
				}
			}
		}
	}

	func updateStarredValue(sessionId: String, isStarred: Bool) {
		sessionizeRepository.updateSessionIsStarredValue(sessionId: sessionId, isStarred: isStarred).fold(
			{_ in },
			{_ in
				self.sessions = self.sessions.map {
					if ($0.id == sessionId) {
						return $0.copy(isStarred: isStarred)
					} else {
						return $0
					}
				}
		})
	}
}
