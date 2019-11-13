//
//  SessionCellTableViewCell.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit

class SessionCell: UITableViewCell {
	@IBOutlet weak var time: UILabel!
	@IBOutlet weak var timePeriod: UILabel!
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var additionalInfo: UILabel!
	@IBOutlet weak var category: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension SessionCell {

	func bind(_ session: SessionModel) {
		title.text = session.title
		additionalInfo.text = session.description
		time.text = session.time
		timePeriod.text = session.timePeriod
		category.text = session.category
	}
}
