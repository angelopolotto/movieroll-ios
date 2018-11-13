//
//  LoginViewController.swift
//  movieroll
//
//  Created by Angelo Polotto on 13/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class LoginViewController: BaseViewController, LoginContractView {
    var presenter: LoginPresenter?
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBAction func login(_ sender: Any) {
        presenter?.requestLogin(email: email.text ?? "",
                                password: password.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailError.isHidden = true
        passwordError.isHidden = true
        
        Repository.shared.view = self
        presenter = LoginPresenter(view: self, repository: Repository.shared, userSettings: UserSettings.shared, validators: Validators.shared)
    }
    
    func showDiscover() {
        navigationController?.popViewController(animated: true)
    }
    
    func emailError(_ message: String) {
        emailError.isHidden = false
        emailError.text = message
    }
    
    func passwordError(_ message: String) {
        passwordError.isHidden = false
        passwordError.text = message
    }
    
    func emailErrorHide() {
        emailError.isHidden = true
    }
    
    func passwordErrorHide() {
        passwordError.isHidden = true
    }
}
