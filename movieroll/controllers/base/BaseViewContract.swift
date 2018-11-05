//
// Created by Angelo Polotto on 15/10/2018.
// Copyright (c) 2018 Mobify. All rights reserved.
//

import Foundation

protocol BaseViewContract {
    func showProgress()
    func hideProgress()
    func showError(message: String)
}
