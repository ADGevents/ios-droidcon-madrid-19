//
//  SessionizeDao.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 08/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation
import SQLite

enum SessionsDaoError {
	case generic
	case dbNotAvailable
}

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

class SessionsDao {
	
	private let sessionizeDb: SQLiteSessionizeDB
	
	init(sessionizeDb: SQLiteSessionizeDB) {
		self.sessionizeDb = sessionizeDb
	}
}

extension SessionsDao {
	
	func getAll() -> Either<SessionsDaoError, [Session]> {
		do {
			let sessions = try sessionizeDb.getAll(table: Sessions.table)
			return Either.right(sessions.map { $0.toSession() })
		} catch {
			return Either.left(.generic)
		}
	}
	
	func insert(sessions: [Session]) -> Bool {
		do {
			try sessionizeDb.transaction {
				for session in sessions {
					try sessionizeDb.insert(table: Sessions.table, setters: session.toSetters())
				}
			}
			return true
		} catch {
			return false
		}
	}
}
