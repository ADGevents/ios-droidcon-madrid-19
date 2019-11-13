//
//  TextFieldState.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 07/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

enum TextFieldState {
	case inactive
	case active
	case error(String)
}

class Button


class TextField {

	var validationStrategy: ValidationStrategy = .none

	func validate() -> Bool {
		validator.validate()
	}

	func showError(error: String) {

	}
}

class AnyScreen {

	private let anyPresenter = Presenter()

	private let textField = TextField()
	private let button = Button()

	// bla bla

	func setUpView() {
		button.setOnClickListener {
			guard textField.validate() else {
				textField.showError(error: "Ooopss!")
				return
			}

			presenter.onTextSubmitted(textField.text)
		}
	}
}
func onTextSubmitted(anyText: String) {
	let textField = TextField()
	let button = Button()

	guard textField.validate() else {
		textField.showError(error: "Ooopss!")
		return
	}

	// Continue with correspondent stuff
}
