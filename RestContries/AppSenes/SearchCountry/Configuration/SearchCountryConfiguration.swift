//
//  SearchCountryConfiguration.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class SearchCountryConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = SearchCountryViewController()
        let router = SearchCountryRouter(view: controller)
        let presenter = SearchCountryPresenter(view: controller)
        let worker = SearchCountryWorker()
        let interactor = SearchCountryInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
