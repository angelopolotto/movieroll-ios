//
//  CutomPicker.swift
//  movieroll
//
//  Created by Angelo Polotto on 18/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//
import UIKit
import Foundation

class CustomPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    var pickerData : [Any]!
    var pickerTextField : UITextField!
    var selectionHandler : ((_ selectedIndex: Int) -> ())?
    var titleForRow: ((_ index: Int)->(String))?
    
    init(pickerData: [Any], dropdownField: UITextField, titleForRow: @escaping (_ index: Int)->(String)) {
        super.init(frame: CGRect.zero)
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        self.titleForRow = titleForRow
        
        self.delegate = self
        self.dataSource = self
        
        // Move to a background thread to do some long running work
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                if pickerData.count > 0 {
                    self.pickerTextField.text = self.titleForRow!(0)
                    self.pickerTextField.isEnabled = true
                } else {
                    self.pickerTextField.text = nil
                    self.pickerTextField.isEnabled = false
                }
            }
        }
        
        if self.pickerTextField.text != nil  && self.selectionHandler != nil {
            selectionHandler!(0)
        }
    }
    
    convenience init(pickerData: [Any],
                     dropdownField: UITextField,
                     titleForRow: @escaping (_ index: Int)->(String),
                     onSelect selectionHandler : @escaping (_ selectedIndex: Int) -> ()) {
        self.init(pickerData: pickerData, dropdownField: dropdownField, titleForRow: titleForRow)
        self.selectionHandler = selectionHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleForRow!(row)
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = titleForRow!(row)
        
        if self.pickerTextField.text != nil && self.selectionHandler != nil {
            selectionHandler!(row)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
