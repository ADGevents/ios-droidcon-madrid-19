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
	
	static func favouritesViewModel() -> FavouritesViewModel {
		return FavouritesViewModel(getFavouriteSessions: getFavouriteSession(),
								   mainDispatching: AsyncQueue.main)
	}
	
	static func sessionsViewModel() -> SessionsViewModel {
		return SessionsViewModel(getSessions: getSessions(),
								 mainDispatching: AsyncQueue.main,
								 updateSessionIsStarredValue: updateSessionIsStarredValue())
	}
	
	private static func getFavouriteSession() -> GetFavouriteSessions {
		return GetFavouriteSessions(sessionsBusinessLogic: sessionsBusinessLogic)
	}
	
	private static func getSpeakers() -> GetSpeakers {
		return GetSpeakers(sessionizeRepository: sessionizeRepository)
	}
	
	private static func getSessions() -> GetSessions {
		return GetSessions(sessionsBusinessLogic: sessionsBusinessLogic)
	}
	
	private static let sessionizeRepository = SessionizeRepository(sessionizeApiClient: sessionizeApiClient(),
																   sessionizeDao: sessionizeDao())

	private static let sessionsBusinessLogic = SessionsBusinessLogic(sessionizeRepository: sessionizeRepository)
	
	private static func sessionizeApiClient() -> SessionizeApiClient {
		return SessionizeApiClient(decoder: JSONDecoder(), urlSession: URLSession.shared)
	}
	
	private static func sessionizeDao() -> SessionizeDao {
		return SessionizeDao(sessionizeDb: sessionizeDb())
	}
	
	private static func sessionizeDb() -> SQLiteSessionizeDB {
		return SQLiteSessionizeDB.instance()!
	}
	
	private static func updateSessionIsStarredValue() -> UpdateSessionIsStarredValue {
		return UpdateSessionIsStarredValue(sessionsBusinessLogic: sessionsBusinessLogic)
	}
}
