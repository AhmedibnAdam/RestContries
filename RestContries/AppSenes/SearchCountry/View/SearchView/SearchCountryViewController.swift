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

class SearchCountryViewController: UIViewController {
    
      // MARK: - configration
	var interactor: ISearchCountryInteractor?
	var router: ISearchCountryRouter?
    
      // MARK: - proparites
    var reachability: Reachability?
    var networkAvaiability = true
    var allCountries = [SearchCountryModel.CountryModel]()
    var myVavoriteCountries = [SearchCountryModel.CountryModel]()
    var realmCharacters : [RealmCountryModel] = []
    var myCountry: SearchCountryModel.CountryModel?
    let hostNames = [nil, "restcountries.eu", "invalidhost"]
    var hostIndex = 0
    let locationManager = CLLocationManager()

         // MARK: - outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoritesTableView: UITableView!
    
         // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        registerTableCell()
        startHost(at: 0)
        getCurrentCountryInfo()
        getCountries()
        searchBar.delegate = self

    }
    

    func getCountries(){
        reachability = try? Reachability()
        if let reachable = reachability?.isReachable{
            switch reachable {
            case true:
                print(reachable)
                networkAvaiability = true
            case false:
                print(reachable)
                networkAvaiability = false
                self.realmCharacters = RealmManager.shared.getObjectOf(type: RealmCountryModel.self)
                let unique = Array(Set(realmCharacters))
                      realmCharacters = unique
                favoritesTableView.reloadData()
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
        
        CLGeocoder().reverseGeocodeLocation(locationManager.location!, preferredLocale: nil) { (clPlacemark: [CLPlacemark]?, error: Error?) in
            guard let place = clPlacemark?.first else {
                print("No placemark from Apple: \(String(describing: error))")
                return
            }
            print(place.country!)
            print(place.name!)
            self.myCountry = SearchCountryModel.CountryModel(name: place.country!,
                                                        capital: "",
                                                        currencies: [SearchCountryModel.Currency(code: "", name: "", symbol: "")] )
            self.myVavoriteCountries.append(self.myCountry!)
            self.favoritesTableView.reloadData()
        }
    }
}


extension SearchCountryViewController: ISearchCountryViewController {
    func showCountries(countries: [SearchCountryModel.CountryModel]?) {
        guard let data = countries else {
            return
        }
        for country in data {
            allCountries.append(country)
        }
        let unique = Array(Set(allCountries))
        allCountries = unique
        tableView.reloadData()
    }
    
    
}

extension SearchCountryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count)! > 2 {
            tableView.show()
            interactor?.parameters?["name"] = searchText
            interactor?.getAllCountries()
        }
        else {
            allCountries.removeAll()
            tableView.hide()
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        allCountries.removeAll()
        tableView.hide()
        tableView.reloadData()
    }
    
}

