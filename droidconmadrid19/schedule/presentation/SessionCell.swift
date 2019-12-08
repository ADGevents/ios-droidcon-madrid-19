//
//  SessionCellTableViewCell.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit

class SessionCell: UITableViewCell {
	
	private lazy var timeView: UILabel = {
		let label = UILabel(frame: .zero)
		label.textAlignment = .center
		label.font = UIFont.title3
		label.lineBreakMode = .byWordWrapping
		return label
	}()
	
	private lazy var timePeriodView: UILabel = {
		let label = UILabel(frame: .zero)
		label.textAlignment = .center
		label.font = UIFont.caption1
		label.lineBreakMode = .byWordWrapping
		return label
	}()
	
	private lazy var sessionTitleView: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.title
		label.textColor = Colors.textPrimary
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.contentMode = .top
		return label
	}()
	
	private lazy var sessionDescriptionView: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.sub1
		label.textColor = Colors.textPrimary
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
}

extension SessionCell {
	func commonInit() {
		let timeTextStackView = UIStackView(arrangedSubviews: [timeView, timePeriodView])
		timeTextStackView.distribution = .fillEqually
		timeTextStackView.axis = .vertical
		timeTextStackView.alignment = .center
		timeTextStackView.spacing = 0
		timeTextStackView.widthAnchor.constraint(equalToConstant: 55).isActive = true
		
		let sessionInfoStackView = UIStackView(arrangedSubviews: [sessionTitleView,
																  sessionDescriptionView])
		sessionInfoStackView.distribution = .fill
		sessionInfoStackView.axis = .vertical
		sessionInfoStackView.spacing = 4

		addSubview(timeTextStackView, constraints: [
			timeTextStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			timeTextStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -8),
			timeTextStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
		])

		addSubview(sessionInfoStackView, constraints: [
			sessionInfoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			sessionInfoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
			timeTextStackView.trailingAnchor.constraint(equalTo: sessionInfoStackView.leadingAnchor, constant: -16),
			sessionInfoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
		])
		
	}
}

extension SessionCell {
	
	func bind(_ session: SessionModel) {
		timeView.text = session.time
		timePeriodView.text = session.timePeriod
		sessionTitleView.text = session.title
		sessionDescriptionView.text = session.description
	}
}
