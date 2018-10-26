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
    
    func loadLanguages(callback: @escaping (_ languages: [LanguageModel]) -> ()) {
        // https://blog.faodailtechnology.com/how-to-use-alamofireobjectmapper-c0d9820779bf
        print("retrieve languages")
        self.view.showProgress()
        Alamofire.request(Urls.Languages, headers: Headers.NoAuth).responseArray {
            (response: DataResponse<[LanguageModel]>) in
            self.view.hideProgress()
            switch response.result {
            case .success:
                callback(response.result.value ?? [])
            case .failure(let error):
                self.view.showError(message: error.localizedDescription)
            }
        }
    }
    
    func loadToken(selectedLanguage: LanguageModel, callback: @escaping (_ token: String) -> ()) {
        //show the loading dialog to user
        self.view.showProgress()
        
        // request the public token
        print("retrieve publicToken")
        let parameters:Parameters = [
            "language": selectedLanguage.language as Any,
            "region": selectedLanguage.region as Any
        ]
        Alamofire.request(Urls.PublicToken, method: .post, parameters: parameters,
                          encoding: JSONEncoding.default, headers: Headers.NoAuth)
            .responseJSON { response in
                self.view.hideProgress()
                switch response.result {
                    case .success:
                        let jsonResponse = response.result.value as! NSDictionary
                        if jsonResponse["token"] != nil {
                            Headers.token = String(describing: jsonResponse["token"]!)
                            print(Headers.token)
                            callback(jsonResponse["token"]! as! String)
                        }
                    case .failure(let error):
                        self.view.showError(message: error.localizedDescription)
                }
        }
    }
    
    func loadGenresMovieTv(callback: @escaping (_ movieGenres: [GenreModel], _ tvGenres: [GenreModel]) -> ()) {
        view.showProgress()
        // request the discovery with the token
        print("retrieve movie genres")
        Alamofire.request(Urls.GenresMovie, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Headers.AuthPublic)
            .responseArray {
                (response: DataResponse<[GenreModel]>) in
                switch response.result {
                    case .success:
                        let movieGenres = response.result.value ?? []
                        print("retrieve tv genres")
                        Alamofire.request(Urls.GenresTv, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Headers.AuthPublic)
                            .responseArray {
                                (response: DataResponse<[GenreModel]>) in
                                self.view.hideProgress()
                                switch response.result {
                                    case .success:
                                        let tvGenres = response.result.value ?? []
                                        callback(movieGenres, tvGenres)
                                    case .failure(let error):
                                        self.view.showError(message: error.localizedDescription)
                                }
                            }
                    case .failure(let error):
                        self.view.hideProgress()
                        self.view.showError(message: error.localizedDescription)
                }
        }
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
