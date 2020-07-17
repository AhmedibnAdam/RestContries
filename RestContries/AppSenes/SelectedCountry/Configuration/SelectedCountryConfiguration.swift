//
//  SelectedCountryConfiguration.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class SelectedCountryConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = SelectedCountryViewController()
        let router = SelectedCountryRouter(view: controller)
        let presenter = SelectedCountryPresenter(view: controller)
        let worker = SelectedCountryWorker()
        let interactor = SelectedCountryInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
