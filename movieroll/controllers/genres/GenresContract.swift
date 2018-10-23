//
//  GenresContract.swift
//  movieroll
//
//  Created by Angelo Polotto on 23/10/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation

protocol GenresViewContract {
    func loadGenres()
    func showDialoag()
}

protocol GenresPresenterContract {
    func retrieveLanguages()
    func loadGenres()
}
