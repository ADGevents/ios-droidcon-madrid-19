//
//  SessionizeStorage.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 08/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class SessionizeStorage {

	private let sessionizeDb: SQLiteSessionizeDB

	init(sessionizeDb: SQLiteSessionizeDB) {
		self.sessionizeDb = sessionizeDb
	}
}

extension SessionizeStorage {

	func getAll() -> [Session] {
		return []
	}

	func insert(sessions: [Session]) {
		
	}
}
