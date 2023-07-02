//
//  Model.swift
//  part2
//
//  Created by Balink on 26/06/2023.
//

import Foundation

struct Product: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}

struct registerBody: Codable {
    let firstname: String
    let lastname: String
    let username: String
    let password: String
}

struct ServerError: Error {
    let message: String
}
