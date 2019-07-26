//
//  CIBaseViewController.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 23/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

enum SortOrder: String {
    case name, population, creationDate
    static var allValues = [SortOrder.name, .population, .creationDate]
}

struct SortingModel {
    var sorting = SortOrder.creationDate
}

class CIBaseViewController: UIViewController {
    
    //Setup Screen title
    var screenTitle: String = kDefaultScreenTitle {
        didSet {
            self.title = self.screenTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
