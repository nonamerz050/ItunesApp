//
//  MusicCell.swift
//  ItunesApp
//
//  Created by MacBook Pro on 1/3/22.
//

import UIKit
import SDWebImage

class MusicCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songsCountLabel: UILabel!
    
    var albums: Albums! {
        didSet {
            albumNameLabel.text = albums.collectionName
            artistNameLabel.text = albums.artistName
            songsCountLabel.text = "\(albums.trackCount ?? 0) Songs"
            
            guard let url = URL(string: albums.artworkUrl100 ?? "") else { return }
            
            albumImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
