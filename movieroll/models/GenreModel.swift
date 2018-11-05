//
// Created by Polotto on 08/08/2018.
// Copyright (c) 2018 Mobify. All rights reserved.
//

import Foundation
import ObjectMapper

class GenreModel: Mappable {
    required init?(map: Map) {}

    public var _id: String?
    public var id: Int?
    public var name: String?

    func mapping(map: Map) {
        self._id <- map["_id"]
        self.id <- map["id"]
        self.name <- map["name"]
    }
}
