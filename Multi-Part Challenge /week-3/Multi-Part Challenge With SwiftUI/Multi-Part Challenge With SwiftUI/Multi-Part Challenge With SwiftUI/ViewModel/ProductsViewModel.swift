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
    
    var dataService = DataService.shared
    var observer: AnyCancellable?
    
    func getProducts(products: ProductsList, category: String?) {
        observer = fetchData(products: products, category: category)
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
    
    private func fetchData(products: ProductsList, category: String?) -> AnyPublisher<[Product], Error> {
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
    


