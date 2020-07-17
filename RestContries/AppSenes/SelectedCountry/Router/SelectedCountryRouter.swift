//
//  SelectedCountryRouter.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISelectedCountryRouter: class {
	// do someting...
}

class SelectedCountryRouter: ISelectedCountryRouter {	
	weak var view: SelectedCountryViewController?
	
	init(view: SelectedCountryViewController?) {
		self.view = view
	}
}
