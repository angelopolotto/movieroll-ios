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
    
    @IBAction func login(_ sender: Any) {
        presenter?.requestLogin(email: email.text ?? "",
                                password: password.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Repository.shared.view = self
        presenter = LoginPresenter(view: self, repository: Repository.shared, userSettings: UserSettings.shared)
    }
    
    func showDiscover() {
        navigationController?.popViewController(animated: true)
    }
}
