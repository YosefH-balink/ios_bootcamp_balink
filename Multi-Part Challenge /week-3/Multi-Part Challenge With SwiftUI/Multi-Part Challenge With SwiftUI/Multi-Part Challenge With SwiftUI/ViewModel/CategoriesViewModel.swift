//
//  CategoriesViewModel.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import Foundation
import Combine

class CategoriesViewModel: ObservableObject{
    @Published var categories :[String] = []
    static var shared = CategoriesViewModel()
    let dataService = DataService.shared
    var observer: AnyCancellable?
    
    init() {
        fetchCategories()
    }
    
    func fetchCategories(){
        observer = dataService.getCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // print(completion)  // prints finished
                    break
                case .failure(let error):
                    if let urlError = error as? NSError {
                        print("Error code: \(urlError.domain)")
                        print("Error message: \(urlError.localizedDescription)")
                        print("Error status: \(urlError.code)")
                    }
                }
            }, receiveValue: { [weak self] categories in
                self?.categories = categories
            })
    }
}
