//
//  SessionMappers.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 12/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

extension Date {
	func toDayAndHour() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "es_ES")
		dateFormatter.dateFormat = "HH:mm"

		return dateFormatter.string(from: self)
	}

	func toTimePeriod() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "es_ES")
		dateFormatter.dateFormat = "a"
		dateFormatter.amSymbol = "AM"
		dateFormatter.pmSymbol = "PM"

		return dateFormatter.string(from: self)

	}
}
