//
//  SearchCountryInteractor.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISearchCountryInteractor: class {
	var parameters: [String: Any]? { get set }
    func getAllCountries()
}

class SearchCountryInteractor: ISearchCountryInteractor {

    var presenter: ISearchCountryPresenter?
    var worker: ISearchCountryWorker?
    var parameters: [String: Any]?

    init(presenter: ISearchCountryPresenter, worker: ISearchCountryWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
    func getAllCountries() {
        guard let parameters = parameters else {
            return
        }
        worker?.getAllCountries(parameters: parameters,complition: { (error, success, countries) in
            if success {
                self.presenter?.showCountries(countries: countries)
            }
            else {
                
            }
        })
    }
    
}
