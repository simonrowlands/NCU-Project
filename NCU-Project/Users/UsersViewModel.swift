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
        let postsButtonTap: Observable<Void>
        let userButtonTap: Observable<Void>
    }
    
    struct Output {
        let postsCount: Observable<String>
        let commentsCount: Observable<String>
        let userID: Observable<String>
        let userPostCount: Observable<String>
        let isLoading: Observable<Bool>
    }
    
    func transform(_ input: UsersViewModel.Input) -> UsersViewModel.Output {
        
        let activityIndicator = ActivityIndicator()
        
        let getPostsResponse = input.postsButtonTap
            .flatMapLatest {
                Observable.zip(UsersNetworkingAPI.getPosts(), UsersNetworkingAPI.getComments())
                    .trackActivity(activityIndicator)
            }
            .observeOn(MainScheduler.instance)
            .share()
        
        let getUserResponse = input.userButtonTap
            .flatMap {
                UsersNetworkingAPI.getRandomUser()
                    .trackActivity(activityIndicator)
            }
            .observeOn(MainScheduler.instance)
            .share()
        
        let userPosts = getUserResponse
            .flatMap { user in
                UsersNetworkingAPI.getPosts(for: user!.id)
                    .trackActivity(activityIndicator)
            }
            .observeOn(MainScheduler.instance)
        
        return Output(postsCount: getPostsResponse.map { return "Posts: " + String($0.0.count) },
                      commentsCount: getPostsResponse.map { return "Comments: " + String($0.0.count) },
                      userID: getUserResponse.map { return "User ID: " + String($0!.id) },
                      userPostCount: userPosts.map { return  "Post Count: " + String($0.count) },
                      isLoading: activityIndicator.asObservable())
    }
}
