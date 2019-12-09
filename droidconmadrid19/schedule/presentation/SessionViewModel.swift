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

	private let updateSessionIsStarredValue: UpdateSessionIsStarredValue

	init(session: Session,
		 updateSessionIsStarredValue: UpdateSessionIsStarredValue) {
		self.session = session
		self.updateSessionIsStarredValue = updateSessionIsStarredValue
	}
}

extension SessionViewModel {
	func onStarClicked() {
		let isStarred = !(session.isStarred ?? false)
		session = session.copy(isStarred: isStarred)
		sessionUpdatedCallback()
		updateSessionIsStarredValue.invoke(sessionId: session.id, isStarred: isStarred)
			.fold({ error in
				session = session.copy(isStarred: !isStarred)
				sessionUpdatedCallback()
			}, {success in })
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
