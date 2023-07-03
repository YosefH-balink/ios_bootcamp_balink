//
//  ShowProductsViewModle.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 03/07/2023.
//

import Foundation
import Combine
class ProductsViewModel: ObservableObject {
    static var shared = ProductsViewModel()
   // var categorie: String = ""
    @Published var products :[Product] = []
    
    var observer: AnyCancellable?
    let dataService = DataService.shared
    

    
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
    
    

