//
//  FloatExtensions.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 22.12.2021.
//

import Foundation

extension Float {

    func priceTag(format: String) -> String {
        return String(format: "%.2f", self) + "$"
    }
}
