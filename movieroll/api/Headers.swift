//
//  Headers.swift
//  movieroll
//
//  Created by Polotto on 08/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

struct Headers {
    public static let NoAuth = [
        "Content-Type":"application/json",
        "Accept": "application/json"
    ]
    
    public static var token: String = ""
    public static var tokenPrivateAuth: String = ""
    
    public static let AuthPublic = [
        "Content-Type":"application/json",
        "Accept": "application/json",
        "Authorization": String(format: "Bearer %@", token)
    ]
    
    public static let AuthPrivate = [
        "Content-Type":"application/json",
        "Accept": "application/json",
        "Authorization": String(format: "Bearer %@", tokenPrivateAuth)
    ]
}
