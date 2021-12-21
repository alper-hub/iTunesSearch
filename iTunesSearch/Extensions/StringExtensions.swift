//
//  StringExtensions.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 22.12.2021.
//

import Foundation

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
