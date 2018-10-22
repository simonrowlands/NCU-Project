//
//  UsersNetworkingAPI.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 19/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

import RxSwift

final class UsersNetworkingAPI: BaseNetworkingAPI {
    
    static var baseURL = BaseURL("https://jsonplaceholder.typicode.com")
    
    static var posts = "/posts"
    static var comments = "/comments"
    static var users = "/users"
    
    static func getPosts() -> Observable<[Post]> {
        
        let urlRequest = baseURL.urlRequest(for: posts)
        
        return URLSession.shared.rx.data(request: urlRequest)
            .map { response -> [Post] in
                return try JSONDecoder().decode([Post].self, from: response)
        }
    }
    
    static func getPosts(for userID: Int) -> Observable<[Post]> {
        
        let url = baseURL.createURLComponents(endpoint: posts, components: ["userId" : String(userID)]) // This is done differently as we're passing in a urlQuery
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { response -> [Post] in
                return try JSONDecoder().decode([Post].self, from: response)
        }
    }
    
    static func getComments() -> Observable<[Comment]> {
        
        let urlRequest = baseURL.urlRequest(for: comments)
        
        return URLSession.shared.rx.data(request: urlRequest)
            .map { response -> [Comment] in
                return try JSONDecoder().decode([Comment].self, from: response)
        }
    }
    
    static func getUsers() -> Observable<[User]> {
        
        let urlRequest = baseURL.urlRequest(for: users)
        
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
