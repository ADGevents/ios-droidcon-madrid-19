//
//  Session.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

struct Session: Codable, Equatable {
	let id: String
	let title: String
	let description: String?
	let room: String
	let isStarred: Bool?
	let startsAt: Date
	let endsAt: Date
}
