//
//  FontSize.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 14/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit

public enum FontSize {
	case veryHuge
	case huge
	case large
	case veryBig
	case big
	case medium
	case small
	case verySmall
	case extraSmall
	
	func points(prerredContentSize: UIContentSizeCategory, horizontalSizeClass: UIUserInterfaceSizeClass?) -> CGFloat {
		var size = baseSize
		
		let preferredContentSizeDelta = FontSize.deltaPoints(preferredSize: prerredContentSize)
		let sizeClassDelta = deltaPoints(horizontalSizeClass: horizontalSizeClass)
		
		size += preferredContentSizeDelta
		size += sizeClassDelta
		
		return size
	}
}

private extension FontSize {
	var baseSize: CGFloat {
		switch self {
		case .veryHuge:
			return 64
		case .huge:
			return 28
		case .large:
			return 24
		case .veryBig:
			return 20
		case .big:
			return 18
		case .medium:
			return 16
		case .small:
			return 14
		case .verySmall:
			return 12
		case .extraSmall:
			return 10
		}
	}
	
	static func deltaPoints(preferredSize: UIContentSizeCategory) -> CGFloat {
		switch preferredSize {
		case .extraSmall:
			return -3
		case .small:
			return -2
		case .medium:
			return -1
		case .large: // Default
			return 0
		case .extraLarge:
			return 2
		case .extraExtraLarge:
			return 4
		case .extraExtraExtraLarge:
			return 6
		case .accessibilityMedium:
			return 10
		case .accessibilityLarge:
			return 14
		case .accessibilityExtraLarge:
			return 18
		case .accessibilityExtraExtraLarge:
			return 22
		case .accessibilityExtraExtraExtraLarge:
			return 26
		default:
			assertionFailure("Unhandled UIContentSizeCategory: \(preferredSize.rawValue)")
			return 0
		}
	}
	
	/// Returns the additional points taking into account the `horizontalSizeClass`
	/// This currently makes the font size a bit larger for some sizes on regular horizontal size classes
	func deltaPoints(horizontalSizeClass: UIUserInterfaceSizeClass?) -> CGFloat {
		let horizontalSizeClass = horizontalSizeClass ?? .compact
		guard horizontalSizeClass == .regular else { return 0 }
		
		switch self {
		case .veryHuge,
			 .huge,
			 .large,
			 .veryBig:
			return 0
		case .big,
			 .medium,
			 .small,
			 .verySmall,
			 .extraSmall:
			return 2
		}
	}
}
