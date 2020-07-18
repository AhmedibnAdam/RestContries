//
//  SearchCountryRouter.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISearchCountryRouter: class {
    func navigateToSelectedCountry(parameters: [String: Any])
}

class SearchCountryRouter: ISearchCountryRouter {	
	weak var view: SearchCountryViewController?
	
	init(view: SearchCountryViewController?) {
		self.view = view
	}
    
    func navigateToSelectedCountry(parameters: [String: Any]){
      
        view?.navigate(type: .push, module: GeneralRoute.selectedCountry(parameter: parameters), completion: nil)
    }
}
