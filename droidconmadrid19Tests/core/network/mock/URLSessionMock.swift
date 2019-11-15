//
//  URLSessionMock.swift
//  droidconmadrid19Tests
//
//  Created by vjgarcia on 14/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
	typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
	
	var data: Data?
	var error: Error?
	
	override func dataTask(
		with url: URL,
		completionHandler: @escaping CompletionHandler
	) -> URLSessionDataTask {
		let data = self.data
		let error = self.error
		
		return URLSessionDataTaskMock {
			completionHandler(data, nil, error)
		}
	}
}
