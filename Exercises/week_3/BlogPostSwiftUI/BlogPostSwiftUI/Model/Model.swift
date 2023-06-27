//
//  Model.swift
//  MyFirstSwiftUI
//
//  Created by Balink on 27/06/2023.
//

import Foundation

struct Post: Hashable, Decodable, Identifiable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

struct ServerError: Error {
    let message: String
}
