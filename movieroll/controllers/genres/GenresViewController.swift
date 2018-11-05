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

class GenresViewController: BaseTableViewController, GenresViewContract {
    var presenter: GenresPresenterContract?
    private var movieGenres: [GenreModel] = []
    private var tvGenres: [GenreModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = GenresPresenter(view: self, repository: Repository(view: self), userSettings: UserSettings.shared)
        
        // request the supported languages
        presenter?.retrieveLanguages()
    }
    
    func populateList(movieGenres: [GenreModel], tvGenres: [GenreModel]) {
        self.movieGenres = movieGenres
        self.tvGenres = tvGenres
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return Strings.shared.value(forKey: "genres.section_movie")
            default:
                return Strings.shared.value(forKey: "genres.section_tv")
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
            self.presenter?.selectedItem(index: indexPath.row, isMovie: true)
            break
        default:
            self.presenter?.selectedItem(index: indexPath.row, isMovie: false)
            break
        }
        performSegue(withIdentifier: "DiscoverSegue", sender: self)
    }
    
    // show dialog to choose lang
    func showDialoag(languages: [LanguageModel]) {
        let langAlert = UIAlertController(title: Strings.shared.value(forKey: "genres.dialog_title"),
                                          message: Strings.shared.value(forKey: "genres.dialog_message"), preferredStyle: .actionSheet)
        for lang in languages {
            langAlert.addAction(UIAlertAction(title: lang.description, style: .default, handler: {
                (UIAlertAction) in
                self.presenter?.selectedLanguage(language: lang)
            }))
        }
        self.present(langAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DiscoverSegue" {
            self.presenter?.saveGenre()
        }
    }
}
