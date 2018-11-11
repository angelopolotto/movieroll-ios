//
// Created by Angelo Polotto on 15/10/2018.
// Copyright (c) 2018 Mobify. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class Repository: RepositoryContract {
    var view: BaseViewContract!
    
    static let shared = Repository()
    
    private init() {}
    
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
    
    func login(email: String, password: String, callback: @escaping (LoginModel) -> ()) {
        view.showProgress()
        
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(Urls.Login, method: .post, parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: Headers.NoAuth)
            .responseObject {
                (response: DataResponse<LoginModel>) in
                self.view.hideProgress()
                switch response.result {
                case .success:
                    Headers.tokenPrivateAuth = (response.result.value?.token)!
                    callback(response.result.value!)
                case .failure(let error):
                    self.view.showError(message: error.localizedDescription)
                    print(error)
                }
        }
    }
    
    func register(name:String,  password: String, email: String,
                  language:String, region:String, theme: String,
                  callback: @escaping (LoginModel) -> ()) {
        view.showProgress()
        
        let parameters: Parameters = [
            "name": name,
            "password": password,
            "email": email,
            "language": language,
            "region": region,
            "theme": theme
        ]
        
        Alamofire.request(Urls.Register, method: .post, parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: Headers.NoAuth)
            .responseObject {
                (response: DataResponse<LoginModel>) in
                self.view.hideProgress()
                switch response.result {
                case .success:
                    Headers.tokenPrivateAuth = (response.result.value?.token)!
                    callback(response.result.value!)
                case .failure(let error):
                    self.view.showError(message: error.localizedDescription)
                    print(error)
                }
        }
    }
    
    func refresh(token: String, callback: @escaping (_ response: String) -> ()) {
        view.showProgress()
        
        //show the loading dialog to user
        self.view.showProgress()
        
        let parameters: Parameters = [
            "token": token
        ]
        Alamofire.request(Urls.Refresh, method: .post, parameters: parameters,
                          encoding: JSONEncoding.default, headers: Headers.NoAuth)
            .responseJSON { response in
                self.view.hideProgress()
                switch response.result {
                case .success:
                    let jsonResponse = response.result.value as! NSDictionary
                    if jsonResponse["token"] != nil {
                        Headers.tokenPrivateAuth = String(describing: jsonResponse["token"]!)
                        print(Headers.tokenPrivateAuth)
                        callback(jsonResponse["token"]! as! String)
                    }
                case .failure(let error):
                    self.view.showError(message: error.localizedDescription)
                }
        }
    }
    
    func favoritesAdd(media_id: String, callback: @escaping (_ response: String?) -> ()) {
//        view.showProgress()
        Alamofire.request(Urls.Favorites + media_id,
                          method: .post,
                          headers: Headers.AuthPrivate)
            .responseJSON {
                (response) in
                let jsonResponse = response.result.value as! NSDictionary
//                self.view.hideProgress()
                switch response.result {
                case .success:
                    let message = jsonResponse["message"] as? String
                    if message != nil {
                        callback(message)
                    }
                case .failure(let error):
                    self.view.showError(message: error.localizedDescription)
                    print(error)
                }
        }
    }
    
    func favoritesList(callback: @escaping ([DiscoverItemModel]?) -> ()) {
        view.showProgress()
        Alamofire.request(Urls.Favorites,
                          method: .get,
                          headers: Headers.AuthPrivate)
            .responseArray {
                (response: DataResponse<[DiscoverItemModel]>) in
                self.view.hideProgress()
                switch response.result {
                case .success:
                    callback(response.result.value!)
                case .failure(let error):
                    self.view.showError(message: error.localizedDescription)
                    print(error)
                }
        }
    }
    
    func favoritesWatched(callback: @escaping ([DiscoverItemModel]?) -> ()) {
        view.showProgress()
        Alamofire.request(Urls.FavoritesWatched,
                          method: .get,
                          headers: Headers.AuthPrivate)
            .responseArray {
                (response: DataResponse<[DiscoverItemModel]>) in
                self.view.hideProgress()
                switch response.result {
                case .success:
                    callback(response.result.value!)
                case .failure(let error):
                    self.view.showError(message: error.localizedDescription)
                    print(error)
                }
        }
    }
    
    func favoritesDelete(media_id: String, callback: @escaping (String?) -> ()) {
        view.showProgress()
        Alamofire.request(Urls.Favorites + media_id,
                          method: .delete,
                          headers: Headers.AuthPrivate)
            .responseJSON {
                (response) in
                let jsonResponse = response.result.value as! NSDictionary
                self.view.hideProgress()
                switch response.result {
                case .success:
                    let message = jsonResponse["message"] as? String
                    if message != nil {
                        callback(message)
                    }
                case .failure(let error):
                    self.view.showError(message: error.localizedDescription)
                    print(error)
                }
        }
    }
}
