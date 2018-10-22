//
//  Post.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 19/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

struct Post {
    let id: Int
    let userID: Int
    let title: String
    let body: String
    
}

extension Post: Decodable {
    
    enum PostKeys: String, CodingKey {
        case id
        case userID = "userId"
        case title
        case body
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: PostKeys.self)
        
        let id: Int = try container.decode(Int.self, forKey: .id)
        let userID: Int = try container.decode(Int.self, forKey: .userID)
        let title: String = try container.decode(String.self, forKey: .title)
        let body: String = try container.decode(String.self, forKey: .body)
        
        self.init(id: id, userID: userID, title: title, body: body)
    }
}
