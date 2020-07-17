//
//  SearchCountryPresenter.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISearchCountryPresenter: class {
	// do someting...
}

class SearchCountryPresenter: ISearchCountryPresenter {	
	weak var view: ISearchCountryViewController?
	
	init(view: ISearchCountryViewController?) {
		self.view = view
	}
}
