//
//  URLSessionProtocol.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

protocol URLSessionProtocol {
    
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
