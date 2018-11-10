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
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var region: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func register(_ sender: Any) {
//        DiscoverRegisterSegue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Repository.shared.view = self
        presenter = RegisterPresenter(view: self, repository: Repository.shared, userSettings: UserSettings.shared)
    }
    
    func showDiscover() {}
}
