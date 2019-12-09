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
	private let sessionizeRepository: SessionizeRepository

	init(sessionizeRepository: SessionizeRepository) {
		self.sessionizeRepository = sessionizeRepository
	}
}

extension UpdateSessionIsStarredValue {
	func invoke(sessionId: String, isStarred: Bool) -> Try<Void> {
		return sessionizeRepository.updateSessionIsStarredValue(sessionId: sessionId,
																isStarred: isStarred)
	}
}
