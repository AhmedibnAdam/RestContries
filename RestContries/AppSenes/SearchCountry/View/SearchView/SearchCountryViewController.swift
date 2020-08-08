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
import CoreLocation

protocol ISearchCountryViewController: class {
    var router: ISearchCountryRouter? { get set }
    func showCountries(countries: [SearchCountryModel.CountryModel]?)
}

class SearchCountryViewController: UIViewController {
    
    // MARK: - configration
    var interactor: ISearchCountryInteractor?
    var router: ISearchCountryRouter?
    
    // MARK: - proparites
    var networkAvaiability = true
    var allCountries = [SearchCountryModel.CountryModel]()
    var myVavoriteCountries = [SearchCountryModel.CountryModel]()
    var cashedCountries : [RealmCountryModel] = []
    var myCountry: SearchCountryModel.CountryModel?
    let locationManager = CLLocationManager()
    
    var tableData = 0
    // MARK: - outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var favoritesTableView: UITableView!
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        registerTableCell()
        getCurrentCountryInfo()
        searchBar.delegate = self
        
    }
}


extension SearchCountryViewController {
    func setupNavigationBar() {
        navigationItem.title = "Countries"
    }
    func registerTableCell() {
        let cell = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "SearchTableViewCell")
    }
    
    func getCountriesFromCashing(){
        self.cashedCountries = RealmManager.shared.getObjectOf(type: RealmCountryModel.self)
        let unique = Array(Set(cashedCountries))
        tableData = 2
        cashedCountries = unique
        tableView.reloadData()
    }
}


extension SearchCountryViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
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
        if let location = locationManager.location {
            
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: nil) { (clPlacemark: [CLPlacemark]?, error: Error?) in
                guard let place = clPlacemark?.first else {
                    print("No placemark from Apple: \(String(describing: error))")
                    self.interactor?.parameters?["name"] = "Egypt"
                    self.interactor?.getAllCountries()
                    return
                }
                print(place.country!)
                print(place.name!)
                self.interactor?.parameters?["name"] = place.name!
                self.interactor?.getAllCountries()
            }
        }else{
            self.myCountry = SearchCountryModel.CountryModel(name: "Egypt",
                                                             capital: "Cairo",
                                                             currencies: [SearchCountryModel.Currency(code: "EGP", name: "Egyption Pound", symbol: "")] )
            self.interactor?.parameters?["name"] = "Egypt"
            self.interactor?.getAllCountries()
            
        }
    }
}



extension SearchCountryViewController: ISearchCountryViewController {
    func showCountries(countries: [SearchCountryModel.CountryModel]?) {
        guard let data = countries else {
            getCountriesFromCashing()
            networkAvaiability = false
            return
        }
        for country in data {
            allCountries.append(country)
        }
        let unique = Array(Set(allCountries))
        allCountries = unique
        tableData = 0
        tableView.reloadData()
    }
    
    
}

extension SearchCountryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count)! > 2 {
            interactor?.parameters?["name"] = searchText
            tableData = 0
            interactor?.getAllCountries()
        }
        else {
            allCountries.removeAll()
            tableData = 1
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        allCountries.removeAll()
        tableData = 1
        tableView.reloadData()
    }
    
}

