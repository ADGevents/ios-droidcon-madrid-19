//
//  SessionizeStorage.swift
//  droidconmadrid19Tests
//
//  Created by vjgarcia on 08/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import XCTest
@testable import droidconmadrid19

class SessionsDaoTest: XCTestCase {

	private let inMemorySessionizeDb = SQLiteSessionizeDB.instance(dbType: .inMemory)
	private var sut: SessionsDao!

	override func setUp() {
		sut = SessionsDao(sessionizeDb: inMemorySessionizeDb!)
	}
}

extension SessionsDaoTest {

	func testGetAllWithoutInsertedSessions() {
		let getAllValue = sut.getAll().rightOrNil()

		XCTAssertNotNil(getAllValue)
		XCTAssertEqual([], getAllValue)
	}

	func testInsertHappyCase() {
		let sessions = [Session(id: "anyId",
								title: "anyTitle",
								description: nil,
								room: "Ruka room")]

		let insertResult = sut.insert(sessions: sessions)

		XCTAssertTrue(insertResult)
	}

	func testGetAllWithInsertedSessions() {
		let sessions = [Session(id: "anyId",
								title: "anyTitle",
								description: nil,
								room: "Ruka room")]
		sut.insert(sessions: sessions)

		let getAllValue = sut.getAll().rightOrNil()

		XCTAssertNotNil(getAllValue)
		XCTAssertEqual(sessions, getAllValue)
	}
}

