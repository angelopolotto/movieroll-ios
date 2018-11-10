//
//  DiscoverViewCell.swift
//  movieroll
//
//  Created by Polotto on 09/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import UIKit

class DiscoverViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homepage: String = ""
    var imdb: String = ""
    var traillersList: [VideoModel] = []
    var media_id: Int?
    var presenter: DiscoverContractPresenter?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var mediaType: UILabel!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var traillers: UICollectionView!
    
    @IBAction func officialPage(_ sender: UIButton) {
        presenter?.resolveUrl(url: self.homepage)
    }
    
    @IBAction func imdb(_ sender: UIButton) {
        presenter?.resolveUrl(url: self.imdb)
    }
    
    @IBAction func addToList(_ sender: UIButton) {
        presenter?.addToList(media_id: self.media_id!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.traillers.delegate = self
        self.traillers.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.traillersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: TraillerViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TraillerCell", for: indexPath) as? TraillerViewCell
        {
            if  indexPath.row < self.traillersList.count {
                let trailler = self.traillersList[indexPath.row]
                cell.title.text = trailler.title
                cell.thumbnail.image = #imageLiteral(resourceName: "placeholder")
                cell.thumbnail.downloadImageFrom(link: trailler.thumbnail ?? "", contentMode: UIViewContentMode.scaleAspectFit)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter?.resolveUrl(url: self.traillersList[indexPath.row].link ?? "")
    }
}
