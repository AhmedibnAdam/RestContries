//
//  SearchCountryViewController.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright (c) 2020 TaskApp. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import Reachability
import CoreLocation

protocol ISearchCountryViewController: class {
	var router: ISearchCountryRouter? { get set }
    func showCountries(countries: [SearchCountryModel.CountryModel]?)
}

class SearchCountryViewController: UIViewController, CLLocationManagerDelegate {
	var interactor: ISearchCountryInteractor?
	var router: ISearchCountryRouter?
    var reachability: Reachability?
    
    var allCountries: [SearchCountryModel.CountryModel]?
    let hostNames = [nil, "restcountries.eu", "invalidhost"]
    var hostIndex = 0
    let locationManager = CLLocationManager()

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        registerTableCell()
        startHost(at: 0)
        getCountries()
        getCurrentCountryInfo()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func getCountries(){
        reachability = try? Reachability()
        if let reachable = reachability?.isReachable{
            switch reachable {
            case true:
                print(reachable)
                interactor?.getAllCountries()
            case false:
                print(reachable)
            }
        }
      
    }
    
    deinit {
           stopNotifier()
       }
        
}


extension SearchCountryViewController {
    func setupNavigationBar() {
        navigationItem.title = "Countries"
    }
}

extension SearchCountryViewController: UITableViewDelegate, UITableViewDataSource {
       func registerTableCell() {
         let cell = UINib(nibName: "SearchTableViewCell", bundle: nil)
         tableView.register(cell, forCellReuseIdentifier: "SearchTableViewCell")
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.allCountries?.count ?? 0
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        cell.textLabel?.isHidden = false
        cell.textLabel?.text = self.allCountries?[indexPath.row].name
        return cell
    }
   
}

extension SearchCountryViewController {
    
    func getCurrentCountryInfo(){
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        CLGeocoder().reverseGeocodeLocation(locationManager.location!, preferredLocale: nil) { (clPlacemark: [CLPlacemark]?, error: Error?) in
            guard let place = clPlacemark?.first else {
                print("No placemark from Apple: \(String(describing: error))")
                return
            }
            print(place.country!)
            print(place.name!)
        }
    }
}


extension SearchCountryViewController: ISearchCountryViewController {
    func showCountries(countries: [SearchCountryModel.CountryModel]?) {
        guard let data = countries else {
            return
        }
        self.allCountries = data
        tableView.reloadData()
    }
    
    
}


