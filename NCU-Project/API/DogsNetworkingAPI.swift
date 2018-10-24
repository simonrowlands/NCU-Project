//
//  DogsNetworkingAPI.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 19/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

import RxSwift

final class DogsNetworkingAPI: BaseNetworkingAPI {
    
    static var baseURL = BaseURL("https://dog.ceo/api")
    
    enum Endpoints: String {
        case allDogsList = "/breeds/list/all"
    }
    
    static func getDogs() -> Observable<[Dog]> {
        
        let urlRequest = baseURL.urlRequest(for: Endpoints.allDogsList.rawValue)
        
        return URLSession.shared.rx.json(request: urlRequest)
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
    }
}
