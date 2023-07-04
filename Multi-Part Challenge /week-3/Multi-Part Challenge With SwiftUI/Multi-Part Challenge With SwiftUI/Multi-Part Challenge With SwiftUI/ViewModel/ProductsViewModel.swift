//
//  ShowProductsViewModle.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 03/07/2023.

import Foundation
import Combine
class ProductsViewModel: ObservableObject {
    @Published var products :[Product] = []
    @Published var myFavoriteProducts: [Int] = []
    
    init(){
        myFavoriteProducts = UserDefaults.standard.array(forKey: "favoriteProducts") as? [Int] ?? []
    }
    
    let userDefaults = UserDefaults.standard
    
    func toggleFavorite(productId: Int) {
        if self.myFavoriteProducts.contains(productId) {
            self.myFavoriteProducts.removeAll { id in
                id == productId
            }
            userDefaults.set(self.myFavoriteProducts, forKey: "favoriteProducts")
        } else {
            self.myFavoriteProducts.append(productId)
            userDefaults.set(self.myFavoriteProducts, forKey: "favoriteProducts")
        }
    }
    
    func isFavorite(productId: Int) -> Bool {
        return self.myFavoriteProducts.contains(productId)
    }
    
    let dataService = DataService.shared
    var observer: AnyCancellable?
    func fetchProducts(categorie: String){
        observer = dataService.getProductsForCategorie(token: UserDefaults.standard.string(forKey: "accessToken") ?? "", categorie: categorie)
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
            })
    }
    
}
    


