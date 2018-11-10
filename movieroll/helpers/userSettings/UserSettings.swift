//
//  UserSettings.swift
//  movieroll
//
//  Created by Angelo Polotto on 23/10/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

class UserSettings: IUserSettings {
    static let shared = UserSettings()
    
    var isMovie: Bool?
    var genre: GenreModel?
    
    private init() {}
    
    func saveLanguage(language: LanguageModel) {
        SharedPref.write(key: "selected_language", value: (language.toJSONString())!)
    }
    
    func getLanguages() -> LanguageModel? {
        let language: String? = SharedPref.read(key: "selected_language")
        if (language != nil) {
            return LanguageModel(JSONString: language!)
        } else {
            return nil
        }
    }
    
    func saveGenre(isMovie: Bool, genre: GenreModel) {
        self.isMovie = isMovie
        self.genre = genre
    }
    
    func getIsMovie() -> Bool {
        return self.isMovie!
    }
    
    func getGenre() -> GenreModel {
        return self.genre!
    }
    
    func saveLogin(loginModel: LoginModel) {
        SharedPref.write(key: "login_data", value: (loginModel.toJSONString())!)
    }
    
    func getLogin() -> LoginModel? {
        let login: String? = SharedPref.read(key: "login_data")
        if (login != nil) {
            return LoginModel(JSONString: login!)
        } else {
            return nil
        }
    }
}
