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

enum SessionizeDaoError {
	case generic
	case dbNotAvailable
}

class SessionizeDao {
	
	private let sessionizeDb: SQLiteSessionizeDB
	
	init(sessionizeDb: SQLiteSessionizeDB) {
		self.sessionizeDb = sessionizeDb
	}
}

// MARK: Sessions

extension SessionizeDao {
	func getSessions() -> Either<SessionizeDaoError, [Session]> {
		get(fromTable: Sessions.table) { $0.toSession() }
	}
	
	func insertSessions(sessions: [Session]) -> Try<Void> {
		return insert(intoTable: Sessions.table, values: sessions) { $0.toSetters() }
	}
}

// MARK: Speakers

extension SessionizeDao {
	func getSpeakers() -> Either<SessionizeDaoError, [Speaker]> {
		let getLinksResult = get(fromTable: Links.table) { $0.toLink() }

		return getLinksResult.flatMap { links in
			return get(fromTable: Speakers.table) { $0.toSpeaker(links) }
		}.mapLeft {_ in
			return .generic
		}
	}

	func insertSpeakers(speakers: [Speaker]) -> Try<Void> {
		return Try.invoke {
			try sessionizeDb.transaction {
				for speaker in speakers {
					try sessionizeDb.insert(table: Speakers.table, setters: speaker.toSetters())
					for link in speaker.links {
						try sessionizeDb.insert(table: Links.table, setters: link.toSetters(speakerId: speaker.id))
					}
				}
			}
		}
	}
}

// MARK: Private API

private extension SessionizeDao {
	func get<T>(fromTable table: Table, rowMapper: (Row) -> T) -> Either<SessionizeDaoError, [T]> {
		do {
			let results = try sessionizeDb.getAll(table: table)
			return Either.right(results.map { rowMapper($0) })
		} catch {
			return Either.left(.generic)
		}
	}

	func insert<T>(intoTable table: Table, values: [T], toSetters: (T) -> [SQLite.Setter]) -> Try<Void> {
		return Try.invoke {
			try sessionizeDb.transaction {
				for value in values {
					try sessionizeDb.insert(table: table, setters: toSetters(value))
				}
			}
		}
	}
}
