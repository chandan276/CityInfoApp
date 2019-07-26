//
//  CICityListViewModel.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 26/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation

class CICityListViewModel {
    
    private var model = CityDetailsModel()
    
    //Provides the number of data available to show
    public var rowsCount: Int {
        return DBHandler.sharedInstance.cityDetails.count
    }
    
    //Provides the cell information: Different data available in each cell
    public func cityDetailsCellViewModel(index: Int) -> CICityDetailsCellViewModel? {
        if rowsCount > 0 {
            
            guard let countryData = model.cityDetails else {
                return nil
            }
            
            let cellModel = CICityDetailsCellViewModel(data: countryData[index])
            return cellModel
        }
        return nil
    }
}

extension CICityListViewModel {
    func fetchCityDetails(sortedBy sortType: SortOrder, completion: @escaping (CICityListViewModel) -> ()) {
        DBHandler.sharedInstance.fetchCityDetailsFromDB(sortedBy: sortType) { [weak self] (cityData) in
            
            if let self = self {
                guard let _ = cityData else {
                    return
                }
                
                self.model.cityDetails = []
                for data in cityData! {
                    let cityName = data.value(forKeyPath: "cityName") as? String
                    let state = data.value(forKeyPath: "state") as? String
                    let population = data.value(forKeyPath: "cityPopulation") as? Int64
                    
                    let cityModel = CityDetail(cityName: cityName!, stateName: state!, cityPopulation: population!)
                    self.model.cityDetails?.append(cityModel)
                }
                
                completion(self)
            }
        }
    }
    
    func deleteCityDetails(cityName name: String, completion: @escaping (Bool) -> ()) {
        DBHandler.sharedInstance.deleteDataWith(cityName: name) { (result) in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
