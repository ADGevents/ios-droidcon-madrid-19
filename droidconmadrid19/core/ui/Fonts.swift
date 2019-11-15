//
//  Fonts.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 14/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit

public extension UIFont {
	static var display: UIFont {
		return FontStyle.display.preferredFont()
	}
	
	static var display3: UIFont {
		return FontStyle.display3.preferredFont()
	}
	
	static var headline1: UIFont {
		return FontStyle.headline1.preferredFont()
	}
	
	static var headline2: UIFont {
		return FontStyle.headline2.preferredFont()
	}
	
	static var headline3: UIFont {
		return FontStyle.headline3.preferredFont()
	}
	
	static var title: UIFont {
		return FontStyle.title.preferredFont()
	}
	
	static var title1: UIFont {
		return FontStyle.title1.preferredFont()
	}
	
	static var title2: UIFont {
		return FontStyle.title2.preferredFont()
	}
	
	static var title3: UIFont {
		return FontStyle.title3.preferredFont()
	}
	
	static var body1: UIFont {
		return FontStyle.body1.preferredFont()
	}
	
	static var body2: UIFont {
		return FontStyle.body2.preferredFont()
	}
	
	static var body3: UIFont {
		return FontStyle.body3.preferredFont()
	}
	
	static var sub1: UIFont {
		return FontStyle.sub1.preferredFont()
	}
	
	static var sub2: UIFont {
		return FontStyle.sub2.preferredFont()
	}
	
	static var caption1: UIFont {
		return FontStyle.caption1.preferredFont()
	}
	
	static var caption2: UIFont {
		return FontStyle.caption2.preferredFont()
	}
	
	static var caption3: UIFont {
		return FontStyle.caption3.preferredFont()
	}
	
	static var caption4: UIFont {
		return FontStyle.caption4.preferredFont()
	}
	
	static func fixedFont(for fontStyle: FontStyle) -> UIFont {
		return fontStyle.preferredFont(constrainedToPreferredSize: .large)
	}
	
	static func preferredFont(for fontStyle: FontStyle, constrainedToPreferredSize constrainedPreferredSize: UIContentSizeCategory) -> UIFont {
		return fontStyle.preferredFont(constrainedToPreferredSize: constrainedPreferredSize)
	}
}
