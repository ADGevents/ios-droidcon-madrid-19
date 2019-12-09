//
//  SessionViewModel.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 09/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class SessionViewModel {

	var sessionUpdatedCallback: () -> Void = {}
	var session: Session

	let isBookmarkingEnabled: Bool
	private let updateSessionIsStarredValue: UpdateSessionIsStarredValue?

	init(session: Session,
		 isBookmarkingEnabled: Bool,
		 updateSessionIsStarredValue: UpdateSessionIsStarredValue? = nil) {
		self.session = session
		self.isBookmarkingEnabled = isBookmarkingEnabled
		self.updateSessionIsStarredValue = updateSessionIsStarredValue
	}
}

extension SessionViewModel {
	func onStarClicked() {
		guard isBookmarkingEnabled else {
			return
		}

		let isStarred = !(session.isStarred ?? false)
		updateSessionIsStarredValue?.invoke(sessionId: session.id, isStarred: isStarred)
	}
}

extension Session {
	func copy(isStarred: Bool) -> Session {
		return Session(id: self.id,
					   title: self.title,
					   description: self.description,
					   room: self.room,
					   isStarred: isStarred)
	}
}
