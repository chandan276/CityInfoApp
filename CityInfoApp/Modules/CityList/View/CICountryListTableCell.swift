//
//  CICountryListTableCell.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 23/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CICountryListTableCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityPopulationLabel: UILabel!
    @IBOutlet weak var cityStateLabel: UILabel!
    
    var minHeight: CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Adopted for miminum Cell height
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minHeight = minHeight else { return size }
        return CGSize(width: size.width, height: max(size.height, minHeight))
    }
}
