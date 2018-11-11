//
//  Utils.swift
//  movieroll
//
//  Created by Polotto on 10/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import UIKit

func formatFloat(number: Float) -> String {
    return String(describing: number)
}

func formatDate(date: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
//    dateFormatter.locale = Locale(identifier: "en_US") //umcomment if you don't want to get the sistem default format.
    
    let dateObj: Date? = dateFormatterGet.date(from: date)
    
    return dateFormatter.string(from: dateObj!)
}
