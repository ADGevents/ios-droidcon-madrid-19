//
//  SessionModel.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

struct SessionModel {
	let title: String
	let description: String
	let category: String
	let time: String
	let timePeriod: String
	
	init(title: String,
		 description: String,
		 category: String,
		 time: String,
		 timePeriod: String) {
		self.title = title
		self.description = description
		self.category = category
		self.time = time
		self.timePeriod = timePeriod
	}
}
