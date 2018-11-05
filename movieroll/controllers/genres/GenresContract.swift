//
//  GenresContract.swift
//  movieroll
//
//  Created by Angelo Polotto on 23/10/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

protocol GenresViewContract {
    func populateList(movieGenres: [GenreModel], tvGenres: [GenreModel])
    func showDialoag(languages: [LanguageModel])
}

protocol GenresPresenterContract {
    func retrieveLanguages()
    func loadGenres()
    func selectedItem(index: Int, isMovie: Bool)
    func selectedLanguage(language: LanguageModel)
    func saveGenre()
}
