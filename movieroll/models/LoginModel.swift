//
//  LoginModel.swift
//  movieroll
//
//  Created by Angelo Polotto on 10/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginModel: Mappable {
    required init?(map: Map) {}

    public var user_id: String?
    public var name: String?
    public var email: String?
    public var language: String?
    public var region: String?
    public var theme: String?
    public var role: String?
    public var token: String?
    
    func mapping(map: Map) {
        self.user_id <- map["user_id"]
        self.name <- map["name"]
        self.email <- map["email"]
        
        self.language <- map["language"]
        self.region <- map["region"]
        self.theme <- map["theme"]
        self.role <- map["role"]
        self.token <- map["token"]
    }
}
