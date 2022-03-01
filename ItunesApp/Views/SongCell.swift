//
//  SongCell.swift
//  ItunesApp
//
//  Created by MacBook Pro on 1/3/22.
//

import UIKit
import SDWebImage

class SongCell: UITableViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    var songs: Albums! {
        didSet {
//            songNameLabel.text = songs.trackName
            artistNameLabel.text = "\(songs.trackNumber ?? 0). \(songs.trackName ?? "")"

            guard let url = URL(string: songs.artworkUrl100 ?? "") else { return }
            
            albumImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}
