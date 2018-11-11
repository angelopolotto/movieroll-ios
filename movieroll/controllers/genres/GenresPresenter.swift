//
//  GenresPresenter.swift
//  movieroll
//
//  Created by Angelo Polotto on 23/10/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

class GenresPresenter: GenresPresenterContract {
    var view: GenresViewContract
    var repository: RepositoryContract
    var userSettings: UserSettingsContract
    var languages: [LanguageModel]?
    var selectedLanguage: LanguageModel?
    private var movieGenres: [GenreModel] = []
    private var tvGenres: [GenreModel] = []
    private var selectedGenre: GenreModel?
    private var isMovie: Bool = false
    
    init(view: GenresViewContract, repository: RepositoryContract, userSettings: UserSettingsContract) {
        self.view = view
        self.repository = repository
        self.userSettings = userSettings
    }
    
    func retrieveLanguages() {
        if let language = userSettings.getLanguages() {
            self.selectedLanguage(language: language)
        } else {
            repository.loadLanguages() { (languages) -> () in
                    self.languages = languages
                    self.view.showDialoag(languages: languages)
            }
        }
    }
    
    func selectedLanguage(language: LanguageModel) {
        self.selectedLanguage = language
        print(language)
        self.userSettings.saveLanguage(language: language)
        self.repository.loadToken(selectedLanguage: self.selectedLanguage!) { (token) -> () in
            self.loadGenres()
        }
    }
    
    func loadGenres() {
        repository.loadGenresMovieTv() { (movieGenres, tvGenres) -> () in
            self.movieGenres = movieGenres
            self.tvGenres = tvGenres
            self.view.populateList(movieGenres: self.movieGenres, tvGenres: self.tvGenres)
        }
    }
    
    func selectedItem(index: Int, isMovie: Bool) {
        self.isMovie = isMovie
        if isMovie {
            self.selectedGenre = self.movieGenres[index]
        } else {
            self.selectedGenre = self.tvGenres[index]
        }
    }
    
    func saveGenre() {
        self.userSettings.saveGenre(isMovie: self.isMovie, genre: self.selectedGenre!)
    }
}
