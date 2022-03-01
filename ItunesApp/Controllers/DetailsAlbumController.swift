//
//  DetailsAlbumController.swift
//  ItunesApp
//
//  Created by MacBook Pro on 1/3/22.
//

import UIKit

class DetailsAlbumController: UITableViewController {
    var songs = [Albums]()
    
    var albumName: Albums? {
        didSet {
            navigationItem.title = albumName?.collectionName
            fetchSongs()
        }
    }
    
    let cellId = "cellId"
    
    fileprivate func fetchSongs() {
        guard let album = albumName else { return }
        APIService.shared.fetchSongs(collectionID: "\(album.collectionId ?? 0)") { songs in
            self.songs = songs.filter({ $0.trackNumber != nil })
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    //MARK: - Setup TableView
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "SongCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    //MARK: - UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SongCell
        let song = songs[indexPath.row]
        cell.songs = song
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = albumName?.artistName
        label.textAlignment = .center
        label.numberOfLines = 2
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
