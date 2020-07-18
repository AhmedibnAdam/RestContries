//
//  SearchCountryModel.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

struct SearchCountryModel {	

   // MARK: - CountryModel
    struct CountryModel: Codable , Hashable {
     
        
        let name: String?
        let capital: String?
        let currencies: [Currency]?

 
    }

    // MARK: - Currency
    struct Currency: Codable , Hashable {
        let code, name, symbol: String?
    }

    // MARK: - Language
    struct Language: Codable , Hashable  {
        let iso6391, iso6392, name, nativeName: String?

        enum CodingKeys: String, CodingKey {
            case iso6391
            case iso6392
            case name, nativeName
        }
    }







}

