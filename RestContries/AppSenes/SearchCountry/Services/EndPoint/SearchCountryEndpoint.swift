//
//  SearchCountryEndpoint.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire

enum SearchCountryEndpoint {
   
     case allCountries
   
}

extension SearchCountryEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .allCountries:
            return .get
        }
       
        
    }
    var image: UIImage? {
          return nil
      }
    
    var path: String {
        

        switch self {
        case .allCountries:
            return Constant.base + Constant.api + Constant.version + "regionalbloc/EU"
        }
    }
    
    var parameter: Parameters? {
       
        switch self {
        case .allCountries:
            return nil
        }
        
    }
    
    var header: HTTPHeaders? {

        switch self {
        case .allCountries:
            return nil
        }
      
    }
    
    var encoding: ParameterEncoding {        

        switch self {
        case .allCountries:
            return JSONEncoding.default
        }

    }
}
