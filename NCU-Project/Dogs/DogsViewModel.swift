//
//  DogsViewModel.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 15/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

final class DogsViewModel: ViewModelType {
    
    struct Input {
        let query: Observable<String?>
    }
    
    struct Output {
        let networkRequestResult: Observable<[Dog]>
    }
    
    func transform(_ input: DogsViewModel.Input) -> DogsViewModel.Output {
        
        let networkRequestResult = NetworkingAPI.getDogs()
        
        let filteredDogs = Observable.combineLatest(input.query, networkRequestResult) { (query, dogs) -> [Dog] in
            
            return dogs.filter { dog in
                
                if let query = query, !query.isEmpty {
                    return dog.breed.lowercased().contains(query.lowercased())
                }
                return true
            }
        }
        
        return Output(networkRequestResult: filteredDogs)
    }
}
