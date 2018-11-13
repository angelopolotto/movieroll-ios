//
//  RegisterPresenter.swift
//  movieroll
//
//  Created by Angelo Polotto on 10/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

class RegisterPresenter: RegisterContractPresenter {
    let view: RegisterContractView
    let repository: RepositoryContract
    let userSettings: UserSettingsContract
    let validators: ValidatorsContract
    
    func register(name: String, password: String, email: String, language: String,
                  region: String, theme: String) {
        if validators.isValidName(text: name, onError: { message in view.nameError(message)}, onSuccess: { view.nameErrorHide() })
            &&
            validators.isValidEmail(text: email, onError: {message in view.emailError(message)}, onSuccess: { view.emailErrorHide() })
            &&
            validators.isValidPassword(text: password, onError: {message in view.passwordError(message)}, onSuccess: { view.passwordErrorHide() })
        {
            
            repository.register(name: name, password: password, email: email, language: language, region: region, theme: theme, callback: {
                (register) in
                self.userSettings.saveLogin(loginModel: register)
                self.view.showDiscover()
            })
        }
    }
    
    init(view: RegisterContractView, repository: RepositoryContract, userSettings: UserSettingsContract, validators: ValidatorsContract) {
        self.view = view
        self.repository = repository
        self.userSettings = userSettings
        self.validators = validators
    }
}
