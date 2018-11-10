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
    let repository: IRepository
    let userSettings: IUserSettings
    
    func register(name: String, password: String, email: String, language: String,
                  region: String, theme: String) {
        repository.register(name: name, password: password, email: email, language: language, region: region, theme: theme, callback: {
                (register) in
                    self.userSettings.saveLogin(loginModel: register)
                    self.view.showDiscover()
            })
    }
    
    init(view: RegisterContractView, repository: IRepository, userSettings: IUserSettings) {
        self.view = view
        self.repository = repository
        self.userSettings = userSettings
    }
}
