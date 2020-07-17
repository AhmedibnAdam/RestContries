//
//  SelectedCountryPresenter.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISelectedCountryPresenter: class {
	// do someting...
}

class SelectedCountryPresenter: ISelectedCountryPresenter {	
	weak var view: ISelectedCountryViewController?
	
	init(view: ISelectedCountryViewController?) {
		self.view = view
	}
}
