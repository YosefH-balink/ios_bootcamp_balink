//
//  Model.swift
//  BlogPostApp
//
//  Created by Balink on 25/06/2023.
//

import Foundation

struct ServerError: Error {
    let message: String
}

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String    
}
