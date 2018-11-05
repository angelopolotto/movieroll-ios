//
//  DiscoverModel.swift
//  movieroll
//
//  Created by Polotto on 09/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import ObjectMapper

class DiscoverModel: Mappable {
    required init?(map: Map) {}
    
    public var result: [DiscoverItemModel]?
    public var page: Int?
    public var pages: Int?
    
    func mapping(map: Map) {
        self.result <- map["result"]
        self.page <- map["page"]
        self.pages <- map["pages"]
    }
}
