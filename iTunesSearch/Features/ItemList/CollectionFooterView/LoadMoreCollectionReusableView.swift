//
//  LoadMoreCollectionReusableView.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 17.12.2021.
//

import UIKit

protocol LoadMoreDelegate: AnyObject {
    
    func loadMorePressed()
}

class LoadMoreCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Variables

    weak var delegate: LoadMoreDelegate?

    // MARK: - Outlets

    @IBOutlet weak var loadMoreButton: UIButton!
    
   // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        loadMoreButton.setRounded()
    }
    
    // MARK: - Actions

    func setLoadMoreButtonVisibility(isHidden: Bool) {
        loadMoreButton.isHidden = isHidden
    }
    
    @IBAction private func loadMorePressed(_ sender: Any) {
        delegate?.loadMorePressed()
    }
}
