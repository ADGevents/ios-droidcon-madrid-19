//
//  ViewController.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit


class SessionsViewController: UIViewController {

	@IBOutlet weak var sessions: UITableView!

	private let sessionsViewModel = ServiceLocator.sessionsViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		setUpSessionsTableView()
		sessionsViewModel.sessionsUpdatedCallback = sessions.reloadData
		sessionsViewModel.onSessionsVisible()
	}

	override func viewWillDisappear(_ animated: Bool) {
		sessionsViewModel.onSessionsGone()
		super.viewWillDisappear(animated)
	}
}

extension SessionsViewController: UITableViewDelegate {
	
}

// MARK: UITableViewDataSource

extension SessionsViewController: UITableViewDataSource {

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

private extension SessionsViewController {
	func setUpSessionsTableView() {
		sessions.delegate = self
		sessions.dataSource = self
		registerCells()
	}

	private func registerCells() {
		SessionCell.register(on: sessions)
	}
}

