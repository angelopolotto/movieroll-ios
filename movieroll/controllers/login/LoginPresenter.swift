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
    let repository: RepositoryContract
    let userSettings: UserSettingsContract
    let validators: ValidatorsContract
    var loginModel: LoginModel?
    
    init(view: LoginContractView, repository: RepositoryContract, userSettings: UserSettingsContract, validators: ValidatorsContract) {
        self.view = view
        self.repository = repository
        self.userSettings = userSettings
        self.validators = validators
    }
    
    func requestLogin(email: String, password: String) {
        if
            validators.isValidEmail(text: email, onError: {message in self.view.emailError(message)}, onSuccess: { view.emailErrorHide() } )
            &&
                validators.isValidPassword(text: password, onError: {message in self.view.passwordError(message)}, onSuccess: { view.passwordErrorHide() } )
        {
            self.repository.login(email: email, password: password) {
                (loginModel) in
                self.loginModel = loginModel
                self.userSettings.saveLogin(loginModel: loginModel)
                self.view.showDiscover()
            }
        }
    }
}
