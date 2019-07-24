//
//  CIFloatingButton.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 24/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

@IBDesignable
class FloatingButton: UIButton {
    
    // MARK: - IBInspectable
    
    @IBInspectable
    var shapeShadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shapeShadowRadius
            layer.shadowOffset = shapeShadowOffset
            layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    @IBInspectable
    var shapeShadowOffset: CGSize = CGSize(width: 0, height: 2) {
        didSet {
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shapeShadowRadius
            layer.shadowOffset = shapeShadowOffset
            layer.shadowColor = UIColor.black.cgColor
        }
    }
}
