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
		return label
	}()

	private lazy var timePeriodView: UILabel = {
		let label = UILabel(frame: .zero)
		label.textAlignment = .center
		return label
	}()

	private lazy var sessionTitleView: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.title
		label.textColor = Colors.textPrimary
		return label
	}()

	private lazy var sessionDescriptionView: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.sub1
		label.textColor = Colors.textPrimary
		return label
	}()

	private lazy var sessionCategoryLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.caption1
		label.textColor = Colors.textSeconday
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
		timeTextStackView.distribution = .fill
		timeTextStackView.axis = .vertical
		timeTextStackView.spacing = 0

		let sessionInfoStackView = UIStackView(arrangedSubviews: [sessionTitleView,
																  sessionDescriptionView,
																  sessionCategoryLabel])
		sessionInfoStackView.distribution = .fill
		sessionInfoStackView.axis = .vertical
		sessionInfoStackView.spacing = 4

		let sessionCellStackView = UIStackView(arrangedSubviews: [timeTextStackView,
																  sessionInfoStackView])
		sessionCellStackView.distribution = .fill
		sessionCellStackView.axis = .horizontal
		sessionCellStackView.spacing = 16
		addSubview(sessionCellStackView, constraints: [
				self.topAnchor.constraint(equalTo: sessionCellStackView.topAnchor, constant: -8),
				self.bottomAnchor.constraint(equalTo: sessionCellStackView.bottomAnchor, constant: 8),
				self.leadingAnchor.constraint(equalTo: sessionCellStackView.leadingAnchor, constant: -16),
				self.trailingAnchor.constraint(equalTo: sessionCellStackView.trailingAnchor, constant: 16)
			])

	}
}

extension SessionCell {

	func bind(_ session: SessionModel) {
		timeView.text = session.time
		timePeriodView.text = session.timePeriod
		sessionTitleView.text = session.title
		sessionDescriptionView.text = session.description
		sessionCategoryLabel.text = session.category
	}
}
