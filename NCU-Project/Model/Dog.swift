//
//  Dog.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 15/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

class Dog {
    
    var breed: String
    var subBreeds: [String]
    
    init(breed: String, subBreeds: [String]) {
        self.breed = breed
        self.subBreeds = subBreeds
    }
    
//    static func dogs(from json: [Any]) -> [Dog]? {
    
//        guard let dogDictionary = json as? [[String : [String]]] else {
//            debugPrint("Failed to convert dogJSON into dogArray")
//            return nil
//        }
        
//        let networkRequestResult = input.loginTaps
//            .flatMap {
//                NetworkApi.shared.getPosts()
//            }
//            .map { String(describing: $0) }
//
//        guard let dogDictionaries = json as? [String: [String : [String]]] else {
//            return nil
//        }
//
//        for dogDict in dogDictionary {
//            let dog = Dog(breed: , subBreeds: <#T##[String]#>)
//        }
//
//        return []
//    }
}
