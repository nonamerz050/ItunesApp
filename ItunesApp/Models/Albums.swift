//
//  Albums.swift
//  ItunesApp
//
//  Created by MacBook Pro on 28/2/22.
//

import Foundation

struct SearchResults: Decodable {
    let resultCount: Int
    let results: [Albums]
}

struct Albums: Decodable {
    var artistName: String
    var collectionName: String
    var collectionId: Int?
    var artworkUrl100: String?
    var trackCount: Int?
    var trackName: String?
    var trackNumber: Int?
}
