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
    
    private init() {}
    
    func saveLanguage(language: LanguageModel) {
        <#code#>
    }
    
    func saveGenre(isMovie: Bool, genre: GenreModel) {
        <#code#>
    }
}
