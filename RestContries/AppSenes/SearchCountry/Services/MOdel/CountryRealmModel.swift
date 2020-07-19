//
//  CountryRealmModel.swift
//  RestContries
//
//  Created by Adam on 7/18/20.
//  Copyright © 2020 TaskApp. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCountryModel: Object{
    @objc public dynamic var name: String = ""
    @objc public dynamic var capital: String = ""
    @objc public dynamic var currencies: String = ""
    
}
