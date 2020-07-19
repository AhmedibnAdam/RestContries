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
    
    case searchountries(parameters:[String: Any])
    
}

extension SearchCountryEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .searchountries:
            return .get
        }
    }
    var image: UIImage? {
        return nil
    }
    
    var path: String {
        switch self {
        case .searchountries(let parameters):
            if let name = parameters["name"]{
                let originalString = Constant.base + Constant.api + Constant.version + "name/\(name)"
                let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                return urlString
            }
            return ""
        }
    }
    
    var parameter: Parameters? {
        
        switch self {
        case .searchountries:
            return nil
        }
        
    }
    
    var header: HTTPHeaders? {
        
        switch self {
        case .searchountries:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {        
        
        switch self {
        case .searchountries:
            return JSONEncoding.default
        }
    }
}
