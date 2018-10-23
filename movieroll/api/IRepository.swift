//
// Created by Angelo Polotto on 15/10/2018.
// Copyright (c) 2018 Mobify. All rights reserved.
//

import Foundation

protocol IRepository {
    func retrieveDiscover(isMovie: Bool, genre: GenreModel, page: Int, callback: @escaping (_ response: DiscoverModel?) -> ())
}
