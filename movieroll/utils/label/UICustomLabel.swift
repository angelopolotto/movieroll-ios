//
//  UICustomLabel.swift
//  movieroll
//
//  Created by Angelo Polotto on 18/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import UIKit

@IBDesignable
class UICustomLabel: UILabel {
    
    @IBInspectable var textResource: String = "" {
        didSet {
            if textResource == "" {
                text = textDefault
            }
            text = Strings.shared.value(forKey: textResource)
        }
    }
    
    @IBInspectable var textDefault: String = "textDefault" {
        didSet {
            if textResource == "" {
                text = textDefault
            }
        }
    }
}
