//
//  CICityListViewController.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 23/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit
import TTGSnackbar

enum SortOrder: String {
    case name, population, creationDate
    static var allValues = [SortOrder.name, .population, .creationDate]
}

class CICityListViewController: CIBaseViewController {

    @IBOutlet weak var dataUnavailableLabel: UILabel!
    @IBOutlet weak var cityDataTableView: UITableView!
    
    fileprivate let cellId = Constants.CellIdentifiers.cityListScreenTableCellId
    
    private var model = DirectionModel() {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
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
    
    func showSnackBar() {
        let snackbar = TTGSnackbar(message: kUndoMessage, duration: .long, actionText: kUndoButtonText, actionBlock: { (snackbar) in
            
        })
        snackbar.show()
    }
    
    @objc func tableViewEndEditing() {
        cityDataTableView.isEditing = false
    }
    
    //MARK:- Sorting Action
    @IBAction func sortingAction(_ sender: UIBarButtonItem) {
        let controller = ArrayChoiceTableViewController(SortOrder.allValues) { (direction) in
            self.model.direction = direction
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

        let delete = UITableViewRowAction(style: .destructive, title: kDeleteTitle) { (action, indexPath) in
            // delete item at indexPath
            //self.tableArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            print(self.tableArray)
            self.showSnackBar()
        }

        return [delete]
    }
}
