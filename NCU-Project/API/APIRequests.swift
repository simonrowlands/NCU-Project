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

class APIRequests {
    
    static var shared = APIRequests()
    
    let dogsAPIString = "https://dog.ceo/api/breeds/list/all"
    
    func getDogsJSON() -> Observable<Any> {
        return URLSession.shared.rx.json(request: URLRequest(url: URL(string: dogsAPIString)!))
    }
}
