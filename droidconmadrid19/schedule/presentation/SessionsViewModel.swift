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
			mainDispatching.dispatch { [weak self] in
				self?.sessionsUpdatedCallback()
			}
		}
	}
	var sessionsUpdatedCallback: () -> Void = {}
	
	private let getSessions: GetSessions
	private let mainDispatching: Dispatching
	
	init(getSessions: GetSessions,
		 mainDispatching: Dispatching) {
		self.getSessions = getSessions
		self.mainDispatching = mainDispatching
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
