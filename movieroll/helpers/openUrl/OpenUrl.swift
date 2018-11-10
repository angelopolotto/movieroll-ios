//
//  OpenUrl.swift
//  movieroll
//
//  Created by Angelo Polotto on 10/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import UIKit

func openURL(url: String) {
    if let link = URL(string: url) {
        UIApplication.shared.open(link)
    }
}
