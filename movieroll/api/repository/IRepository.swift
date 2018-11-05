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
}
