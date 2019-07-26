//
//  CityDetailsModel.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 26/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation

struct CityDetailsModel {
    var cityDetails: [CityDetail]?
    
    init() { }
}

struct CityDetail {
    var cityName: String
    var cityState: String
    var cityPopulation: Int64
    
    init(cityName city: String, stateName state: String, cityPopulation population: Int64) {
        self.cityName = city
        self.cityState = state
        self.cityPopulation = population
    }
}
