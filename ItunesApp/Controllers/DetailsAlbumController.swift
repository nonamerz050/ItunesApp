//
//  DetailsAlbumController.swift
//  ItunesApp
//
//  Created by MacBook Pro on 1/3/22.
//

import UIKit
import SDWebImage

class DetailsAlbumController: UITableViewController {
    private let cellId = "cellId"
    
    var songs = [Albums]()
    var albumName: Albums? {
        didSet {
            navigationItem.title = albumName?.collectionName
            fetchSongs()
        }
    }
    
    private func fetchSongs() {
        guard let album = albumName else { return }
        APIService.shared.fetchSongs(collectionID: "\(album.collectionId ?? 0)") { songs in
            self.songs = songs.filter({ $0.trackNumber != nil })
            DispatchQueue.main.async {
                self.tableView.reloadData()                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK: - Setup TableView
    
    private func setupTableView() {
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func headerView() -> UIView  {
        guard let url = URL(string: albumName?.artworkUrl100 ?? "") else { return UIView() }
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
            imageView.sd_setImage(with: url)
            return imageView
        }()
        
        let textLabel: UILabel = {
            let label = UILabel()
            label.widthAnchor.constraint(equalToConstant: self.view.frame.width - 20).isActive = true
            label.numberOfLines = 0
            label.text = albumName?.artistName ?? ""
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            return label
        }()
        
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = NSLayoutConstraint.Axis.vertical
            stackView.distribution = UIStackView.Distribution.equalSpacing
            stackView.alignment = UIStackView.Alignment.center
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(textLabel)
            return stackView
        }()
        
        return stackView
    }
}
