//
//  SearchCountryWorker.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol ISearchCountryWorker: class {
	func getAllCountries(complition :  @escaping (_ error:Error? ,_ success: Bool,_ data: [SearchCountryModel.CountryModel]?)->Void)
}

class SearchCountryWorker: ISearchCountryWorker {
    func getAllCountries(complition :  @escaping (_ error:Error? ,_ success: Bool,_ data: [SearchCountryModel.CountryModel]?)->Void){
        NetworkService.share.request(endpoint: SearchCountryEndpoint.allCountries, success: { (responseData) in
            let response = responseData
            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([SearchCountryModel.CountryModel].self, from: response)
                print(countries)
                complition(nil, true, countries)
                
            } catch let error {
                print(error)
            }
            
        }) { (error) in
            print(error as Any)
        }
    }
}
