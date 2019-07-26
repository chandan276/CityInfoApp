//
//  CICityListViewController.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 23/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit
import TTGSnackbar

class CICityListViewController: CIBaseViewController {

    @IBOutlet weak var dataUnavailableLabel: UILabel!
    @IBOutlet weak var cityDataTableView: UITableView!
    
    fileprivate var viewModel = CICityListViewModel()
    fileprivate let cellId = Constants.CellIdentifiers.cityListScreenTableCellId
    
    private var model = SortingModel() {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.screenTitle = kCityListScreenTitle
        cityDataTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchCityDetails(sortedBy: .creationDate) { (cityViewModel) in
            self.setupUI()
        }
    }

    //MARK:- UI Update Methods
    private func setupUI() {
        
        if viewModel.rowsCount > 0 {
            setupTableData()
        } else {
            //Show No Data Label when there is not data to show
            self.dataUnavailableLabel.text = kDataUnavailableString
            self.dataUnavailableLabel.isHidden = false
            self.cityDataTableView.isHidden = true
        }
    }
    
    private func setupTableData() {
        self.dataUnavailableLabel.isHidden = true
        self.cityDataTableView.isHidden = false
        
        cityDataTableView.estimatedRowHeight = Constants.App.Dimensions.minimumRowHeight
        cityDataTableView.rowHeight = UITableView.automaticDimension
        cityDataTableView.reloadData()
    }
    
    private func showSnackBar() {
        let snackbar = TTGSnackbar(message: kUndoMessage, duration: .long, actionText: kUndoButtonText, actionBlock: { (snackbar) in
            
        })
        snackbar.show()
    }
    
    @objc func tableViewEndEditing() {
        cityDataTableView.isEditing = false
    }
    
    //MARK:- Sorting Action
    @IBAction func sortingAction(_ sender: UIBarButtonItem) {
        let controller = ArrayChoiceTableViewController(SortOrder.allValues) { [weak self] (sortType) in
            if let self = self {
                self.model.sorting = sortType
                self.handleSorting(sortType)
            }
        }
        
        controller.preferredContentSize = CGSize(width: Constants.App.Dimensions.popoverWidth, height: Constants.App.Dimensions.popoverHeight)
        showPopup(controller, sourceView: sender)
    }
    
    private func showPopup(_ controller: UIViewController, sourceView: UIBarButtonItem) {
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        presentationController.barButtonItem = sourceView
        presentationController.permittedArrowDirections = [.down, .up]
        self.present(controller, animated: true)
    }
    
    private func handleSorting(_ sortOrder: SortOrder) {
        viewModel.fetchCityDetails(sortedBy: sortOrder) { (cityViewModel) in
            self.setupUI()
        }
    }
}

extension CICityListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CICountryListTableCell else {
            return UITableViewCell()
        }
        
        cell.minHeight = Constants.App.Dimensions.minimumRowHeight
        
        //Pass on the viewModel to cell and it will be taken care there.
        cell.viewModel = self.viewModel.cityDetailsCellViewModel(index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.App.Dimensions.defaultHeaderFooterHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.App.Dimensions.defaultHeaderFooterHeight
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        _ = Timer.scheduledTimer(timeInterval: Constants.App.Dimensions.timerInterval, target: self, selector: #selector(self.tableViewEndEditing), userInfo: nil, repeats: false)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .destructive, title: kDeleteTitle) { [weak self] (action, indexPath) in
            if let self = self {
                let cell = tableView.cellForRow(at: indexPath) as? CICountryListTableCell
                self.viewModel.deleteCityDetails(cityName: (cell?.cityNameLabel.text)!, completion: { (result) in
                    if result {
                        self.viewModel.fetchCityDetails(sortedBy: .creationDate) { (cityViewModel) in
                            self.setupUI()
                        }
                        self.showSnackBar()
                    }
                })
            }
        }

        return [delete]
    }
}
