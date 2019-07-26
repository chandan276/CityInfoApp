//
//  CIAddCityViewController.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 23/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

enum AddCityCellType: Int, CaseIterable {
    case City = 0, Population, State
    
    static var caseCount: Int { return self.allCases.count }
}

class CIAddCityViewController: CIBaseViewController {
    
    @IBOutlet weak var addCityTableView: UITableView!
    fileprivate var viewModel = CIAddCityViewModel()
    
    fileprivate let cellId = Constants.CellIdentifiers.addCityScreenTableCellId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.screenTitle = kAddCityScreenTitle
        self.hideKeyboardOnTap()
        setupTableData()
    }
    
    //MARK:- Configure UI
    func setupTableData() {
        addCityTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    //MARK:- Save Action
    func validateTextFields() -> Bool {
        
        var cell = addCityTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CIAddCityTableCell
        guard let cityNameText = cell?.dataTextField.text, cityNameText.count > 0 else {
            return false
        }
        
        cell = addCityTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? CIAddCityTableCell
        guard let populationText = cell?.dataTextField.text, populationText.count > 0 else {
            return false
        }
        
        cell = addCityTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? CIAddCityTableCell
        guard let stateText = cell?.dataTextField.text, stateText.count > 0 else {
            return false
        }
        
        viewModel.addCityData(cityName: cityNameText, stateName: stateText, cityPopulation: populationText)
        return true
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        
        if validateTextFields() {
            self.navigationController?.popViewController(animated: true)
        } else {
            CIAlertPresenter.showAlertMessage(viewController: self, titleString: kErrorText, messageString: kValidationText)
        }
    }
}

extension CIAddCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddCityCellType.caseCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CIAddCityTableCell else {
            return UITableViewCell()
        }
        
        cell.setupTextFields(forRow: indexPath.row)
        return cell
    }
}
