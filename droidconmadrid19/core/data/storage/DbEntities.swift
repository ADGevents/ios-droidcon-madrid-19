//
//  DbEntities.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 09/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import SQLite

class Sessions {
	static let table = Table("sessions")
	static let id = Expression<String>("id")
	static let title = Expression<String>("title")
	static let description = Expression<String?>("description")
	static let startsAt = Expression<String>("startsAt")
	static let endsAt = Expression<String>("endsAt")
	// static let isServiceSession = Expression<Bool>("isServiceSession")
	// static let isPlenumSession = Expression<Bool>("isPlenumSession")
	// static let roomId = Expression<Int>("roomId")
	static let roomName = Expression<String>("roomName")
	static let isStarred = Expression<Bool>("isStarred")
}

class Speakers {
	static let table = Table("speakers")
	static let id = Expression<String>("id")
	static let firstName = Expression<String>("firstName")
	static let lastName = Expression<String>("lastName")
	static let fullName = Expression<String>("fullName")
	static let bio = Expression<String>("bio")
	static let tagLine = Expression<String>("tagLine")
	static let profilePicture = Expression<String>("profilePicture")
}

class Links {
	static let table = Table("links")
	static let id = Expression<Int>("id")
	static let speakerId = Expression<String>("speakerId")
	static let title = Expression<String>("title")
	static let url = Expression<String>("url")
	static let linkType = Expression<String>("linkType")
}
