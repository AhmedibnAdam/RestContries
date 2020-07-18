//
//  RealmExtension.swift
//  RealmDemo
//
//  Created by Other user on 10/12/18.
//  Copyright © 2018 Other user. All rights reserved.
//

import Foundation
import  RealmSwift


extension Object {
    func safeWrite (operation: ()->()){
        if let realm = realm {
            do {
                try realm.write {
                    operation()
                }
            }
            catch {
                print(error)
            }
        }
        else {
            operation()
        }
    }
}
