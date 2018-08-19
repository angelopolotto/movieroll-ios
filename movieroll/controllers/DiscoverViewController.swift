//
//  DiscoverViewController.swift
//  movieroll
//
//  Created by Polotto on 09/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DiscoverViewController: UITableViewController {
    var genre: GenreModel?
    var isMovie: Bool? = false
    var discovered: DiscoverModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveDiscover()
        self.tableView.allowsSelection = false
    }
    
    func retrieveDiscover() {
        print("retrieve discover")
        let sv = UIViewController.displaySpinner(onView: self.view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var url: String
        if  isMovie! {
            url = Urls.DiscoverMovie
        } else {
            url = Urls.DiscoverTv
        }
        let parameters: Parameters = [
            "with_genres": (self.genre?.id)!,
            "page": 1
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters,
                          encoding: URLEncoding(destination: .queryString), headers: Headers.AuthPublic)
            .responseObject {
                (response: DataResponse<DiscoverModel>) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                UIViewController.removeSpinner(spinner: sv)
                switch response.result {
                case .success:
                    self.discovered = response.result.value ?? nil
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((self.discovered?.result) != nil) {
            return self.discovered!.result!.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverCell", for: indexPath) as! DiscoverViewCell
        // populate cell with infos
        let media = self.discovered!.result![indexPath.row]
        cell.posterImageView.image = #imageLiteral(resourceName: "placeholder")
        cell.posterImageView.downloadImageFrom(link: Urls.MediaImage(media.poster_path!), contentMode: UIViewContentMode.scaleAspectFit)
        
        cell.title.text = media.title
        cell.genres.text = media.genres?.joined(separator: " ")
        cell.releaseLabel.text = media.release_date
        cell.mediaType.text = media.media_type
        cell.votes.text = formatFloat(number: media.vote_average!)
        cell.popularity.text = formatFloat(number: media.popularity!)
        cell.overview.text = media.overview
        cell.traillersList = media.videos ?? []
        cell.homepage = media.homepage ?? Urls.IMDB
        cell.imdb = media.imdb ?? Urls.IMDB
        cell.traillers.reloadData()
        return cell
    }

}
