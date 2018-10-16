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
        let networkRequestResult: Observable<[String : [String : [String]]]>
    }
    
    func transform(_ input: DogsViewModel.Input) -> DogsViewModel.Output {
        
        let networkRequestResult = input.filterString
            .flatMap { _ in
                APIRequests.shared.getDogsJSON()
            }
            .map { anyDict -> [String : [String : [String]]] in
                
                guard let dict = anyDict as? [String : [String : [String]]] else {
                    debugPrint("Failed to read the very convoluted JSON") // TODO: Sort out the weird JSON dict response
                    return [:]
                }
                
                return dict
            }
        
        return Output(networkRequestResult: networkRequestResult)
    }
}
