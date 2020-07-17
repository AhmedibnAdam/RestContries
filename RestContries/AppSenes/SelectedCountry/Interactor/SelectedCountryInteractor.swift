//
//  SelectedCountryInteractor.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISelectedCountryInteractor: class {
	var parameters: [String: Any]? { get set }
}

class SelectedCountryInteractor: ISelectedCountryInteractor {
    var presenter: ISelectedCountryPresenter?
    var worker: ISelectedCountryWorker?
    var parameters: [String: Any]?

    init(presenter: ISelectedCountryPresenter, worker: ISelectedCountryWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
