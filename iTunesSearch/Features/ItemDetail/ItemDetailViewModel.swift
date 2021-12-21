//
//  ItemDetailViewModel.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

class ItemDetailViewModel: ItemDetailViewModelProtocol {

    // MARK: - Dependencies

    weak var delegate: ItemDetailViewModelDelegate?

    // MARK: - Variables
    
    var itemModel: ItemListModel?
    
    // MARK: - Init
    
    init(delegate: ItemDetailViewModelDelegate?, itemModel: ItemListModel?) {
        self.delegate = delegate
        self.itemModel = itemModel
    }
}
