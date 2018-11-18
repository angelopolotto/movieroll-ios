//
//  TextFieldPicker.swift
//  movieroll
//
//  Created by Angelo Polotto on 18/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import UIKit

class UITextFieldPicker: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // disable user type anithing from keyboard
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        self.resignFirstResponder()
        return false
    }
    
    override func shouldChangeText(in range: UITextRange, replacementText text: String) -> Bool {
        self.resignFirstResponder()
        return false
    }
    
    func loadDropdownData(data: [Any], titleForRow: @escaping (_ index: Int)->(String)) {
        self.inputView = CustomPicker(pickerData: data,
                                      dropdownField: self,
                                      titleForRow: titleForRow)
    }
    
    func loadDropdownData(data: [Any],
                          titleForRow: @escaping (_ index: Int)->(String),
                          onSelect selectionHandler : @escaping (_ selectedIndex: Int) -> Void) {
        self.inputView = CustomPicker(pickerData: data,
                                      dropdownField: self,
                                      titleForRow: titleForRow,
                                      onSelect: selectionHandler)
    }
}
