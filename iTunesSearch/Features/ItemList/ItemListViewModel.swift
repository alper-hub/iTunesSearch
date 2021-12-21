//
//  ItemListViewModel.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

class ItemListViewModel: ItemListViewModelProtocol {

    var displayedData: [ItemListModel?]
    var currentPage: Int
    var searchQuery: String
    var fetchItemType: FetchItemType
    var webService = ItemListWebService()

    // MARK: - Dependencies
    
    weak var delegate: ItemListViewModelDelegate?
    weak var webDelegate: ItemListNetworkDelegate?

    // MARK: - Init
    
    init(delegate: ItemListViewModelDelegate?) {
        displayedData = []
        self.delegate = delegate
        currentPage = 0
        searchQuery = ""
        fetchItemType = .searchedQuery
        webService.delegate = self
        self.webDelegate = webService
    }
    
    func setMovieData(model: ItemListBaseModel) {
        switch fetchItemType {
        case .searchedQuery:
            displayedData = model.results
        case .loadedMore:
            displayedData.append(contentsOf: model.results)
        }
    }
    
    func restoreSearch() {
        displayedData = []
        currentPage = 0
        searchQuery = ""
        delegate?.reloadCollectionView()
    }

    func fetchItems(pageNumber: Int, query: String, genre: String) {
        webDelegate?.fetchItems(pageNumber: pageNumber, query: query, genre: genre)
    }
}

extension ItemListViewModel: ItemListWebServiceDelegate {
    
    func fetchedItemsSuccesFully(model: ItemListBaseModel) {
        self.setMovieData(model: model)
        self.delegate?.itemsFetched()
    }
    
    func itemFetchFailure(error: Error?) {
        self.delegate?.itemFetchError(error: error)
    }
}
