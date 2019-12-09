//
//  Mappers.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 09/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import SQLite

extension Row {
	func toSession() -> Session {
		return Session(id: self[Sessions.id],
					   title: self[Sessions.title],
					   description: self[Sessions.description],
					   room: self[Sessions.roomName],
					   isStarred: self[Sessions.isStarred])
	}
	
	
	func toSpeaker(_ links: [Link]) -> Speaker {
		return Speaker(id: self[Speakers.id],
					   firstName: self[Speakers.firstName],
					   lastName: self[Speakers.lastName],
					   fullName: self[Speakers.fullName],
					   bio: self[Speakers.bio],
					   tagLine: self[Speakers.tagLine],
					   profilePicture: self[Speakers.profilePicture],
					   links: links)
	}
	
	func toLink() -> Link {
		return Link(title: self[Links.title],
					url: self[Links.url],
					linkType: self[Links.linkType])
	}
}

extension Session {
	func toSetters() -> [SQLite.Setter] {
		return [Sessions.id <- self.id,
				Sessions.title <- self.title,
				Sessions.description <- self.description,
				Sessions.roomName <- self.room,
				Sessions.isStarred <- self.isStarred ?? false]
	}
}

extension Speaker {
	func toSetters() -> [SQLite.Setter] {
		return [Speakers.id <- self.id,
				Speakers.firstName <- self.firstName,
				Speakers.lastName <- self.lastName,
				Speakers.fullName <- self.fullName,
				Speakers.bio <- self.bio,
				Speakers.tagLine <- self.tagLine,
				Speakers.profilePicture <- self.profilePicture]
	}
}

extension Link {
	func toSetters(speakerId: String) -> [SQLite.Setter] {
		return [Links.speakerId <- speakerId,
				Links.title <- self.title,
				Links.url <- self.url,
				Links.linkType <- self.linkType]
	}
}
