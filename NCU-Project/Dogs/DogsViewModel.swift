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

class DogsViewModel: ViewModelType {
    
    struct Input {
        let filterString: Observable<String?>
    }
    
    struct Output {
        let networkRequestResult: Observable<[Dog]>
    }
    
    func transform(_ input: DogsViewModel.Input) -> DogsViewModel.Output {
        
        let networkRequestResult = input.filterString
            .flatMap { _ in
                APIRequests.shared.getDogsJSON()
            }
            .map { anyDict -> [Dog] in
                
                guard let messageDict = anyDict as? [String : Any], let dict = messageDict["message"] as? [String : [String]] else {
                    debugPrint("Failed to read the very convoluted JSON") // TODO: Sort out the weird JSON dict response
                    return []
                }
                
                return dict.map({ key, value -> Dog in
                    return Dog(breed: key, subBreeds: value)
                })
            }
        
        return Output(networkRequestResult: networkRequestResult)
    }
}
