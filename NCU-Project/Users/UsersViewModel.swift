//
//  UsersViewModel.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 19/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

final class UsersViewModel: ViewModelType {
    
    struct Input {
        let postsButtonTap: ControlEvent<Void>
        let userButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let postsCount: Observable<Int>
        let commentsCount: Observable<Int>
        let userID: Observable<Int>
        let userPostCount: Observable<Int>
        let isLoading: Observable<Bool>
    }
    
    func transform(_ input: UsersViewModel.Input) -> UsersViewModel.Output {
        
        let activityIndicator = ActivityIndicator()
        
        let getPostsResponse = input.postsButtonTap.flatMap {
            Observable.zip(UsersNetworkingAPI.getPosts(), UsersNetworkingAPI.getComments())
                .observeOn(MainScheduler.instance)
                .trackActivity(activityIndicator)
        }.share()
        
        let getUserResponse = input.userButtonTap.flatMap {
            UsersNetworkingAPI.getRandomUser()
                .trackActivity(activityIndicator)
                .observeOn(MainScheduler.instance)
        }.share()
        
        let userPosts = getUserResponse
            .flatMap { user in
                UsersNetworkingAPI.getPosts(for: user!.id)
                    .trackActivity(activityIndicator)
            }
            .observeOn(MainScheduler.instance)
        
        return Output(postsCount: getPostsResponse.map { return $0.0.count },
                      commentsCount: getPostsResponse.map { return $0.0.count },
                      userID: getUserResponse.map { return $0!.id },
                      userPostCount: userPosts.map { return $0.count },
                      isLoading: activityIndicator.asObservable())
    }
}
