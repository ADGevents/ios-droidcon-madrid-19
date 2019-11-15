//
//  URLSessionDataMock.swift
//  droidconmadrid19Tests
//
//  Created by vjgarcia on 14/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
	private let completion: () -> Void
	
	init(completion: @escaping () -> Void) {
		self.completion = completion
	}
	
	override func resume() {
		completion()
	}
}
