//
//  ViewController.swift
//  movieroll
//
//  Created by Polotto on 06/08/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController: UITableViewController {
    var languages: [LanguageModel]?
    var selectedLanguage: LanguageModel?
    private var movieGenres: [GenreModel] = []
    private var tvGenres: [GenreModel] = []
    private var selectedGenre: GenreModel?
    private var isMovie: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // request the supported languages
        retrieveLanguages()
    }

    func retrieveLanguages() {
        // https://blog.faodailtechnology.com/how-to-use-alamofireobjectmapper-c0d9820779bf
        print("retrieve languages")
        let sv = UIViewController.displaySpinner(onView: self.view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(Urls.Languages, headers: Headers.NoAuth).responseArray {
        (response: DataResponse<[LanguageModel]>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIViewController.removeSpinner(spinner: sv)
            switch response.result {
            case .success:
                self.languages = response.result.value ?? []
                self.showDialoag()
            case .failure(let error):
                print(error)
            }
        }
    }

    func retrieveData() {
        let requestGroup =  DispatchGroup()

        //Need as many of these statements as you have Alamofire.requests
        requestGroup.enter()
        requestGroup.enter()
        requestGroup.enter()
        
        //show the loading dialog to user
        let sv = UIViewController.displaySpinner(onView: self.view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // request the public token
        print("retrieve publicToken")
        let parameters:Parameters = [
            "language": self.selectedLanguage!.language ?? "en-US",
            "region": self.selectedLanguage!.region ?? "US"
        ]
        Alamofire.request(Urls.PublicToken, method: .post, parameters: parameters,
                        encoding: JSONEncoding.default, headers: Headers.NoAuth)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let jsonResponse = response.result.value as! NSDictionary
                    if jsonResponse["token"] != nil {
                        Headers.token = String(describing: jsonResponse["token"]!)
                        print(Headers.token)
                    }
                    requestGroup.leave()
                    
                    // request the discovery with the token
                    print("retrieve movie genres")
                    Alamofire.request(Urls.GenresMovie, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Headers.AuthPublic)
                        .responseArray {
                            (response: DataResponse<[GenreModel]>) in
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            UIViewController.removeSpinner(spinner: sv)
                            switch response.result {
                            case .success:
                                self.movieGenres = response.result.value ?? []
                                requestGroup.leave()
                                
                                print("retrieve tv genres")
                                Alamofire.request(Urls.GenresTv, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Headers.AuthPublic)
                                    .responseArray {
                                        (response: DataResponse<[GenreModel]>) in
                                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                        UIViewController.removeSpinner(spinner: sv)
                                        switch response.result {
                                        case .success:
                                            self.tvGenres = response.result.value ?? []
                                            requestGroup.leave()
                                        case .failure(let error):
                                            print(error)
                                        }
                                }
                            case .failure(let error):
                                print(error)
                            }
                    }
                case .failure(let error):
                    print(error)
                }
        }

        //This only gets executed once all the above are done
        requestGroup.notify(queue: DispatchQueue.main, execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIViewController.removeSpinner(spinner: sv)
            // populate the list with the itens
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "Movies"
            default:
                return "TV"
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.movieGenres.count
        default:
            return self.tvGenres.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenresCell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = self.movieGenres[indexPath.row].name
            break
        default:
            cell.textLabel?.text = self.tvGenres[indexPath.row].name
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            self.selectedGenre = self.movieGenres[indexPath.row]
            self.isMovie = true
            break
        default:
            self.selectedGenre = self.tvGenres[indexPath.row]
            self.isMovie = false
            break
        }
        performSegue(withIdentifier: "DiscoverSegue", sender: self)
    }
    
    // show dialog to choose lang
    func showDialoag() {
        let langAlert = UIAlertController(title: "Choose your language",
                message: "The language preference to retrieve info about the movies", preferredStyle: .actionSheet)
        for lang in self.languages! {
            langAlert.addAction(UIAlertAction(title: lang.description, style: .default, handler: {
                (UIAlertAction) in
                self.selectedLanguage = lang
                SharedPref.write(key: "selected_language", value: (self.selectedLanguage?.toJSONString())!)
                print(lang)
                self.retrieveData()
            }))
        }
        self.present(langAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DiscoverSegue" {
            let controller = segue.destination as! DiscoverViewController
            controller.genre = self.selectedGenre
            controller.isMovie = self.isMovie
        }
    }
}
