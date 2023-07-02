//
//  CategoriesViewModle.swift
//  part2
//
//  Created by Balink on 29/06/2023.
//

import Foundation

class CategoriesViewModle{
    private var products:[Product]?
    private var categories:[String] = []
    private var unique:[String]?
    func fetchCategories() async -> [String]?{
        
        do {
            try products = await DataService.shared.getProducts(token: UserDefaults.standard.string(forKey: "token") ?? "")
            for product in products! {
                categories.append(product.category!)
            }
            unique = Array(Set(categories))
            return unique ?? nil
        }catch {
            
        }
        return nil
    }
}
