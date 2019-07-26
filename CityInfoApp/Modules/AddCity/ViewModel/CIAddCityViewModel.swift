//
//  CIAddCityViewModel.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 26/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation

class CIAddCityViewModel {
    
    func addCityData(cityName city: String, stateName state: String, cityPopulation population: String) {
        DBHandler.sharedInstance.save(cityName: city, stateName: state, cityPopulation: population)
    }
}
