//
//  Modle.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 03/07/2023.
//

import Foundation

struct registerBody: Codable {
    let firstname: String
    let lastname: String
    let username: String
    let password: String
}

struct loginBody: Codable {
    let username: String
    let password: String
}

struct AccessToken: Decodable {
    let token: String?
    let type: String?
    let expire: Int?
    let firstname: String?
    let lastname: String?
}

struct ErrorResponse: Codable {
    let code: String
    let message: String
    let status: Int
}

struct Product: Codable, Identifiable, Hashable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Int?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: URL?
    let images: [URL]?
}
