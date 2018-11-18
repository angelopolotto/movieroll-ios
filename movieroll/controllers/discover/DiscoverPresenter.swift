//
// Created by Angelo Polotto on 15/10/2018.
// Copyright (c) 2018 Mobify. All rights reserved.
//

import Foundation

class DiscoverPresenter: DiscoverContractPresenter {
    private var view: DiscoverContractView
    private var repository: RepositoryContract
    private var userSettings: UserSettingsContract
    private var discovered: DiscoverModel? = nil

    init(view: DiscoverContractView, repository: RepositoryContract, userSettings: UserSettingsContract) {
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
    
    func addToList(media_id: Int) {
        let login = self.userSettings.getLogin()
        if (login != nil) {
            self.repository.refresh(token: login!.token!, callback: { token in
                login?.token = token
                self.userSettings.saveLogin(loginModel: login!)
                self.repository.favoritesAdd(media_id: media_id.description) {
                    message in
                    self.view.showMessage(message: Strings.shared.value(forKey: "discover.added"))
                }
            })
        } else {
            view.showLogin()
        }
    }
    
    func resolveUrl(url: String) {
        view.resolveUrl(url: url)
    }
}
