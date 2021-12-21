//
//  ItemListService.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

class ItemListWebService: ItemListNetworkDelegate {
    
    private let sessionProvider = URLSessionProvider()
    weak var delegate: ItemListWebServiceDelegate?
    
    func fetchItems(pageNumber: Int, query: String, genre: String) {
        sessionProvider.request(type: ItemListBaseModel.self, service: ItemService.list(pageNumber: pageNumber, query: query, genre: genre)) { response in
            switch response {
            case let .success(itemBaseModel):
                self.delegate?.fetchedItemsSuccesFully(model: itemBaseModel)
            case let .failure(error):
                self.delegate?.itemFetchFailure(error: error)
            }
        }
    }
}
