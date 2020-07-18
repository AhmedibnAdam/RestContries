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
    
    var allCountries = [SearchCountryModel.CountryModel]()
    var myVavoriteCountries = [SearchCountryModel.CountryModel]()
    var realmCharacters : [RealmCountryModel] = []
    var myCountry: SearchCountryModel.CountryModel?
    let hostNames = [nil, "restcountries.eu", "invalidhost"]
    var hostIndex = 0
    let locationManager = CLLocationManager()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        registerTableCell()
        startHost(at: 0)
        getCurrentCountryInfo()
        getCountries()
        searchBar.delegate = self

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
           //     interactor?.getAllCountries()
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
        favoritesTableView.register(cell, forCellReuseIdentifier: "SearchTableViewCell")
     }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            return allCountries.count
        }
        else {
            return myVavoriteCountries.count

        }
     }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
             cell.name.text = self.allCountries[indexPath.row].name
             cell.addToFavorite.tag = indexPath.row
            cell.addToFavorite.addTarget(self, action: #selector(addToFavorite(_:)), for: .touchUpInside)
            return cell
        }
        else {
            let cellF = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
            cellF.name.text = self.myVavoriteCountries[indexPath.row].name
            cellF.addToFavorite.backgroundColor = .red
            cellF.addToFavorite.setTitle("remove from list", for: .normal)
            cellF.addToFavorite.tag = indexPath.row
            cellF.addToFavorite.addTarget(self, action: #selector(removeFromList(_:)), for: .touchUpInside)
            return cellF
        }
   
    }
    
    @objc func addToFavorite(_ sender: UIButton){
   
        myVavoriteCountries.append(allCountries[sender.tag])
        let unique = Array(Set(myVavoriteCountries))
        myVavoriteCountries = unique
        favoritesTableView.reloadData()
        tableView.hide()
    }
    @objc func removeFromList(_ sender: UIButton){
        myVavoriteCountries.remove(at: sender.tag)
        
        favoritesTableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            let realmObject = RealmCountryModel()
            realmObject._name = country.name!
            realmObject._capital = country.capital!
            realmObject.currencies = "\(String(describing: country.currencies?[0].name!))"
            RealmManager.shared.addObject(realmObject: realmObject , andCompletion : {
                (addResult) in
                print(addResult)
            } )

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


