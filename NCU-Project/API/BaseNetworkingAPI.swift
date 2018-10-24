//
//  BaseNetworkingAPI.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 15/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

protocol BaseNetworkingAPI {
    static var baseURL: BaseURL { get }
    associatedtype Endpoints
}

final class BaseURL {
    
    private let urlString: String
    
    init(_ urlString: String) {
        self.urlString = urlString
    }
    
    func url(for endpoint: String, from components: [String : String]) -> URL {
        
        var urlComponents = URLComponents(string: endpoint)!
        
        var queryItems: [URLQueryItem] = []
        
        for keyValue in components {
            queryItems.append(URLQueryItem(name: keyValue.key, value: keyValue.value))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
    
    func urlRequest(for endpoint: String) -> URLRequest {
        return URLRequest(url: URL(string: urlString + endpoint)!)
    }
}
