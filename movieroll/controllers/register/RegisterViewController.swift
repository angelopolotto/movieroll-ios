//
//  RegisterViewController.swift
//  movieroll
//
//  Created by Angelo Polotto on 13/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import iOSDropDown

class RegisterViewController: BaseViewController, RegisterContractView {
    var presenter: RegisterContractPresenter?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var region: DropDown!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBAction func register(_ sender: Any) {
        presenter?.register(
            name: name.text ?? "",
            password: password.text ?? "",
            email: email.text ?? "",
            language: "",
            region: "",
            theme: "")
    }
    
//    override func viewWillLayoutSubviews() {
//        region.layer.zPosition = 1
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameError.isHidden = true
        emailError.isHidden = true
        passwordError.isHidden = true
        
        region.bringSubview(toFront: self.view)
        
        region.placeholder = "Select a region"
        // The list of array to display. Can be changed dynamically
        region.optionArray = ["Option 1", "Option 2", "Option 3"]
        //Its Id Values and its optional
        region.optionIds = [1,23,54,22]
        // The the Closure returns Selected Index and String
        region.didSelect{(selectedText , index ,id) in
//            self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
        }
        
        Repository.shared.view = self
        presenter = RegisterPresenter(view: self, repository: Repository.shared, userSettings: UserSettings.shared, validators: Validators.shared)
    }
    
    func showDiscover() {
        performSegue(withIdentifier: "DiscoverRegisterSegue", sender: self)
    }
    
    func nameError(_ message: String) {
        nameError.isHidden = false
        nameError.text = message
    }
    
    func emailError(_ message: String) {
        emailError.isHidden = false
        emailError.text = message
    }
    
    func passwordError(_ message: String) {
        passwordError.isHidden = false
        passwordError.text = message
    }
    
    func nameErrorHide() {
        nameError.isHidden = true
    }
    
    func emailErrorHide() {
        emailError.isHidden = true
    }
    
    func passwordErrorHide() {
        password.isHidden = true
    }
}
