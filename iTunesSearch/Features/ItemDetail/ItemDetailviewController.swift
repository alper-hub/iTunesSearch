//
//  ItemDetailviewController.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import UIKit

class ItemDetailViewController: BaseViewController {

    // MARK: - Variables
    
    var viewModel: ItemDetailViewModelProtocol?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private weak var itemTitleLabel: UILabel!
    @IBOutlet private weak var itemOverviewLabel: UILabel!
    @IBOutlet private weak var genreOuterView: UIView!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var backButton: UIBarButtonItem!
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - SetupUI

    private func setupUI() {
        genreOuterView.setRounded()
        itemImage.layer.cornerRadius = GlobalConstants.cornerRadiusforCellItems
        fillImage()
        switch viewModel?.itemModel?.kind {
        case GlobalConstants.movie:
            itemTitleLabel.text = viewModel?.itemModel?.collectionTitle
            genreLabel.text = viewModel?.itemModel?.genre
            itemOverviewLabel.text = viewModel?.itemModel?.longDescription
        case GlobalConstants.music:
            itemTitleLabel.text = viewModel?.itemModel?.collectionTitle
            genreLabel.text = viewModel?.itemModel?.genre
            itemOverviewLabel.text = viewModel?.itemModel?.artist
        case GlobalConstants.ebook:
            itemTitleLabel.text = viewModel?.itemModel?.trackTitle
            genreLabel.text = viewModel?.itemModel?.genres?.first
            itemOverviewLabel.text = viewModel?.itemModel?.description?.html2String
        case GlobalConstants.podcast:
            itemTitleLabel.text = viewModel?.itemModel?.collectionTitle
            genreLabel.text = viewModel?.itemModel?.genre
            itemOverviewLabel.text = viewModel?.itemModel?.artist
        default:
            break
        }
    }

    private func fillImage() {
        if let imagePath = viewModel?.itemModel?.posterPath {
            if let imageUrl = URL(string: imagePath) {
                itemImage.loadImage(url: imageUrl, placeholder: UIImage(named: GlobalConstants.placeholderMovieIcon))
            }
        }
    }
}

extension ItemDetailViewController: ItemDetailViewModelDelegate {}
