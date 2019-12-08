//
//  SpeakersViewModel.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 08/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

class SpeakersViewModel {

	var speakers: [Speaker] = [] {
		didSet {
			mainDispatching.dispatch { [weak self] in
				self?.speakersUpdatedCallback()
			}
		}
	}
	var speakersUpdatedCallback: () -> Void = {}

	private let getSpeakers: GetSpeakers
	private let mainDispatching: Dispatching

	init(getSpeakers: GetSpeakers,
		 mainDispatching: Dispatching) {
		self.getSpeakers = getSpeakers
		self.mainDispatching = mainDispatching
	}
}

extension SpeakersViewModel {
	func onSpeakersVisible() {
		getSpeakers.invoke { result in
			switch(result) {
			case .left:
				print("Error getting speakers :(")
			case let .right(speakers):
				self.speakers = speakers
			}
		}
	}

}
