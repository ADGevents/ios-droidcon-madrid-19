//
//  SessionizeApiClient.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class SessionizeApiClient {
	private static let sessionizeApiEndpoint = "https://my-json-server.typicode.com/JorgeMucientes/demo"
	private let decoder: JSONDecoder

	init(decoder: JSONDecoder) {
		self.decoder = decoder
	}
}

extension SessionizeApiClient {

	func getSessions(completion: @escaping (Either<ApiError, [SessionGroup]>) -> Void) {
		guard let getSessionsUrl = URL(string: "\(SessionizeApiClient.sessionizeApiEndpoint)/sessions") else {
			fatalError()
		}

		URLSession.shared.dataTask(with: getSessionsUrl) { (data, response, error) in
			DispatchQueue.main.async {
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
			}
			}.resume()
	}
}
