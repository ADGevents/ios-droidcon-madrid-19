//
//  SessionizeApiClient.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class SessionizeApiClient {
	private static let sessionizeApiEndpoint = "https://sessionize.com/api/v2/jl4ktls0/view"

	private let decoder: JSONDecoder
	private let urlSession: URLSession

	init(decoder: JSONDecoder,
		 urlSession: URLSession) {
		self.decoder = decoder
		self.urlSession = urlSession
	}
}

extension SessionizeApiClient {

	func getSessions(completion: @escaping (Either<ApiError, [SessionGroup]>) -> Void) {
		guard let getSessionsUrl = URL(string: "\(SessionizeApiClient.sessionizeApiEndpoint)/Sessions") else {
			fatalError()
		}

		urlSession.dataTask(with: getSessionsUrl) { (data, response, error) in
			guard let jsonData = data else {
				completion(Either.left(.generic))
				return
			}

			let sessionGroups = try? self.decoder.decode([SessionGroup].self, from: jsonData)

			if let sessionGroups = sessionGroups {
				completion(Either.right(sessionGroups))
			} else {
				completion(Either.left(.generic))
			}
		}.resume()
	}

	func getSpeakers(completion: @escaping (Either<ApiError, [Speaker]>) -> Void) {
		guard let getSpeakersUrl = URL(string: "\(SessionizeApiClient.sessionizeApiEndpoint)/Speakers") else {
			fatalError()
		}

		urlSession.dataTask(with: getSpeakersUrl) { (data, response, error) in
			guard let jsonData = data else {
				completion(Either.left(.generic))
				return
			}

			let speakers = try? self.decoder.decode([Speaker].self, from: jsonData)

			if let speakers = speakers {
				completion(Either.right(speakers))
			} else {
				completion(Either.left(.generic))
			}
		}.resume()
	}
}
