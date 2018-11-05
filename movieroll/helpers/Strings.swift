//
//  StringResources.swift
//  movieroll
//
//  Created by Angelo Polotto on 26/10/18.
//  Copyright © 2018 Mobify. All rights reserved.
//
import Foundation

public class Strings: PropertyList {
    public var name: String
    public var bundle: Bundle
    
    static var shared = Strings(name: "Strings", bundle: Bundle.main)
    private init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }
}


public protocol PropertyList {
    var name: String { get }
    var bundle: Bundle { get }
}

extension PropertyList {
    public var dictionary: [String: Any]? {
        guard let path = bundle.path(forResource: name, ofType: "plist") else {
            return nil
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String : Any] else {
            return nil
        }
        return dictionary
    }
    public func value(forKey: String?, arguments: Any...) -> String {
        guard let key = forKey else {
            return "??? key ???"
        }
        guard var plist = dictionary else {
            return "??? \(name).plist ???"
        }
        if let value = plist[key] as? String {
            return value
        }
        let keys = key.components(separatedBy: ".")
        let last = keys.count - 1
        for i in 0 ..< last {
            guard let value = plist[keys[i]] as? [String: Any] else {
                return "??? \(keys[i]) ???"
            }
            plist = value
        }
        guard var value = plist[keys[last]] as? String else {
            return "??? \(key) ???"
        }
        if !arguments.isEmpty {
            for (index, argument) in arguments.enumerated() {
                value = value.replacingOccurrences(of: "{\(index)}", with: (argument as! String ?? "??? {\(index)} ???"))
            }
        }
        return value
    }
}
