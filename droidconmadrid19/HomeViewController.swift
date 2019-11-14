//
//  HomeViewController.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 14/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import UIKit
import MaterialComponents

class HomeViewController: UITabBarController {

	private lazy var bottomNavBar: MDCBottomNavigationBar = {
		let bottomNavBar = MDCBottomNavigationBar()

		bottomNavBar.titleVisibility = .always
		bottomNavBar.delegate = self

		let scheduleViewController = ScheduleViewController()
		let scheduleTab = UITabBarItem(title: "Schedule", image: UIImage(named: "ic_schedule"), tag: 0)
		scheduleViewController.tabBarItem = scheduleTab

		let favouritesViewController = FavouritesViewController()
		let favouritesTab = UITabBarItem(title: "Favourites", image: UIImage(named: "ic_favourite"), tag: 1)
		favouritesViewController.tabBarItem = favouritesTab

		let speakersViewController = SpeakersViewController()
		let speakersTab = UITabBarItem(title: "Speakers", image: UIImage(named: "ic_speaker"), tag: 2)

		let infoViewController = InfoViewController()
		let infoTab = UITabBarItem(title: "Info", image: UIImage(named: "ic_info"), tag: 3)

		bottomNavBar.items = [scheduleTab, favouritesTab, speakersTab, infoTab]
		bottomNavBar.selectedItem = scheduleTab

		let homeViewControllers = [
			scheduleViewController,
			favouritesViewController,
			speakersViewController,
			infoViewController
		]

		self.viewControllers = homeViewControllers
		let size = bottomNavBar.sizeThatFits(self.view.bounds.size)
        var bottomNavBarFrame = CGRect(x: 0,
                                       y: view.bounds.height - size.height,
                                       width: size.width,
                                       height: size.height)

        if #available(iOS 11.0, *) {
            bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
            bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
        }

        bottomNavBar.frame = bottomNavBarFrame

		return bottomNavBar
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		self.view.addSubview(bottomNavBar)
	}
}

extension HomeViewController: MDCBottomNavigationBarDelegate {
	func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, shouldSelect item: UITabBarItem) -> Bool {
		return true
	}

	func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
		self.selectedIndex = item.tag
	}
}
