//
//  ServiceLocator.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 05/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class ServiceLocator {

	static func speakersViewModel() -> SpeakersViewModel {
		return SpeakersViewModel(getSpeakers: getSpeakers(), mainDispatching: AsyncQueue.main)
	}

	static func sessionsViewModel() -> SessionsViewModel {
		return SessionsViewModel(getSessions: getSessions(),
								 mainDispatching: AsyncQueue.main)
	}

	private static func getSpeakers() -> GetSpeakers {
		return GetSpeakers(sessionizeRepository: sessionizeRepository())
	}
	
	private static func getSessions() -> GetSessions {
		return GetSessions(sessionizeApiClient: sessionizeApiClient())
	}

	private static func sessionizeRepository() -> SessionizeRepository {
		return SessionizeRepository(sessionizeApiClient: sessionizeApiClient())
	}
	
	private static func sessionizeApiClient() -> SessionizeApiClient {
		return SessionizeApiClient(decoder: JSONDecoder(), urlSession: URLSession.shared)
	}
}
