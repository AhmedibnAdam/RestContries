//
//  DataSourceEx.swift
//  RestContries
//
//  Created by Adam on 7/18/20.
//  Copyright © 2020 TaskApp. All rights reserved.
//

import UIKit

extension SearchCountryViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            return allCountries.count
        }
        else {
            if networkAvaiability {
                return myVavoriteCountries.count
            }
            else {
                return cashedCountries.count
            }
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
            if networkAvaiability{
                cellF.name.text = self.myVavoriteCountries[indexPath.row].name
            }
            else{
                cellF.name.text = self.cashedCountries[indexPath.row].name
            }
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
        for country in myVavoriteCountries {
            allCountries.append(country)
            self.interactor?.addCountryToCash(country: country )
            
        }
        favoritesTableView.reloadData()
        tableView.hide()
    }
    @objc func removeFromList(_ sender: UIButton){
        if networkAvaiability {
        myVavoriteCountries.remove(at: sender.tag)
        }else{
             let country = self.cashedCountries[sender.tag]
            self.interactor?.removeCountryFromCash(country: country )
            cashedCountries.remove(at: sender.tag)
        }
        
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.favoritesTableView {
         let country = self.myVavoriteCountries[indexPath.row]

            let parameters: [String : Any]  = ["name": country.name,
                          "currency": country.currencies?[0].name,
                          "capital":country.capital]
            router?.navigateToSelectedCountry(parameters: parameters)
    }
    }
}
