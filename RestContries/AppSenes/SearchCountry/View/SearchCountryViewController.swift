//
//  SearchCountryViewController.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISearchCountryViewController: class {
	var router: ISearchCountryRouter? { get set }
}

class SearchCountryViewController: UIViewController {
	var interactor: ISearchCountryInteractor?
	var router: ISearchCountryRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension SearchCountryViewController: ISearchCountryViewController {
	// do someting...
}

extension SearchCountryViewController {
	// do someting...
}

extension SearchCountryViewController {
	// do someting...
}
