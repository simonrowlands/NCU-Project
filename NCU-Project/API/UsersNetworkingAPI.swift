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
    
    static let baseURL = BaseURL("https://jsonplaceholder.typicode.com")
    
    enum Endpoints: String {
        case posts = "/posts"
        case comments = "/comments"
        case users = "/users"
    }
    
    static func getPosts() -> Observable<[Post]> {
        
        let urlRequest = baseURL.urlRequest(for: Endpoints.posts.rawValue)
        
        return URLSession.shared.rx.data(request: urlRequest)
            .map { response -> [Post] in
                return try JSONDecoder().decode([Post].self, from: response)
        }
    }
    
    static func getPosts(for userID: Int) -> Observable<[Post]> {
        
        var urlRequest = baseURL.urlRequest(for: Endpoints.posts.rawValue)
        
        urlRequest.url = baseURL.url(for: Endpoints.posts.rawValue, from: ["userId" : String(userID)]) // This is done differently as we're passing in a urlQuery
        
        return URLSession.shared.rx.data(request: urlRequest)
            .map { response -> [Post] in
                return try JSONDecoder().decode([Post].self, from: response)
        }
    }
    
    static func getComments() -> Observable<[Comment]> {
        
        let urlRequest = baseURL.urlRequest(for: Endpoints.comments.rawValue)
        
        return URLSession.shared.rx.data(request: urlRequest)
            .map { response -> [Comment] in
                return try JSONDecoder().decode([Comment].self, from: response)
        }
    }
    
    static func getUsers() -> Observable<[User]> {
        
        let urlRequest = baseURL.urlRequest(for: Endpoints.users.rawValue)
        
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
