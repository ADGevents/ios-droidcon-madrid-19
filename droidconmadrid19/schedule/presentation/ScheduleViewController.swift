//
//  ViewController.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

	private lazy var sessions: UITableView = {
		let tableView = UITableView()
		return tableView
	}()

	private let sessionsViewModel = ServiceLocator.sessionsViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		setUpTitle()
		setUpSessionsTableView()
		bindViewModel()
	}

	override func viewWillDisappear(_ animated: Bool) {
		unbindViewModel()
		super.viewWillDisappear(animated)
	}
}

extension ScheduleViewController: UITableViewDelegate {
	
}

extension ScheduleViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sessionsViewModel.sessionsModel.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let sessionCell = SessionCell.dequeueReusableCell(for: indexPath, from: sessions)

		let session = sessionsViewModel.sessionsModel[indexPath.row]
		sessionCell.bind(session)

		return sessionCell
	}
}

private extension ScheduleViewController {
	func setUpSessionsTableView() {
		self.view.addSubview(sessions)
		sessions.delegate = self
		sessions.dataSource = self
		registerCells()
	}

	private func registerCells() {
		SessionCell.register(on: sessions)
	}
}

private extension ScheduleViewController {
	func setUpTitle() {
		let headerView = UIView()
        headerView.backgroundColor = .white
        self.view.addSubview(headerView)

		let titleLabel = UILabel()
        titleLabel.text = "Schedule"
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

private extension ScheduleViewController {
	func bindViewModel() {
		sessionsViewModel.sessionsUpdatedCallback = sessions.reloadData
		sessionsViewModel.onSessionsVisible()
	}

	func unbindViewModel() {
		sessionsViewModel.sessionsUpdatedCallback = {}
		sessionsViewModel.onSessionsGone()
	}
}

