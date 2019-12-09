//
//  SessionizeDao.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 08/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation
import SQLite
import Bow

enum SessionsDaoError {
	case generic
	case dbNotAvailable
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
	
	func insert(sessions: [Session]) -> Try<Void> {
		return Try.invoke {
			try sessionizeDb.transaction {
				for session in sessions {
					try sessionizeDb.insert(table: Sessions.table, setters: session.toSetters())
				}
			}
		}
	}
}
