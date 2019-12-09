//
//  SessionViewModel.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 09/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class SessionViewModel {
	
	var session: Session

	init(session: Session) {
		self.session = session
	}
}

extension SessionViewModel {
	func onStarClicked() {
		session = Session(id: session.id,
						  title: session.title,
						  description: session.description,
						  room: session.room,
						  isStarred: !(session.isStarred ?? false))
	}
}
