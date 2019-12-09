//
//  UpdateSessionIsStarredValue.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 09/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation
import Bow

class UpdateSessionIsStarredValue {
	private let sessionsBusinessLogic: SessionsBusinessLogic

	init(sessionsBusinessLogic: SessionsBusinessLogic) {
		self.sessionsBusinessLogic = sessionsBusinessLogic
	}
}

extension UpdateSessionIsStarredValue {
	func invoke(sessionId: String, isStarred: Bool) {
		sessionsBusinessLogic.updateStarredValue(sessionId: sessionId, isStarred: isStarred)
	}
}
