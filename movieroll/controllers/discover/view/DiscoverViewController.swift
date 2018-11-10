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

class DiscoverViewController: BaseTableViewController, DiscoverContractView {
    private var presenter: DiscoverContractPresenter?
    private var result: [DiscoverItemModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Repository.shared.view = self
        presenter = DiscoverPresenter(view: self,
                                      repository: Repository.shared,
                                      userSettings: UserSettings.shared)

        presenter?.retrieveDiscover()

        self.tableView.allowsSelection = false
    }
    
    func loadContent(result: [DiscoverItemModel]?) {
        self.result = result
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((self.result) != nil) {
            return self.result!.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverCell", for: indexPath) as! DiscoverViewCell
        // populate cell with infos
        let media = self.result![indexPath.row]
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
