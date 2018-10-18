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
        let query: Observable<String>
    }
    
    struct Output {
        let networkRequestResult: Observable<[Dog]>
    }
    
    func transform(_ input: DogsViewModel.Input) -> DogsViewModel.Output {
        
        let filteredDogs = input.query
            .throttle(1, scheduler: MainScheduler.instance) // Only poke request every second max
            .flatMapLatest { queryText -> Observable<(dogs: [Dog], query: String)> in
                NetworkingAPI.getDogs().map {
                    return ($0, queryText)
                }
            }
            .map { response in // Filter response via search query
                response.dogs.filter { dog in
                    if !response.query.isEmpty {
                        return dog.breed.lowercased().contains(response.query.lowercased())
                    }
                    return true
                }.sorted {
                    $0.breed < $1.breed
                }
        }
        
        return Output(networkRequestResult: filteredDogs)
    }
}
