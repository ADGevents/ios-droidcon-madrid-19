//
//  Colors.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 14/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit

enum Colors {
	static let textPrimary = color(r: 25, g: 25, b: 25)
	static let textSeconday = color(r: 153, g: 153, b: 153)
}

private extension Colors {

	static func color(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
		return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
	}
}
