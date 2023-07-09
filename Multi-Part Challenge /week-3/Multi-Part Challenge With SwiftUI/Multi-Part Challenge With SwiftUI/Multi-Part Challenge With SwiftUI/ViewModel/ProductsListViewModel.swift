//
//  ShowProductsViewModle.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 03/07/2023.

import Foundation
import Combine

class ProductsListViewModel: ObservableObject {
    @Published var products :[Product] = []
    @Published var filteredProducts :[Product] = []
    @Published var myFavoriteProducts: [Int] = []
    @Published var searchText = ""
    private var subscriber: AnyCancellable?
    let userDefaults = UserDefaults.standard
    
    init(){
        myFavoriteProducts = userDefaults.array(forKey: "favoriteProducts") as? [Int] ?? []
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
        self.myFavoriteProducts = userDefaults.array(forKey: "favoriteProducts") as? [Int] ?? []
        if self.myFavoriteProducts.contains(productId) {
            self.myFavoriteProducts.removeAll { id in
                id == productId
            }
            userDefaults.set(self.myFavoriteProducts, forKey: "favoriteProducts")
            self.myFavoriteProducts = userDefaults.array(forKey: "favoriteProducts") as? [Int] ?? []
        } else {
            self.myFavoriteProducts.append(productId)
            userDefaults.set(self.myFavoriteProducts, forKey: "favoriteProducts")
            self.myFavoriteProducts = userDefaults.array(forKey: "favoriteProducts") as? [Int] ?? []
        }
    }
    
    func isFavorite(productId: Int) -> Bool {
        let favoriteProducts = userDefaults.array(forKey: "favoriteProducts") as? [Int] ?? []
        return favoriteProducts.contains(productId)
    }
    
    var dataService = ProductsAPI.shared
    var observer: AnyCancellable?
    
    func getProducts(products: ProductsListType, category: String?) {
        let favoriteProducts = userDefaults.array(forKey: "favoriteProducts") as? [Int] ?? []
        if products == .favorites && favoriteProducts.isEmpty  {
            print(favoriteProducts.isEmpty)
            filteredProducts = []
            return
        }
        observer = fetchData(products: products, category: category)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
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
    
    private func fetchData(products: ProductsListType, category: String?) -> AnyPublisher<[Product], Error> {
        switch products {
        case .all:
            return dataService.fetchProducts( products: .all)
        case .favorites:
            return dataService.fetchProducts(products: .favorites)
        case .category:
            return dataService.fetchProducts(categorie: category ?? "", products: .byCategory)
        }
    }
}
    


