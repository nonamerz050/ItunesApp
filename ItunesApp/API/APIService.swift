//
//  APIService.swift
//  ItunesApp
//
//  Created by MacBook Pro on 28/2/22.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    func fetchAlbums(searchText:  String, complitionHandler: @escaping ([Albums]) -> ()) {
        let iTunesSearchURL = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "music", "entity": "album"]
        
        AF.request(iTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData {dataResponse in
            if let err = dataResponse.error { print("Failed to contact yahoo", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                complitionHandler(searchResult.results)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
        }
    }
    
    func fetchSongs(collectionID: String, complitionHandler: @escaping ([Albums]) -> ()) {
        let iTunesSearchURL = "https://itunes.apple.com/lookup"
        let parameters = ["id": collectionID, "media": "music", "entity": "song"]
        
        AF.request(iTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData {dataResponse in
            if let err = dataResponse.error { print("Failed to contact yahoo", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                complitionHandler(searchResult.results)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
        }
    }
}
