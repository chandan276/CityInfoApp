//
//  CICityListViewController.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 23/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CICityListViewController: CIBaseViewController {

    @IBOutlet weak var dataUnavailableLabel: UILabel!
    @IBOutlet weak var cityDataTableView: UITableView!
    
    fileprivate let cellId = Constants.CellIdentifiers.cityListScreenTableCellId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.screenTitle = kCityListScreenTitle
        setupUI()
    }

    //MARK:- Configure UI
    func setupUI() {
        //Show No Data Label when there is not data to show
        self.dataUnavailableLabel.text = kDataUnavailableString
        self.dataUnavailableLabel.isHidden = true
        
        setupTableData()
    }
    
    func setupTableData() {
        self.cityDataTableView.isHidden = false
        cityDataTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        cityDataTableView.estimatedRowHeight = Constants.App.Dimensions.minimumRowHeight
        cityDataTableView.rowHeight = UITableView.automaticDimension
    }
}

extension CICityListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CICountryListTableCell else {
            return UITableViewCell()
        }
        
        cell.minHeight = Constants.App.Dimensions.minimumRowHeight
        
        //Pass on the viewModel to cell and it will be taken care there.
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
