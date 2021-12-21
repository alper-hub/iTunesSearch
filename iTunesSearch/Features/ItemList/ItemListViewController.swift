//
//  ItemListViewController.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import UIKit

class ItemListViewController: BaseViewController {
   
    // MARK: - Variables
    
    private var viewModel: ItemListViewModelProtocol?
    
    // MARK: - Constants
    private struct Constants {
        
        static let cellWidthMultiplier: CGFloat = 0.425
        static let screenWidth = UIScreen.main.bounds.width
        static let cellWidth = screenWidth * Constants.cellWidthMultiplier
        static let cellHeight: CGFloat = Constants.cellWidth * 2.55
        static let footerHeight: CGFloat = 50
        static let collectionViewInset: CGFloat = 20
    }

    // MARK: - Outlets
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet weak var genreType: UISegmentedControl!
    @IBOutlet weak var infoMessage: UILabel!
    
    // MARK: - Actions
    
    @IBAction func indexChanged(_ sender: Any) {
        viewModel?.fetchItemType = .searchedQuery
        fetchFilteredItems(refreshOffset: true)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ItemListViewModel(delegate: self)
        setupUI()
        registerElements()
    }
    
    // MARK: - SetupUI
    
    func setupUI() {
        setupCollectionViewLayout()
        searchBar.setShowsCancelButton(false, animated: true)
        configureErrorView(appearance: .setVisibleWithSearchMessage)
    }

    // MARK: - Fetch Items with Filters

    private func fetchFilteredItems(refreshOffset: Bool) {
        showLoadingView()
        if refreshOffset {
            viewModel?.currentPage = 0
        }
        switch genreType.selectedSegmentIndex {
        case 0:
            viewModel?.fetchItems(pageNumber: viewModel?.currentPage ?? 0, query: viewModel?.searchQuery ?? "", genre: NetworkConstants.movie)
        case 1:
            viewModel?.fetchItems(pageNumber: viewModel?.currentPage ?? 0, query: viewModel?.searchQuery ?? "", genre: NetworkConstants.music)
        case 2:
            viewModel?.fetchItems(pageNumber: viewModel?.currentPage ?? 0, query: viewModel?.searchQuery ?? "", genre: NetworkConstants.ebook)
        case 3:
            viewModel?.fetchItems(pageNumber: viewModel?.currentPage ?? 0, query: viewModel?.searchQuery ?? "", genre: NetworkConstants.podcast)
        default:
            break;
        }
    }
    
    // MARK: - Setup CollectionView

    func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.footerReferenceSize = CGSize(width: Constants.screenWidth, height: Constants.footerHeight)
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = UIEdgeInsets(top: 0, left: Constants.collectionViewInset, bottom: 0, right: Constants.collectionViewInset)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionView.delegate = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
    }
    
    private func registerElements() {
        ItemListCollectionViewCell.register(to: collectionView)
        LoadMoreCollectionReusableView.registerForFooter(to: collectionView)
        searchBar.delegate = self
    }
    
    private func navigateToItemDetail(_ indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ItemDetailViewController.typeName) as? ItemDetailViewController {
            let viewModel = ItemDetailViewModel(delegate: detailVC, itemModel: viewModel?.displayedData[indexPath.item])
            detailVC.viewModel = viewModel
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    // MARK: - Collection View Methods

    private func configureErrorView(appearance: ErrorViewAppearance) {
        switch appearance {
        case .setHidden:
            errorView.isHidden = true
        case .setVisibleWithErrorMessage:
            errorView.isHidden = false
            infoMessage.text = GlobalConstants.errorMessageOops
        case .setVisibleWithSearchMessage:
            errorView.isHidden = false
            infoMessage.text = GlobalConstants.searchItemsMessage
        }
    }
}

// MARK: - Collection View Methods

extension ItemListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.displayedData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let itemCell: ItemListCollectionViewCell = collectionView.dequeue(for: indexPath)
        itemCell.itemListCollectionCellData = viewModel?.displayedData[indexPath.item]
        return itemCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let loadMoreFooter: LoadMoreCollectionReusableView = collectionView.dequeueSupplementaryView(withIdentifier: LoadMoreCollectionReusableView.typeName, for: indexPath)
        loadMoreFooter.delegate = self
        loadMoreFooter.setLoadMoreButtonVisibility(isHidden: viewModel?.displayedData.isEmpty ?? true)
        return loadMoreFooter
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToItemDetail(indexPath)
    }
}


// MARK: - LoadMoreButton

extension ItemListViewController: LoadMoreDelegate {
    
    func loadMorePressed() {
        viewModel?.currentPage += NetworkConstants.pageLimit
        viewModel?.fetchItemType = .loadedMore
        fetchFilteredItems(refreshOffset: false)
    }
}

// MARK: - Search Bar and Keyboard

extension ItemListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchQuery = searchText.lowercased()
        viewModel?.fetchItemType = .searchedQuery
        if searchText.isEmpty {
            restoreSearchResults()
            configureErrorView(appearance: .setVisibleWithSearchMessage)
        } else {
            if searchText.count > 2 {
                fetchFilteredItems(refreshOffset: false)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if searchText.isEmpty {
                configureErrorView(appearance: .setVisibleWithSearchMessage)
            } else {
                configureErrorView(appearance: .setHidden)
            }
        }
        collectionView.reloadData()
        
        dismissKeyboard()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }

    
    private func restoreSearchResults() {
        viewModel?.restoreSearch()
        configureErrorView(appearance: .setHidden)
    }
}

// MARK: - Show Data

extension ItemListViewController: ItemListViewModelDelegate {
   
    func reloadCollectionView() {
        collectionView.reloadData()
    }
   
    func itemsFetched() {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.collectionView.reloadSections(IndexSet(integer: 0))
                self.hideLoadingView()
                if let displayedData = self.viewModel?.displayedData {
                    if displayedData.isEmpty {
                        self.configureErrorView(appearance: .setVisibleWithErrorMessage)
                    } else {
                        self.configureErrorView(appearance: .setHidden)
                    }
                }
            }
        }
    }
    
    func itemFetchError(error: Error?) {
        DispatchQueue.main.async {
            self.configureErrorView(appearance: .setVisibleWithErrorMessage)
            self.hideLoadingView()
            self.showError(error: error)
        }
    }
}
