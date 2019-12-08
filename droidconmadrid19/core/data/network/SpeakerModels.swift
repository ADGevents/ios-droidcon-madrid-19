//
//  SpeakerModels.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 14/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

struct Speaker: Codable, Equatable {
	let id: String
	let firstName: String
	let lastName: String
	let fullName: String
	let bio: String
	let tagLine: String
	let profilePicture: String
	let links: [Link]
}

struct Link: Codable, Equatable {
	let title: String
	let url: String
	let linkType: String
}
