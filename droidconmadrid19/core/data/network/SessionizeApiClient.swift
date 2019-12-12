//
//  SessionizeApiClient.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class SessionizeApiClient {
	private static let sessionizeApiEndpoint = "http://ec2-54-213-45-43.us-west-2.compute.amazonaws.com"
	
	private let decoder: JSONDecoder
	private let urlSession: URLSession
	
	init(decoder: JSONDecoder,
		 urlSession: URLSession) {
		self.decoder = decoder
		self.urlSession = urlSession
	}
}

extension SessionizeApiClient {
	
	func getSessions(completion: @escaping (Either<ApiError, [SessionData]>) -> Void) {
		get(rawUrl: "\(SessionizeApiClient.sessionizeApiEndpoint)/sessions", completion: completion)
	}
	
	func getSpeakers(completion: @escaping (Either<ApiError, [Speaker]>) -> Void) {
		get(rawUrl: "\(SessionizeApiClient.sessionizeApiEndpoint)/speakers", completion: completion)
	}
}

private extension SessionizeApiClient {
	func get<T: Codable>(rawUrl: String, completion: @escaping (Either<ApiError, T>) -> Void) {
		guard let url = URL(string: rawUrl) else {
			fatalError()
		}
		
		urlSession.dataTask(with: url) { (data, response, error) in
			guard let jsonData = data else {
				completion(Either.left(.generic))
				return
			}
			
			let responseModel = try? self.decoder.decode(T.self, from: jsonData)
			
			if let responseModel = responseModel {
				completion(Either.right(responseModel))
			} else {
				completion(Either.left(.generic))
			}
		}.resume()
	}
}
