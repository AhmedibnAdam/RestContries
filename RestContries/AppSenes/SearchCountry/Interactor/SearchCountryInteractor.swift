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
}

class SearchCountryInteractor: ISearchCountryInteractor {
    var presenter: ISearchCountryPresenter?
    var worker: ISearchCountryWorker?
    var parameters: [String: Any]?

    init(presenter: ISearchCountryPresenter, worker: ISearchCountryWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
