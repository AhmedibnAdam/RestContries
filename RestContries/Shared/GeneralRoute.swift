//
//  GeneralRoute.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam/

import Foundation
import UIKit

enum GeneralRoute: IRouter {

     case searchCountry
     case selectedCountry(parameter: [String: Any])
     
  
}

extension GeneralRoute {
    var module: UIViewController? {
         switch self {
         case .searchCountry:
            return SearchCountryConfiguration.setup()
        case .selectedCountry(let parameters):
            return SelectedCountryConfiguration.setup(parameters: parameters)
         }
    }
}
