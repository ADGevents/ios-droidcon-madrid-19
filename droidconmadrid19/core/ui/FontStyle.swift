//
//  FontStyle.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 14/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit

public enum FontStyle: Int {
	case display3
	case display
	case headline1
	case headline2
	case headline3
	case title
	case title1
	case title2
	case title3
	case body1
	case body2
	case body3
	case sub1
	case sub2
	case caption1
	case caption2
	case caption3
	case caption4
	
	func preferredFont(constrainedToPreferredSize constrainedPreferredSize: UIContentSizeCategory? = nil) -> UIFont {
		let horizontalSizeClass = UIScreen.main.traitCollection.horizontalSizeClass
		var preferredSize = self.preferredSize
		
		if let constrainedSize = constrainedPreferredSize, preferredSize.isGreaterThan(constrainedSize) {
			preferredSize = constrainedSize
		}
		
		let points = fontSize.points(prerredContentSize: preferredSize, horizontalSizeClass: horizontalSizeClass)
		
		return UIFont.systemFont(ofSize: points, weight: weight)
	}
}

private extension FontStyle {
	var preferredSize: UIContentSizeCategory {
		return UIScreen.main.traitCollection.preferredContentSizeCategory
	}
	
	var fontSize: FontSize {
		switch self {
		case .display3:
			return .veryHuge
		case .display:
			return .huge
		case .headline1,
			 .headline2,
			 .headline3:
			return .large
		case .title,
			 .title1:
			return .big
		case .title2,
			 .title3:
			return .veryBig
		case .body1,
			 .body2,
			 .body3:
			return .medium
		case .sub1,
			 .sub2:
			return .small
		case .caption1,
			 .caption2,
			 .caption3:
			return .verySmall
		case .caption4:
			return .extraSmall
		}
	}
	
	var weight: UIFont.Weight {
		switch self {
		case .display3:
			return .light
		case .display:
			return .regular
		case .headline1:
			return .regular
		case .headline2:
			return .medium
		case .headline3:
			return .light
		case .title:
			return .medium
		case .title1:
			return .light
		case .title2:
			return .medium
		case .title3:
			return .light
		case .body1:
			return .regular
		case .body2:
			return .medium
		case .body3:
			return .bold
		case .sub1:
			return .regular
		case .sub2:
			return .medium
		case .caption1:
			return .regular
		case .caption2:
			return .medium
		case .caption3:
			return .bold
		case .caption4:
			return .regular
		}
	}
}

public extension UIContentSizeCategory {
	func isGreaterThan(_ other: UIContentSizeCategory) -> Bool {
		if #available(iOSApplicationExtension 11.0, *) {
			return self > other
		} else {
			return weight > other.weight
		}
	}
	
	private var weight: Int {
		switch self {
		case .extraSmall:
			return -3
		case .small:
			return -2
		case .medium:
			return -1
		case .large: // Default
			return 0
		case .extraLarge:
			return 1
		case .extraExtraLarge:
			return 2
		case .extraExtraExtraLarge:
			return 3
		case .accessibilityMedium:
			return 4
		case .accessibilityLarge:
			return 5
		case .accessibilityExtraLarge:
			return 6
		case .accessibilityExtraExtraLarge:
			return 7
		case .accessibilityExtraExtraExtraLarge:
			return 8
		default:
			return 0
		}
	}
}

public extension UIContentSizeCategory {
	var isAccessibilitySize: Bool {
		if #available(iOSApplicationExtension 11.0, *) {
			return isAccessibilityCategory
		} else {
			return isGreaterThan(.extraExtraExtraLarge)
		}
	}
}
