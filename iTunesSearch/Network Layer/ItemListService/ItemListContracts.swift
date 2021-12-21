//
//  ItemListContracts.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

protocol ItemListWebServiceDelegate: AnyObject {
    
    func fetchedItemsSuccesFully(model: ItemListBaseModel)
    func itemFetchFailure(error: Error?)

}
