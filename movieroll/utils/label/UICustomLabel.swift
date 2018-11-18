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
    
    @IBInspectable var textResource: String = "Text Resource Empty" {
        didSet {
            text = Strings.shared.value(forKey: textResource)
        }
    }
}
