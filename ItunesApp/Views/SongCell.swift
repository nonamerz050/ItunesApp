//
//  SongCell.swift
//  ItunesApp
//
//  Created by MacBook Pro on 1/3/22.
//

import UIKit
import SDWebImage

class SongCell: UITableViewCell {

    @IBOutlet weak var trackLabel: UILabel!
    
    var songs: Albums! {
        didSet {
            trackLabel.text = "\(songs.trackNumber ?? 0). \(songs.trackName ?? "")"
        }
    }
    
}
