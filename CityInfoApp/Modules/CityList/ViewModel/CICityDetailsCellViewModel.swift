//
//  CICityDetailsCellViewModel.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 26/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation

class CICityDetailsCellViewModel {
    
    private let cityDetail: CityDetail
    
    init(data: CityDetail) {
        self.cityDetail = data
    }
    
    var cityName: String {
        return cityDetail.cityName
    }
    
    var state: String {
        return cityDetail.cityState
    }
    
    var population: String {
        return String(cityDetail.cityPopulation)
    }
}
