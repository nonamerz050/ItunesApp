//
//  SearchViewController.swift
//  ItunesApp
//
//  Created by MacBook Pro on 1/3/22.
//

import UIKit
import Alamofire

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    let cellId = "cellId"
    
    var albums = [Albums]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Music"
        setupSearchBar()
        setupCollectionView()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UISearchBar
    
    fileprivate func setupSearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        APIService.shared.fetchAlbums(searchText: searchText) { music in
            self.albums = music.sorted(by: { $0.collectionName < $1.collectionName })
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - UICollectionView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 132)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsAlbumController = DetailsAlbumController()
        let album = self.albums[indexPath.row]
        detailsAlbumController.albumName = album
        navigationController?.pushViewController(detailsAlbumController, animated: true)
    }
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: "MusicCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MusicCell
        let album = self.albums[indexPath.row]
        cell.albums = album
        
        return cell
    }
}
