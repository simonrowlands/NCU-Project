//
//  User.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 19/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

struct User {
    let id: Int
    let name: String
    let username: String
    let email: String
}

extension User: Decodable {
    
    enum UserKeys: String, CodingKey {
        case id
        case name
        case username
        case email
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: UserKeys.self)
        
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let username: String = try container.decode(String.self, forKey: .username)
        let email: String = try container.decode(String.self, forKey: .email)
        
        self.init(id: id, name: name, username: username, email: email)
    }
}
