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
    @objc  dynamic var name: String = ""
    @objc  dynamic var capital: String = ""
    @objc  dynamic var currencies: String = ""
    
    
    
    var _name: String {
        get{
            return name
        }
        set{
            safeWrite {
                name = newValue
            }
        }
        
    }
    var _capital: String {
        get{
            return capital
        }
        set{
            safeWrite {
                name = newValue
            }
        }
        
    }
        

}
