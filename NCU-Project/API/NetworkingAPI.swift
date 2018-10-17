//
//  APIRequests.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 15/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class NetworkingAPI {
    
    enum APIEndpoint: String {
        
//        #if DEBUG
//            case baseURL = "https://dog.ceo/api" // Debug URL
//        #else
            case baseURL = "https://dog.ceo/api" // Live URL
//        #endif
        
        case allDogsList = "/breeds/list/all"
        
        
        func urlString() -> String {
            return APIEndpoint.baseURL.rawValue + self.rawValue
        }
    }
    
    static func getDogs() -> Observable<[Dog]> {
 
        return URLSession.shared.rx.json(request: URLRequest(url: URL(string: APIEndpoint.allDogsList.urlString())!))
            .map { anyDict -> [Dog] in
                
                guard let messageDict = anyDict as? [String : Any],
                    let dict = messageDict["message"] as? [String : [String]] else {
                    debugPrint("getDogs - Failed to read the very convoluted JSON response")
                    return []
                }
                
                return dict.map({ key, value -> Dog in
                    return Dog(breed: key, subBreeds: value)
                })
            }
        
        // TODO: Add to core data to prevent multiple requests
    }
}
