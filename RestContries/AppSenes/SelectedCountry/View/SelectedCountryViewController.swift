//
//  SelectedCountryViewController.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISelectedCountryViewController: class {
	var router: ISelectedCountryRouter? { get set }
}

class SelectedCountryViewController: UIViewController {
	var interactor: ISelectedCountryInteractor?
	var router: ISelectedCountryRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension SelectedCountryViewController: ISelectedCountryViewController {
	// do someting...
}

extension SelectedCountryViewController {
	// do someting...
}

extension SelectedCountryViewController {
	// do someting...
}
