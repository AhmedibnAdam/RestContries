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
        if tableData == 0{
            return allCountries.count
        }
        else if tableData == 1 {
            return myVavoriteCountries.count
        }
        else{
            return cashedCountries.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        if tableData == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
            cell.name.text = self.allCountries[indexPath.row].name
            cell.addToFavorite.backgroundColor = .green
            cell.addToFavorite.setTitle("add to favorite", for: .normal)
            cell.addToFavorite.tag = indexPath.row
            cell.addToFavorite.addTarget(self, action: #selector(addToFavorite(_:)), for: .touchUpInside)
            return cell
        }
        else if tableData == 1 {
            
            cell.name.text = self.myVavoriteCountries[indexPath.row].name
            
            cell.addToFavorite.backgroundColor = .red
            cell.addToFavorite.setTitle("remove from list", for: .normal)
            cell.addToFavorite.tag = indexPath.row
            cell.addToFavorite.addTarget(self, action: #selector(removeFromList(_:)), for: .touchUpInside)
            return cell
        }
        else{
            cell.name.text = self.cashedCountries[indexPath.row].name
            
            cell.addToFavorite.backgroundColor = .red
            cell.addToFavorite.setTitle("remove from list", for: .normal)
            cell.addToFavorite.tag = indexPath.row
            cell.addToFavorite.addTarget(self, action: #selector(removeFromList(_:)), for: .touchUpInside)
            return cell
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
        tableData = 1
        tableView.reloadData()
        
    }
    @objc func removeFromList(_ sender: UIButton){
        if networkAvaiability {
            myVavoriteCountries.remove(at: sender.tag)
        }else{
            let country = self.cashedCountries[sender.tag]
            self.interactor?.removeCountryFromCash(country: country )
            cashedCountries.remove(at: sender.tag)
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableData == 1{
            let country = self.myVavoriteCountries[indexPath.row]
            
            let parameters: [String : Any]  = ["name": country.name,
                                               "currency": country.currencies?[0].name,
                                               "capital":country.capital]
            router?.navigateToSelectedCountry(parameters: parameters)
        }
    }
}
