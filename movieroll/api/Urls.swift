//
//  Urls.swift
//  movieroll
//
//  Created by Polotto on 08/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

struct Urls {
    private struct Domains {
        static let Prod = "https://movieroll.app.polotto.cloud/"
    }
    
    private  struct Routes {
        static let Api = "api/v1/"
    }
    
    private  static let Domain = Domains.Prod
    private  static let Route = Routes.Api
    private  static let BaseURL = Domain + Route
    
    static var Languages: String {
        return BaseURL  + "auth/languages"
    }

    static var PublicToken: String {
        return BaseURL  + "auth/publicToken"
    }

    static var GenresMovie: String {
        return BaseURL  + "genres/movie"
    }

    static var GenresTv: String {
        return BaseURL  + "genres/tv"
    }
    
    static var DiscoverMovie: String {
        return BaseURL + "discover/movie"
    }
    
    static var DiscoverTv: String {
        return BaseURL + "discover/tv"
    }
    
    static var Login: String {
        return BaseURL + "auth/login"
    }
    
    static var Register: String {
        return BaseURL + "auth/register"
    }
    
    static var Refresh: String {
        return BaseURL + "auth/refreshToken"
    }
    
    static var Favorites: String {
        return BaseURL + "favorites/"
    }
    
    static var FavoritesWatched: String {
        return BaseURL + "favorites/watched"
    }
    
    static func MediaImage(_ path: String) -> String {
        return "http://image.tmdb.org/t/p/w185" + path
    }
    
    static var IMDB: String {
        return "https://imdb.com"
    }
}
