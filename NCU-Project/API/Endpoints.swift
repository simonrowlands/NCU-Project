//
//  Endpoints.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 24/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

struct Endpoints {
    
    struct Dog {
        static let all = "/breeds/list/all"
    }
    
    struct User {
        static let posts = "/posts"
        static let comments = "/comments"
        static let users = "/users"
    }
}
