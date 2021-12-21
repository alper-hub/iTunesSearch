//
//  BaseViewController.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import UIKit

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    // MARK: - Variables

    private let loadingView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        view.alpha = GlobalConstants.loadingViewAlphaConstant
      return view
    }()
    
    private var activityView = UIActivityIndicatorView()
   
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // MARK: - SetupUI
    
    func setupActivityIndicator() {
        activityView.style = .large
        activityView.center = loadingView.center
        loadingView.addSubview(activityView)
    }
    
    private func setUpUI() {
        setNavigationBarAppearence()
        view.addSubview(loadingView)
        setupActivityIndicator()
        hideLoadingView()
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
        activityView.stopAnimating()
    }

    func showLoadingView() {
        loadingView.isHidden = false
        activityView.startAnimating()
    }

    private func setNavigationBarAppearence() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
    }
    
    // MARK: - initialization

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Actions

    func showError(error: Error?) {
        let alert = UIAlertController(title: GlobalConstants.errorMessageOops, message: error?.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: GlobalConstants.errorMessageOkay, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
