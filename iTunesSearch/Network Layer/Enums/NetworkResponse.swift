//
//  NetworkResponse.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}
