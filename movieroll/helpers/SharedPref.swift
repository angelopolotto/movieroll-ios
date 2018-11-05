//
//  SharedPref.swift
//  movieroll
//
//  Created by Angelo Polotto on 13/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

struct SharedPref {
    static func read(key: String) -> Int {
        let preferences = UserDefaults.standard
        return preferences.integer(forKey: key)
    }
    
    static func read(key: String) -> String {
        let preferences = UserDefaults.standard
        return preferences.string(forKey: key)!
    }
    
    static func write(key: String, value: Int) {
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: key)
        preferences.synchronize()
    }
    
    static func write(key: String, value: String) {
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: key)
        preferences.synchronize()
    }
}
