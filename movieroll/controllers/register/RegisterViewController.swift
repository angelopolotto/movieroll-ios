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

class RegisterViewController: BaseViewController, RegisterContractView {
    var presenter: RegisterContractPresenter?
    var selectedLanguage: LanguageModel?
    var languages: [LanguageModel]?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var region: UITextFieldPicker!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBAction func register(_ sender: Any) {
        presenter?.register(
            name: name.text ?? "",
            password: password.text ?? "",
            email: email.text ?? "",
            language: selectedLanguage?.language ?? "",
            region: selectedLanguage?.language ?? "",
            theme: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameError.isHidden = true
        emailError.isHidden = true
        passwordError.isHidden = true
        
        Repository.shared.view = self
        presenter = RegisterPresenter(view: self, repository: Repository.shared, userSettings: UserSettings.shared, validators: Validators.shared)
        
        presenter?.retrieveLanguages()
    }
    
    func selectedLanguage(language: LanguageModel) {
        region.text = language.description
    }
    
    func pickerList(languages: [LanguageModel]) {
        self.languages = languages
        region.loadDropdownData(data: languages, titleForRow: { (row) -> (String) in
            languages[row].description!
        }) { (row) in
            self.selectedLanguage = languages[row]
        }
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
