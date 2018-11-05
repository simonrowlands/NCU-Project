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
        let didLoad: Observable<Void>
        let query: Observable<String>
    }
    
    struct Output {
        let networkRequestResult: Observable<[Dog]>
        let isLoading: Observable<Bool>
    }
    
    func transform(_ input: DogsViewModel.Input) -> DogsViewModel.Output {
        
        let activityIndicator = ActivityIndicator()
        
        let dogs = input.didLoad
            .take(1)
            .flatMap {
                 DogsNetworkingAPI.getDogs()
                    .trackActivity(activityIndicator)
            }
            .share()
        
        let filteredDogs = input.query
            .withLatestFrom(dogs) { (query: $0, dogs: $1) }
            .map { response in // Filter response via search query
                response.dogs.filter { dog in
                    if !response.query.isEmpty {
                        return dog.breed.lowercased().contains(response.query.lowercased())
                    }
                    return true
                }
            }
        
        let result = Observable.merge(dogs, filteredDogs)
            .map { $0.sorted { $0.breed < $1.breed } }
        
        return Output(networkRequestResult: result, isLoading: activityIndicator.asObservable())
    }
}
