//
//  SelectedCountryViewController.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISelectedCountryViewController: class {
	var router: ISelectedCountryRouter? { get set }
}

class SelectedCountryViewController: UIViewController {
	var interactor: ISelectedCountryInteractor?
	var router: ISelectedCountryRouter?
    var parameters: [String: Any]?
    
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var currency: UILabel!
    

	override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        showData()
    }

}

extension SelectedCountryViewController: ISelectedCountryViewController {
    func showData(){
        guard let capital = parameters?["capital"] else { return  }
        guard let currency = parameters?["currency"] else { return  }
        self.capital.text = capital as? String
        self.currency.text = currency as? String
    }
}

extension SelectedCountryViewController {
	 func setupNavigationBar() {
        guard let name =  parameters?["name"] else {
            return
        }
        navigationItem.title = name as? String
       }
}

