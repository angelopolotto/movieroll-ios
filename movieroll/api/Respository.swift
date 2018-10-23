//
// Created by Angelo Polotto on 15/10/2018.
// Copyright (c) 2018 Mobify. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class Repository: IRepository {
    private var view: BaseViewContract

    init(view: BaseViewContract) {
        self.view = view
    }

    func retrieveDiscover(isMovie: Bool, genre: GenreModel, page: Int, callback: @escaping (_ response: DiscoverModel?) -> ()) {
        view.showProgress()

        var url: String
        if  isMovie {
            url = Urls.DiscoverMovie
        } else {
            url = Urls.DiscoverTv
        }
        
        let parameters: Parameters = [
            "with_genres": (genre.id)!,
            "page": page
        ]

        Alamofire.request(url, method: .get, parameters: parameters,
                            encoding: URLEncoding(destination: .queryString),
                            headers: Headers.AuthPublic)
                .responseObject {
                    (response: DataResponse<DiscoverModel>) in
                    self.view.hideProgress()
                    switch response.result {
                        case .success:
                            callback(response.result.value)
                        case .failure(let error):
                            self.view.showError(message: error.localizedDescription)
                            print(error)
                    }
                }
    }
}
