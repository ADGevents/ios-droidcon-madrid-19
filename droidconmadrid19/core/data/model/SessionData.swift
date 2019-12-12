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

		let startsAtDate = dateFormatter.date(from: self.startsAt)!
		let endsAtDate = dateFormatter.date(from: self.endsAt)!

		let talkDurationInSeconds = endsAtDate.timeIntervalSince(startsAtDate)
		let talkDurationInMinutes = Int(talkDurationInSeconds / 60)
		let description = "\(talkDurationInMinutes) min / \(self.room)"

		return Session(id: self.id,
					   title: self.title,
					   description: description,
					   room: self.room,
					   isStarred: self.isStarred,
					   startsAt: startsAtDate,
					   endsAt: endsAtDate
		)
	}
}
