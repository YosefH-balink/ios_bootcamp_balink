//
//  CategoriesViewModel.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import Foundation
import Combine

class CategoriesViewModel: ObservableObject{
    @Published var products :[Product] = []
    var categories :[String] = []
    @Published var uniqueCategories :[String] = []
    
    var observer: AnyCancellable?
    let dataService = DataService()
   
    init() {
        fetchProducts()
    }
    
    func getCategories() ->[String] {
        return self.uniqueCategories
    }
    
    func fetchProducts(){
        observer = dataService.getProducts(token: UserDefaults.standard.string(forKey: "accessToken") ?? "")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print(completion)  // prints finished
                    break
                case .failure(let error):
                    if let urlError = error as? NSError {
                        print("Error code: \(urlError.domain)")
                        print("Error message: \(urlError.localizedDescription)")
                        print("Error status: \(urlError.code)")
                    }
                }
            }, receiveValue: { [weak self] products in
                self?.products = products
                for product in products {
                    self?.categories.append(product.category ?? "")
                }
                self?.uniqueCategories = Array(Set(self?.categories ?? [""]))
                print("products---[0]-->",products[0])
               
            })
    }
    
    
}
