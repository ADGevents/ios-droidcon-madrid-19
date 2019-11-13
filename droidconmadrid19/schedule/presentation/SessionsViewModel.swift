//
//  SessionsViewModel.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class SessionsViewModel {

	var sessionsModel: [SessionModel] = [] {
		didSet {
			sessionsUpdatedCallback()
		}
	}
	var sessionsUpdatedCallback: () -> Void = {}

	private let getSessions: GetSessions

	init(getSessions: GetSessions) {
		self.getSessions = getSessions
	}
}

extension SessionsViewModel {
	func onSessionsVisible() {
		getSessions.invoke(completion: {result in
			switch(result) {
			case .left:
				print("Error getting sessions :(")
			case let .right(sessions):
				let sessionsModel = sessions.flatMap {(sessionGroup) -> [SessionModel] in
					sessionGroup.sessions.map { (session) -> SessionModel in
						return SessionModel(title: session.title,
											description: session.description,
											category: sessionGroup.groupName,
											time: "10",
											timePeriod: "PM")
					}
				}

				self.sessionsModel = sessionsModel
			}
		})
	}

	func onSessionsGone() {

	}
}
