//
//  CIAddCityTableCell.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 24/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CIAddCityTableCell: UITableViewCell {
    
    @IBOutlet weak var dataTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK:- Configure TextFields
    func setupTextFields(forRow rowNumber: Int) {
        switch rowNumber {
        case AddCityCellType.City.rawValue:
            dataTextField.placeholder = kCityNameTextFieldPlaceholder
            dataTextField.keyboardType = .default
            break
            
        case AddCityCellType.Population.rawValue:
            dataTextField.placeholder = kPopulationTextFieldPlaceholder
            dataTextField.keyboardType = .numberPad
            break
            
        default:
            dataTextField.placeholder = kStateTextFieldPlaceholder
            dataTextField.keyboardType = .default
            break
        }
    }
}
