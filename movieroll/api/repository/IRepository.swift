//
// Created by Angelo Polotto on 15/10/2018.
// Copyright (c) 2018 Mobify. All rights reserved.
//

import Foundation

protocol IRepository {
    func loadLanguages(callback: @escaping (_ languages: [LanguageModel]) -> ())
    
    func retrieveDiscover(isMovie: Bool, genre: GenreModel, page: Int, callback: @escaping (_ response: DiscoverModel?) -> ())
    
    func loadToken(selectedLanguage: LanguageModel, callback: @escaping (_ token: String) -> ())
    func loadGenresMovieTv(callback: @escaping (_ movieGenres: [GenreModel], _ tvGenres: [GenreModel]) -> ())

    func login(email:String, password: String, callback: @escaping (_ response: LoginModel) -> ())

    func register(name:String,  password: String, email: String,
                  language:String, region:String, theme: String,
                  callback: @escaping (_ response: LoginModel) -> ())
    
    func refresh(token: String, callback: @escaping (_ response: String) -> ())
    
    func favoritesList(callback: @escaping (_ response: [DiscoverItemModel]?) -> ())
    
    func favoritesWatched(callback: @escaping (_ response: [DiscoverItemModel]?) -> ())
    
    func favoritesAdd(media_id: String, callback: @escaping (_ response: String?) -> ())
    
    func favoritesDelete(media_id: String, callback: @escaping (_ response: String?) -> ())
}
