//
//  ItemService.swift
//  iTunesSearch
//
//  Created by Alper Tufan on 16.12.2021.
//

import Foundation

enum ItemService: ServiceProtocol {
    
    case list(pageNumber: Int, query: String, genre: String)
    
    var baseURL: URL {
        return URL(string: NetworkConstants.baseUrl) ?? URL(fileURLWithPath: "")
    }
    
    var path: String {
        switch self {
        case .list(_, _, _):
            return ""
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .list(let pageNumber, let query, let genre):
            
            let parameters = [NetworkConstants.term: query,
                              NetworkConstants.offset: pageNumber,
                              NetworkConstants.entity: genre,
                              NetworkConstants.limit: NetworkConstants.pageLimit] as [String : Any]
            return .requestParameters(parameters)
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
