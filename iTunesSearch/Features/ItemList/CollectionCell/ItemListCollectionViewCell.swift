//
//  ItemListCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import UIKit

class ItemListCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants

    private struct Constants {
        
        static let screenWidth = UIScreen.main.bounds.width
        static let cellWidth = screenWidth * 0.425
    }
    
    // MARK: - Variables
    var itemListCollectionCellData: ItemListModel? {
        didSet {
            fillFields()
        }
    }
    let dateFormatter = DateFormatter()

    // MARK: - Outlets

    @IBOutlet private weak var outerView: UIView!
    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - SetupUI

    private func setupUI() {
        outerView.layer.cornerRadius = GlobalConstants.cornerRadiusforCellItems
        itemImage.layer.cornerRadius = GlobalConstants.cornerRadiusforCellItems
    }

    private func fillName() {
        if let collectionName = itemListCollectionCellData?.collectionTitle {
            itemTitle.text = collectionName
        } else {
            itemTitle.text = itemListCollectionCellData?.trackTitle ?? GlobalConstants.unknown
        }
    }

    private func fillImage() {
        if let imagePath = itemListCollectionCellData?.posterPath {
            if let imageUrl = URL(string: imagePath) {
                itemImage.loadImage(url: imageUrl, placeholder: UIImage(named: GlobalConstants.placeholderMovieIcon))
            }
        }
    }

    private func fillDate() {
        dateFormatter.dateFormat = GlobalConstants.dateFormat
        dateFormatter.locale = Locale(identifier: GlobalConstants.dateLocale)
        let date = dateFormatter.date(from: itemListCollectionCellData?.date ?? GlobalConstants.unknown)
        if let releasingDate = date {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            releaseDate.text = dateFormatter.string(from: releasingDate)
        }
    }

    private func fillPrice() {
        if let collectionPrice = itemListCollectionCellData?.collectionPrice {
            itemPrice.text = collectionPrice.priceTag(format: GlobalConstants.priceTagFormat)
        } else {
            itemPrice.text = itemListCollectionCellData?.trackPrice?.priceTag(format: GlobalConstants.priceTagFormat)
        }
    }
    
    private func fillFields() {
        fillName()
        fillImage()
        fillDate()
        fillPrice()
    }
}
