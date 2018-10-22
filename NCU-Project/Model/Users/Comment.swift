//
//  Comment.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 19/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

struct Comment {
    let id: Int
    let postID: Int
    let name: String
    let email: String
    let body: String
}

extension Comment: Decodable {
    
    enum CommentKeys: String, CodingKey {
        case id
        case postID = "postId"
        case name
        case email
        case body
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CommentKeys.self)
        
        let id: Int = try container.decode(Int.self, forKey: .id)
        let postID: Int = try container.decode(Int.self, forKey: .postID)
        let name: String = try container.decode(String.self, forKey: .name)
        let email: String = try container.decode(String.self, forKey: .email)
        let body: String = try container.decode(String.self, forKey: .body)
        
        self.init(id: id, postID: postID, name: name, email: email, body: body)
    }
}
