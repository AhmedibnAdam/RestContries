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
    /*
     If you want passing with parameters
     you just add like this:
     
     case sample
     case sample(parameter: [String: Any])
     
     you can use: String, Int, [String: Any], etc..
    */
}

extension GeneralRoute {
    var module: UIViewController? {
        /*
         Setup module with parameters like:
         
         switch self {
         case .sample:
            return SampleConfiguration.setup()
        case .sample(let parameters):
            return SampleConfiguration.setup(parameters: parameters)
         }
         
         */
        return nil
    }
}
