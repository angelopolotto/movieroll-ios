//
//  DiscoverItemModel.swift
//  movieroll
//
//  Created by Polotto on 09/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import ObjectMapper

class DiscoverItemModel: Mappable {
    required init?(map: Map) {}
    
    var status_type:String?
    var genres: [String]?
    var imdb: String?
    var homepage: String?
    var genre_ids: [Int]?
    var _id: String?
    var media_id: Int?
    var media_type: String?
    var vote_average: Float?
    var popularity: Float?
    var poster_path: String?
    var backdrop_path: String?
    var original_title: String?
    var original_language: String?
    var release_date: String?
    var language: String?
    var region: String?
    var title: String?
    var overview: String?
    var news: [String]?
    var videos: [VideoModel]?
    var updatedAt: String?
    var createdAt: String?
    
    func mapping(map: Map) {
        self.status_type <- map["status_type"]
        self.genres <- map["genres"]
        self.imdb <- map["imdb"]
        self.homepage <- map["homepage"]
        self.genre_ids <- map["genre_ids"]
        self._id <- map["_id"]
        self.media_id <- map["media_id"]
        self.media_type <- map["media_type"]
        self.vote_average <- map["vote_average"]
        self.popularity <- map["popularity"]
        self.poster_path <- map["poster_path"]
        self.backdrop_path <- map["backdrop_path"]
        self.original_title <- map["original_title"]
        self.original_language <- map["original_language"]
        self.release_date <- map["release_date"]
        self.language <- map["language"]
        self.region <- map["region"]
        self.title <- map["title"]
        self.overview <- map["overview"]
        self.news <- map["news"]
        self.videos <- map["videos"]
        self.updatedAt <- map["updatedAt"]
        self.createdAt <- map["createdAt"]
    }
}
