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
}

protocol RegisterContractPresenter {
    func register(name: String, password: String, email: String, language: String,
                  region: String, theme: String)
}
