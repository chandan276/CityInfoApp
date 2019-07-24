//
//  CIConstants.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 23/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

struct Constants {
    
    struct App {
        
        struct Dimensions {
            static let minimumRowHeight: CGFloat = 90.0
            static let defaultHeaderFooterHeight: CGFloat = 1.0
            static let popoverWidth = 200
            static let popoverHeight = 140
            static let timerInterval: Double = 5.0
        }
    }
    
    //Cells used in the App
    struct CellIdentifiers {
        static let cityListScreenTableCellId = "CICountryListTableCell"
        static let addCityScreenTableCellId = "CIAddCityTableCell"
    }
}
