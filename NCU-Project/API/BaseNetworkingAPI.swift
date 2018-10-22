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
    
    var baseURL: String
    
    init(_ baseURL: String) {
        self.baseURL = baseURL
    }
    
    func urlRequest(for endpoint: String) -> URLRequest {
        return URLRequest(url: URL(string: baseURL + endpoint)!)
    }
}
