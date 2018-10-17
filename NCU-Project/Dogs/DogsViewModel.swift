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
        let filterString: Observable<String?> // TODO: Remove this or filter dog results with it
    }
    
    struct Output {
        let networkRequestResult: Observable<[Dog]>
    }
    
    func transform(_ input: DogsViewModel.Input) -> DogsViewModel.Output {
        let networkRequestResult = NetworkingAPI.getDogs()
        return Output(networkRequestResult: networkRequestResult)
    }
}
