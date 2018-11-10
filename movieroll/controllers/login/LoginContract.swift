//
//  LoginContract.swift
//  movieroll
//
//  Created by Angelo Polotto on 10/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

protocol LoginContractView {
    func showDiscover()
}

protocol LoginContractPresenter {
    func requestLogin(email: String, password: String)
}
