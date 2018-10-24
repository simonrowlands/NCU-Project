//
//  UsersNetworkingAPI.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 19/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

import RxSwift

final class UsersNetworkingAPI: Networkable {
    
    static let baseURL = BaseURL("https://jsonplaceholder.typicode.com")
    
    static func getPosts() -> Observable<[Post]> {
        
        let urlRequest = baseURL.urlRequest(for: Endpoints.User.posts)
        
        return URLSession.shared.rx.data(request: urlRequest)
            .map { response -> [Post] in
                return try JSONDecoder().decode([Post].self, from: response)
        }
    }
    
    static func getPosts(for userID: Int) -> Observable<[Post]> {
        
        let urlString = baseURL.urlString(for: Endpoints.User.posts)
        let url = baseURL.url(for: urlString, from: ["userId" : String(userID)])
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { response -> [Post] in
                return try JSONDecoder().decode([Post].self, from: response)
        }
    }
    
    static func getComments() -> Observable<[Comment]> {
        
        let urlRequest = baseURL.urlRequest(for: Endpoints.User.comments)
        
        return URLSession.shared.rx.data(request: urlRequest)
            .map { response -> [Comment] in
                return try JSONDecoder().decode([Comment].self, from: response)
        }
    }
    
    static func getUsers() -> Observable<[User]> {
        
        let urlRequest = baseURL.urlRequest(for: Endpoints.User.users)
        
        return URLSession.shared.rx.data(request: urlRequest)
            .map { response -> [User] in
                return try JSONDecoder().decode([User].self, from: response)
            }
    }
    
    static func getRandomUser() -> Observable<User?> {
        
        return getUsers()
            .map { users -> User? in
                users.randomElement()
            }
    }
}
