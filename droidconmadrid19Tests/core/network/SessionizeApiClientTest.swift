//
//  SessionizeApiClientTest.swift
//  droidconmadrid19Tests
//
//  Created by vjgarcia on 14/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import XCTest
@testable import droidconmadrid19

class SessionizeApiClientTest: XCTestCase {
	
	private let decoder = JSONDecoder()
	private let urlSessionMock = URLSessionMock()
	private let stubbedDispatching = SyncQueue.stubbedMain
	
	private var sut: SessionizeApiClient!
	
	override func setUp() {
		sut = SessionizeApiClient(decoder: decoder,
								  urlSession: urlSessionMock,
								  mainDispatching: stubbedDispatching)
	}
}

// MARK: getSessions
extension SessionizeApiClientTest {
	
	func testGetSessions_happyCase() {
		givenASuccessfullGetSessionsResponse()
		
		var actualResult: Either<ApiError, [SessionGroup]>?
		sut.getSessions{ result in actualResult = result}
		
		let expectedSessionGroups = expectedSessionGroupsForSuccess()
		let actualSessionGroups = actualResult?.rightOrNil()
		XCTAssertNotNil(actualSessionGroups)
		XCTAssertEqual(actualSessionGroups, expectedSessionGroups)
	}
	
	func testGetSessions_networkError() {
		givenNoResponse()
		
		var actualResult: Either<ApiError, [SessionGroup]>?
		sut.getSessions{ result in actualResult = result }
		
		let expectedError = ApiError.generic
		let actualError = actualResult?.leftOrNil()
		XCTAssertNotNil(actualError)
		XCTAssertEqual(actualError, expectedError)
	}
	
	func testGetSessions_invalidResponseError() {
		givenAnInvalidGetSessionsResponse()
		
		var actualResult: Either<ApiError, [SessionGroup]>?
		sut.getSessions{ result in actualResult = result }
		
		let expectedError = ApiError.generic
		let actualError = actualResult?.leftOrNil()
		XCTAssertNotNil(actualError)
		XCTAssertEqual(actualError, expectedError)
	}
}

// MARK: getSpeakers
extension SessionizeApiClientTest {
	
	func testGetSpeakers_happyCase() {
		givenASuccessfullGetSpeakersResponse()
		
		var actualResult: Either<ApiError, [Speaker]>?
		sut.getSpeakers { result in actualResult = result }
		
		let expectedSpeakers = expectedSpeakersForSuccess()
		let actualSpeakers = actualResult?.rightOrNil()
		XCTAssertNotNil(actualSpeakers)
		XCTAssertEqual(actualSpeakers, expectedSpeakers)
	}
	
	func testGetSpeakers_networkError() {
		givenNoResponse()
		
		var actualResult: Either<ApiError, [Speaker]>?
		sut.getSpeakers { result in actualResult = result }
		
		let expectedError = ApiError.generic
		let actualError = actualResult?.leftOrNil()
		XCTAssertNotNil(actualError)
		XCTAssertEqual(actualError, expectedError)
	}
	
	func testGetSpeakers_invalidResponseError() {
		givenAnInvalidGetSpeakersResponse()
		
		var actualResult: Either<ApiError, [Speaker]>?
		sut.getSpeakers { result in actualResult = result }
		
		let expectedError = ApiError.generic
		let actualError = actualResult?.leftOrNil()
		XCTAssertNotNil(actualError)
		XCTAssertEqual(actualError, expectedError)
	}
}

private extension SessionizeApiClientTest {
	func expectedSessionGroupsForSuccess() -> [SessionGroup] {
		return [SessionGroup(groupId: 10663,
							 groupName: "Technical",
							 sessions: [Session(id: "14022",
												title: "Aiden's Session",
												description: "Usually, you would find a session description here. But, this is not a real session submission, so description is missing. Ha!",
												room: "Green Room"),
										Session(id: "14023",
												title: "Lucas's Session",
												description: "Usually, you would find a session description here. But, this is not a real session submission, so description is missing. Ha!",
												room: "Yellow Room")]),
				SessionGroup(groupId: 10664,
							 groupName: "Scientific",
							 sessions: [Session(id: "14020",
												title: "Emma's Session",
												description: "Usually, you would find a session description here. But, this is not a real session submission, so description is missing. Ha!",
												room: "Green Room")])
		]
	}
	
	func expectedSpeakersForSuccess() -> [Speaker] {
		return [Speaker(id: "00000000-0000-0000-0000-000000000004",
						firstName: "Aiden",
						lastName: "Test",
						fullName: "Aiden Test",
						bio: "Pop culture fanatic. Friend of animals everywhere. Student. Thinker. Bacon practitioner.",
						tagLine: "Professional public speaker",
						profilePicture: "https://sessionize.com/image?f=e82a4a80c16abc546f05e05a8ef591ef,400,400,True,False,test4.jpg",
						links: [Link(title: "Twitter",
									 url: "https://twitter.com/sessionizecom",
									 linkType: "Twitter"),
								Link(title: "LinkedIn",
									 url: "http://linkedin.com/in/domagojpa",
									 linkType: "LinkedIn")]),
				Speaker(id: "00000000-0000-0000-0000-000000000008",
						firstName: "Ava",
						lastName: "Test",
						fullName: "Ava Test",
						bio: "Student. Wannabe creator. Incurable music advocate.",
						tagLine: "PR specialist",
						profilePicture: "https://sessionize.com/image?f=4e1b91f4d9523cabcbce0759bb16d61a,400,400,True,False,test8.jpg",
						links: [])]
	}
}

private extension SessionizeApiClientTest {
	func givenASuccessfullGetSessionsResponse() {
		urlSessionMock.data = GetSessionsStubResponse.validData
	}
	
	func givenAnInvalidGetSessionsResponse() {
		urlSessionMock.data = GetSessionsStubResponse.invalidData
	}
	
	func givenASuccessfullGetSpeakersResponse() {
		urlSessionMock.data = GetSpeakersStubResponse.validData
	}
	
	func givenAnInvalidGetSpeakersResponse() {
		urlSessionMock.data = GetSpeakersStubResponse.invalidData
	}
	
	func givenNoResponse() {
		urlSessionMock.data = nil
	}
}


