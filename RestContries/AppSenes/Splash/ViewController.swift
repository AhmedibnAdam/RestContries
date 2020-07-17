//
//  ViewController.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright © 2020 TaskApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        
        self.navigate(type: .modalWithNavigation, module: GeneralRoute.searchCountry, completion: nil)
        }
    }


}

