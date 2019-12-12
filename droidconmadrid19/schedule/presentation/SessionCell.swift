//
//  SessionCellTableViewCell.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit
import MaterialComponents

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

	private lazy var starView: MDCButton = {
		let star = MDCFlatButton()
		star.heightAnchor.constraint(equalToConstant: 60).isActive = true
		star.widthAnchor.constraint(equalToConstant: 60).isActive = true
		star.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
		return star
	}()
	
	var sessionViewModel: SessionViewModel? {
		didSet {
			bindViewModel()
		}
	}
	
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
		timeTextStackView.widthAnchor.constraint(equalToConstant: 60).isActive = true
		
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

		addSubview(starView, constraints: [
			starView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			starView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
		])

		addSubview(sessionInfoStackView, constraints: [
			sessionInfoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			sessionInfoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
			timeTextStackView.trailingAnchor.constraint(equalTo: sessionInfoStackView.leadingAnchor, constant: -16),
			sessionInfoStackView.trailingAnchor.constraint(equalTo: starView.leadingAnchor, constant: 0)
		])
	}
}

private extension SessionCell {
	
	func bindViewModel() {
		guard let viewModel = sessionViewModel else {
			return
		}

		bindSession(session: viewModel.session,
					isBookmarkingEnabled: viewModel.isBookmarkingEnabled)
		viewModel.sessionUpdatedCallback = { self.bindSession(session: viewModel.session, isBookmarkingEnabled: viewModel.isBookmarkingEnabled) }
	}

	func bindSession(session: Session, isBookmarkingEnabled: Bool) {
		timeView.text = session.startsAt.toDayAndHour()
		timePeriodView.text = "AM"
		sessionTitleView.text = session.title
		sessionDescriptionView.text = session.description

		guard isBookmarkingEnabled else {
			starView.isHidden = true
			return
		}

		starView.isHidden = false
		let isStarred = session.isStarred ?? false
		bindStarImage(isStarred)

		let singleTap = UITapGestureRecognizer(target: self, action: #selector(onStarClicked))
		starView.isUserInteractionEnabled = true
		starView.addGestureRecognizer(singleTap)
	}

	private func bindStarImage(_ isStarred: Bool) {
		if (isStarred) {
			starView.setImage(UIImage(named: "ic_star_filled"), for: .normal)
		} else {
			starView.setImage(UIImage(named: "ic_star_empty"), for: .normal)
		}
	}

	@objc func onStarClicked() {
		sessionViewModel?.onStarClicked()
	}
}
