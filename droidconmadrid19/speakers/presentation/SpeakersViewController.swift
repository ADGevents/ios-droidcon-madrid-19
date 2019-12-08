//
//  SpeakersViewController.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 14/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit

class SpeakersViewController: UIViewController {

	private lazy var headerView: UIView = {
		let headerView = UIView()
		headerView.backgroundColor = .white
		return headerView
	}()

	private lazy var speakers: UITableView = {
		let speakers = UITableView()
		speakers.dataSource = self
		SpeakerCell.register(on: speakers)
		return speakers
	}()

	private let speakersViewModel = ServiceLocator.speakersViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		setUpTitle()
		setUpSpeakersTableView()
		bindViewModel()
	}

	override func viewWillDisappear(_ animated: Bool) {
		unbindViewModel()
		super.viewWillDisappear(animated)
	}
}

extension SpeakersViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return speakersViewModel.speakers.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let speakerCell = SpeakerCell.dequeueReusableCell(for: indexPath, from: speakers)
		let speaker = speakersViewModel.speakers[indexPath.row]
		speakerCell.bind(speaker)

		return speakerCell
	}
}

private extension SpeakersViewController {
	func setUpSpeakersTableView() {
		self.view.addSubview(speakers, constraints: [
			self.view.bottomAnchor.constraint(equalTo: speakers.bottomAnchor),
			self.view.leadingAnchor.constraint(equalTo: speakers.leadingAnchor),
			self.view.trailingAnchor.constraint(equalTo: speakers.trailingAnchor),
			self.headerView.bottomAnchor.constraint(equalTo: speakers.topAnchor)
		])
	}
}

private extension SpeakersViewController {
	func setUpTitle() {
		self.view.addSubview(headerView)
		
		let titleLabel = UILabel()
		titleLabel.text = "Speakers"
		titleLabel.textAlignment = .center
		titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 20)
		headerView.addSubview(titleLabel)
		
		// Set position of views using constraints
		headerView.translatesAutoresizingMaskIntoConstraints = false
		headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
		headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
		headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
		
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
		titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
		titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.4).isActive = true
		titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5).isActive = true
	}
}

private extension SpeakersViewController {
	func bindViewModel() {
		speakersViewModel.speakersUpdatedCallback = speakers.reloadData
		speakersViewModel.onSpeakersVisible()
	}

	func unbindViewModel() {
		speakersViewModel.speakersUpdatedCallback = {}
	}
}
