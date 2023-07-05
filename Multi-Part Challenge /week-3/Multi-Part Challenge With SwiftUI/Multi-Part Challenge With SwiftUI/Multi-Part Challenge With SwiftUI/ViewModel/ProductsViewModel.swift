//
//  ShowProductsViewModle.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 03/07/2023.

import Foundation
import Combine
class ProductsViewModel: ObservableObject {
    @Published var myFavoriteProducts: [Int] = []
    @Published var products :[Product] = []
    @Published var searchText = ""
    @Published var filteredProducts :[Product] = []
    private var subscriber: AnyCancellable?
    let userDefaults = UserDefaults.standard
    
    init(){
        myFavoriteProducts = UserDefaults.standard.array(forKey: "favoriteProducts") as? [Int] ?? []
        subscriber = $searchText
            .sink(receiveValue: { search in
                if self.searchText.isEmpty {
                    self.filteredProducts = self.products
                } else {
                    self.filteredProducts = self.products.filter { $0.title?.localizedCaseInsensitiveContains(search) ?? false }
                }
            })
    }
  
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
    
    func fetchFavoritesProducts(){
        observer = dataService.getFavoritesProducts()
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
                self?.filteredProducts = products
            })
    }
  
    
    func fetchAllProducts(){
        observer = dataService.getAllProducts()
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
                self?.filteredProducts = products
            })
    }
    
    func fetchProducts(categorie: String){
        observer = dataService.getProductsForCategorie(categorie: categorie)
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
                self?.filteredProducts = products
            })
    }
    
}
    


