//
//  GenresPresenter.swift
//  movieroll
//
//  Created by Angelo Polotto on 23/10/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

class GenresPresenter: GenresPresenterContract {
    var languages: [LanguageModel]?
    var selectedLanguage: LanguageModel?
    private var movieGenres: [GenreModel] = []
    private var tvGenres: [GenreModel] = []
    private var selectedGenre: GenreModel?
    private var isMovie: Bool = false
    
}
