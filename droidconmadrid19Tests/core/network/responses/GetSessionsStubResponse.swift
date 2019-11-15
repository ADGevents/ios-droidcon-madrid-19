//
//  GetSessionsStubResponse.swift
//  droidconmadrid19Tests
//
//  Created by vjgarcia on 15/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class GetSessionsStubResponse {
	static var validData: Data {
		let bundle = Bundle(for: GetSessionsStubResponse.self)
		let stubResponsePath = bundle.path(forResource: "GetSessionsValidResponse", ofType: "json")!
		let jsonData = try! Data(contentsOf: URL(fileURLWithPath: stubResponsePath))

		return jsonData
	}

	static var invalidData: Data {
		let bundle = Bundle(for: GetSessionsStubResponse.self)
		let stubResponsePath = bundle.path(forResource: "GetSessionsInvalidResponse", ofType: "json")!
		let jsonData = try! Data(contentsOf: URL(fileURLWithPath: stubResponsePath))

		return jsonData
	}
}
