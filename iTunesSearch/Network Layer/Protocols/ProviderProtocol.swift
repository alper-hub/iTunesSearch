//
//  ProviderProtocol.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

protocol ProviderProtocol {
    
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable
}
