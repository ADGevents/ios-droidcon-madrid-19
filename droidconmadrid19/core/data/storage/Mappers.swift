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
					   room: self[Sessions.roomName])
	}
}

extension Session {
	func toSetters() -> [SQLite.Setter] {
		return [Sessions.id <- self.id,
				Sessions.title <- self.title,
				Sessions.description <- self.description,
				Sessions.roomName <- self.room]
	}
}
