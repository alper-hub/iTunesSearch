//
//  ItemDetailContracts.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

protocol ItemDetailViewModelDelegate: AnyObject {}

protocol ItemDetailViewModelProtocol: AnyObject {

    var itemModel: ItemListModel? {get set}
}
