//
//  GetSessions.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation
import RxSwift

class GetSessions {
	
	private let sessionsBusinessLogic: SessionsBusinessLogic
	
	init(sessionsBusinessLogic: SessionsBusinessLogic) {
		self.sessionsBusinessLogic = sessionsBusinessLogic
	}
}

extension GetSessions {
	
	func invoke() -> Observable<[Session]> {
		return sessionsBusinessLogic.getAll()
	}
}
