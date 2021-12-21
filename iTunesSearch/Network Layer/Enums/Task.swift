//
//  Task.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

typealias Parameters = [String: Any]

enum Task {
    case requestPlain
    case requestParameters(Parameters)
}
