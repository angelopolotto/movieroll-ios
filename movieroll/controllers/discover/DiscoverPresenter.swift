//
// Created by Angelo Polotto on 15/10/2018.
// Copyright (c) 2018 Mobify. All rights reserved.
//

import Foundation

class DiscoverPresenter: DiscoverContractPresenter {
    private var view: DiscoverContractView
    private var repository: IRepository
    var genre: GenreModel?
    var isMovie: Bool? = false
    var discovered: DiscoverModel? = nil

    init(view: DiscoverContractView, repository: IRepository) {
        self.view = view
        self.repository = repository
    }

    func retrieveDiscover() {
        self.repository.retrieveDiscover(isMovie: self.isMovie!,
                                         genre: self.genre!, page: 1) { (discovered) in
                                    self.discovered = discovered
                                    self.view.loadContent(result: self.discovered?.result)
        }
    }
}
