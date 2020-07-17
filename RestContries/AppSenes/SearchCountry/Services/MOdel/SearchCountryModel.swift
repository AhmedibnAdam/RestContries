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
    struct CountryModel: Codable {
        let name: String?
        let topLevelDomain: [String]?
        let alpha2Code, alpha3Code: String?
        let callingCodes: [String]?
        let capital: String?
        let altSpellings: [String]?
        let region, subregion: String?
        let population: Int?
        let latlng: [Double]?
        let demonym: String?
        let area: Int?
        let gini: Double?
        let timezones, borders: [String]?
        let nativeName, numericCode: String?
        let currencies: [Currency]?
        let languages: [Language]?
        let flag: String?
        let cioc: String?
    }

    // MARK: - Currency
    struct Currency: Codable {
        let code, name, symbol: String?
    }

    // MARK: - Language
    struct Language: Codable {
        let iso6391, iso6392, name, nativeName: String?

        enum CodingKeys: String, CodingKey {
            case iso6391 = "iso639_1"
            case iso6392 = "iso639_2"
            case name, nativeName
        }
    }

}

