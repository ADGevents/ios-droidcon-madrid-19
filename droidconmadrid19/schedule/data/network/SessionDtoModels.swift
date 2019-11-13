//
//  SessionDtoModels.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

struct SessionGroup: Codable {
	let groupId: Int
	let groupName: String
	let sessions: [Session]
//
//	enum CodingKeys: String, CodingKey {
//		case groupId = "groupId"
//		case groupName = "groupName"
//		case sessions = "sessions"
//	}
}

struct Session: Codable {
	let id: String
	let title: String
	let description: String
	let room: String
//
//	enum CodingKeys: String, CodingKey {
//		case id = "id"
//		case title = "title"
//		case description = "description"
//		case room = "room"
//	}
}
