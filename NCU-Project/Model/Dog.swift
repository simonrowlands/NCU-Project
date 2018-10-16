//
//  Dog.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 15/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

struct Dog: Decodable {
    let breed: String
    let subBreeds: [String]
}
