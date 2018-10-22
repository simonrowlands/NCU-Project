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
}

final class BaseURL {
    
    private let baseURL: String
    
    init(_ baseURL: String) {
        self.baseURL = baseURL
    }
    
    func createURLComponents(endpoint: String, components: [String : String]) -> URL {
        
        var urlComponents = URLComponents(string: endpoint)!
        
        var queryItems: [URLQueryItem] = []
        
        for keyValue in components {
            queryItems.append(URLQueryItem(name: keyValue.key, value: keyValue.value))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
    
    func urlString(for endpoint: String) -> String {
        return baseURL + endpoint
    }
    
    func urlRequest(for endpoint: String) -> URLRequest {
        return URLRequest(url: URL(string: baseURL + endpoint)!)
    }
}
