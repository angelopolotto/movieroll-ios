//
//  LoginPresenter.swift
//  movieroll
//
//  Created by Angelo Polotto on 10/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

class LoginPresenter: LoginContractPresenter {
    let view: LoginContractView!
    let repository: IRepository
    let userSettings: IUserSettings
    var loginModel: LoginModel?
    
    init(view: LoginContractView, repository: IRepository, userSettings: IUserSettings) {
        self.view = view
        self.repository = repository
        self.userSettings = userSettings
    }
    
    func requestLogin(email: String, password: String) {
        self.repository.login(email: email, password: password) {
            (loginModel) in
            self.loginModel = loginModel
            self.userSettings.saveLogin(loginModel: loginModel)
        }
    }
}
