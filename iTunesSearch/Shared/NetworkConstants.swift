//
//  NetworkConstants.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

struct NetworkConstants {
    
    static let baseUrl =  "https://itunes.apple.com/search?"
    static let movieEndpoint = "/movie"
    static let popularEndPoint = "/popular"
    static let languageEndPoint = "language"
    static let englishUs = "en-US"
    static let apiKeyEndPoint = "api_key"
    static let apiKey = "fd2b04342048fa2d5f728561866ad52a"
    static let pageEndPoint = "page"
    static let imageURL = "https://image.tmdb.org/t/p/w200"
    static let bigImageURL = "https://image.tmdb.org/t/p/w500"
    static let term = "term"
    static let offset = "offset"
    static let limit = "limit"
    static let entity = "entity"
    static let pageLimit = 20
    static let movie = "movie"
    static let music = "song"
    static let ebook = "ebook"
    static let podcast = "podcast"

}
