//
//  ItemListBaseModel.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

struct ItemListBaseModel: Decodable {
    
    var resultCount: Int?
    var results: [ItemListModel?]
}



