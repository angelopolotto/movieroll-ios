//
//  IUserSettings.swift
//  movieroll
//
//  Created by Angelo Polotto on 23/10/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

protocol IUserSettings {
    func getLanguages() -> LanguageModel?
    func saveLanguage(language: LanguageModel)
    func saveGenre(isMovie: Bool, genre: GenreModel)
    func getIsMovie() -> Bool
    func getGenre() -> GenreModel
}
