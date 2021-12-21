//
//  UIViewExtensions.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation
import UIKit

extension UIView {
    
    func setRounded() {
        let radius = self.frame.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

