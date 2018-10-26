//
// Created by Angelo Polotto on 15/10/2018.
// Copyright (c) 2018 Mobify. All rights reserved.
//

import Foundation

class DiscoverPresenter: DiscoverContractPresenter {
    private var view: DiscoverContractView
    private var repository: IRepository
    private var userSettings: IUserSettings
    private var discovered: DiscoverModel? = nil

    init(view: DiscoverContractView, repository: IRepository, userSettings: IUserSettings) {
        self.view = view
        self.repository = repository
        self.userSettings = userSettings
    }

    func retrieveDiscover() {
        self.repository.retrieveDiscover(isMovie: self.userSettings.getIsMovie(),
                                         genre: self.userSettings.getGenre(), page: 1) { (discovered) in
                                    self.discovered = discovered
                                    self.view.loadContent(result: self.discovered?.result)
        }
    }
}
