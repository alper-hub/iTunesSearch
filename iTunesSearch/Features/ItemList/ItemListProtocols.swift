//
//  ItemListContracts.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

protocol ItemListNetworkDelegate: AnyObject {
    
    func fetchItems(pageNumber: Int, query: String, genre: String)
}

protocol ItemListViewModelDelegate: AnyObject {
    
    func itemsFetched()
    func itemFetchError(error: Error?)
    func reloadCollectionView()
}

protocol ItemListViewModelProtocol: AnyObject {
    
    var displayedData: [ItemListModel?] { get set }
    var currentPage: Int {get set}
    var searchQuery: String {get set}
    var fetchItemType: FetchItemType {get set}

    
    func restoreSearch()
    func fetchItems(pageNumber: Int, query: String, genre: String)
}

enum FetchItemType {
    case searchedQuery
    case loadedMore
}

enum ErrorViewAppearance {
    case setHidden
    case setVisibleWithErrorMessage
    case setVisibleWithSearchMessage
}

