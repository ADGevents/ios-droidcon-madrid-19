//
//  SpeakerCell.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 08/12/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit
import AlamofireImage

class SpeakerCell: UITableViewCell {

	private lazy var avatar: UIImageView = {
		let avatar = UIImageView(frame: .zero)
		avatar.heightAnchor.constraint(equalToConstant: 48).isActive = true
		avatar.widthAnchor.constraint(equalToConstant: 48).isActive = true
		return avatar
	}()

	private lazy var title: UILabel = {
		let title = UILabel(frame: .zero)
		title.textAlignment = .left
		title.textColor = Colors.textPrimary
		return title
	}()

	private lazy var subtitle: UILabel = {
		let subtitle = UILabel(frame: .zero)
		subtitle.textAlignment = .left
		subtitle.font = UIFont.caption1
		subtitle.textColor = Colors.textSeconday
		return subtitle
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

extension SpeakerCell {
	func commonInit() {
		let textStackView = UIStackView(arrangedSubviews: [title, subtitle])
		textStackView.distribution = .fill
		textStackView.axis = .vertical

		let speakerCellStackView = UIStackView(arrangedSubviews: [avatar, textStackView])
		speakerCellStackView.distribution = .fill
		speakerCellStackView.axis = .horizontal
		speakerCellStackView.spacing = 16

		addSubview(speakerCellStackView, constraints: [
			self.topAnchor.constraint(equalTo: speakerCellStackView.topAnchor, constant: -8),
			self.bottomAnchor.constraint(equalTo: speakerCellStackView.bottomAnchor, constant: 8),
			self.leadingAnchor.constraint(equalTo: speakerCellStackView.leadingAnchor, constant: -16),
			self.trailingAnchor.constraint(equalTo: speakerCellStackView.trailingAnchor, constant: 16)
		])
	}
}

extension SpeakerCell {
	func bind(_ speaker: Speaker) {
		title.text = speaker.fullName
		subtitle.text = speaker.tagLine
		avatar.af_setImage(withURL: URL(string: speaker.profilePicture)!,
						   placeholderImage: UIImage(named: "ic_avatar_plh"),
						   filter: CircleFilter())
	}
}
