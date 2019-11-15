//
//  SessionDtoModels.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

struct SessionGroup: Codable, Equatable {
	let groupId: Int
	let groupName: String
	let sessions: [Session]
}

struct Session: Codable, Equatable {
	let id: String
	let title: String
	let description: String
	let room: String
}
