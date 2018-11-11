//
//  RegisterContract.swift
//  movieroll
//
//  Created by Angelo Polotto on 10/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

protocol RegisterContractView {
    func showDiscover()
    func nameError(_ message: String)
    func emailError(_ message: String)
    func passwordError(_ message: String)
    func nameErrorHide()
    func emailErrorHide()
    func passwordErrorHide()
}

protocol RegisterContractPresenter {
    func register(name: String, password: String, email: String, language: String,
                  region: String, theme: String)
}
