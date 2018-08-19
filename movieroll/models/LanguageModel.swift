//
//  Language.swift
//  movieroll
//
//  Created by Polotto on 08/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import ObjectMapper

class LanguageModel: Mappable {
    required init?(map: Map) {}
    
    var languageCode: String?
    var description :String?
    var language: String?
    var region: String?
    
    func mapping(map: Map) {
        self.languageCode <- map["languageCode"]
        self.description <- map["description"]
        self.language <- map["language"]
        self.region <- map["region"]
    }
}
