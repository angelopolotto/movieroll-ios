//
//  VideoModel.swift
//  movieroll
//
//  Created by Polotto on 09/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import ObjectMapper

class VideoModel: Mappable {
    required init?(map: Map) {}
    
    public var _id: String?
    public var title: String?
    public var link: String?
    public var thumbnail: String?
    
    func mapping(map: Map) {
        self._id <- map["_id"]
        self.title <- map["title"]
        self.link <- map["link"]
        self.thumbnail <- map["thumbnail"]
    }
}
