//
//  ItemListModel.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

struct ItemListModel: Decodable {
    
    var collectionTitle: String?
    var posterPath: String?
    var date: String?
    var collectionPrice: Float?
    var kind: String?
    var trackTitle: String?
    var trackPrice: Float?
    var longDescription: String?
    var genre: String?
    var genres: [String]?
    var description: String?
    var artist: String?
    
    enum CodingKeys: String, CodingKey {
        case collectionTitle = "collectionName"
        case posterPath = "artworkUrl100"
        case date = "releaseDate"
        case collectionPrice = "collectionPrice"
        case kind = "kind"
        case trackTitle = "trackName"
        case trackPrice = "price"
        case longDescription = "longDescription"
        case genre = "primaryGenreName"
        case description = "description"
        case genres = "genres"
        case artist = "artistName"
    }
}
