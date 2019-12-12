//
//  SessionDto.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 12/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

struct SessionData: Codable, Equatable {
	let id: String
	let title: String
	let description: String?
	let room: String
	let isStarred: Bool?
	let startsAt: String
	let endsAt: String
}

extension SessionData {
	func toDomainModel() -> Session {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "es_ES")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

		return Session(id: self.id,
					   title: self.title,
					   description: self.description,
					   room: self.room,
					   isStarred: self.isStarred,
					   startsAt: dateFormatter.date(from: self.startsAt)!,
					   endsAt: dateFormatter.date(from: self.endsAt)!
		)
	}
}
