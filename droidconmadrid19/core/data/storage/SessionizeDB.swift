//
//  SessionizeDB.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 08/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation
import SQLite

enum DBError {
	case generic
	case notAvailable
}

enum DBType {
	case file
	case inMemory
}

class Sessions {
	static let table = Table("sessions")
	static let id = Expression<String>("id")
	static let title = Expression<String>("title")
	static let description = Expression<String?>("description")
	// static let startsAt = Expression<String>("startsAt")
	// static let endsAt = Expression<String>("endsAt")
	// static let isServiceSession = Expression<Bool>("isServiceSession")
	// static let isPlenumSession = Expression<Bool>("isPlenumSession")
	// static let roomId = Expression<Int>("roomId")
	static let roomName = Expression<String>("roomName")
	// static let isStarred = Expression<Bool>("isStarred")
}

class SQLiteSessionizeDB {

	private let connection: Connection?

	static func instance(dbType: DBType = .file) -> SQLiteSessionizeDB? {
		let db = SQLiteSessionizeDB(dbType: dbType)

		do {
			try db.createTables()
			return db
		} catch {
			return nil
		}
	}

	private init(dbType: DBType) {
		do {
			switch dbType {
			case .inMemory:
				self.connection = try Connection()
			case .file:
				let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
				let location: Connection.Location = .uri("\(path)/sessionize.sqlite3")
				self.connection = try Connection(location)
			}
		} catch {
			self.connection = nil
		}
	}
}

extension SQLiteSessionizeDB {
	func createTables() throws {
		guard let conn = connection else {
			return
		}
		do {
			try conn.transaction {
				try createSessionsTable(dbConnection: conn)
			}
		} catch {

		}
	}
}

extension SQLiteSessionizeDB {
	func createSessionsTable(dbConnection: Connection) throws {
		try dbConnection.run(Sessions.table.create(ifNotExists: true) { table in
			table.column(Sessions.id, primaryKey: true)
			table.column(Sessions.title)
			table.column(Sessions.description)
			// table.column(Sessions.startsAt)
			// table.column(Sessions.endsAt)
			// table.column(Sessions.isServiceSession)
			// table.column(Sessions.isPlenumSession)
			// table.column(Sessions.roomId)
			table.column(Sessions.roomName)
			// table.column(Sessions.isStarred)
		})
	}

	func getAll(table: Table) throws -> [Row]  {
		return try connection?.prepare(table).map { $0 } ?? []
	}

	func insert(table: Table, setters: [SQLite.Setter]) throws {
		try connection?.run(table.insert(setters))
	}

	func transaction(block: () throws -> Void) throws {
		try connection?.transaction(block: block)
	}
}
