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

	init(decoder: JSONDecoder) {
		self.decoder = decoder
	}
}

extension SessionizeApiClient {

	func getSessions(completion: @escaping (Either<ApiError, [SessionGroup]>) -> Void) {
		guard let getSessionsUrl = URL(string: "\(SessionizeApiClient.sessionizeApiEndpoint)/Sessions") else {
			fatalError()
		}

		URLSession.shared.dataTask(with: getSessionsUrl) { (data, response, error) in
				guard let jsonData = data else {
					DispatchQueue.main.async { completion(Either.left(.generic)) }
					return
				}

				let sessionGroups = try? self.decoder.decode([SessionGroup].self, from: jsonData)

				if let sessionGroups = sessionGroups {
					DispatchQueue.main.async { completion(Either.right(sessionGroups)) }
				} else {
					DispatchQueue.main.async { completion(Either.left(.generic)) }
				}
			}.resume()
	}
}
