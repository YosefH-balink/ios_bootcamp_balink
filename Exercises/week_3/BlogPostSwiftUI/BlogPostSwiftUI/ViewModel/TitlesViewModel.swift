//
//  TitlesViewModel.swift
//  MyFirstSwiftUI
//
//  Created by Balink on 27/06/2023.
//

import Foundation
import Combine

class TitlesViewModel: ObservableObject {
    
    @Published private var posts:[Post] = []
    var observer: AnyCancellable?
    
    init() {
        getPostFromServer()
    }
    
    func getPostFromServer(){
        observer = DataServiceWithCombine.fetcPost()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: {[weak self] value in
                print(value)
                self?.posts = value
            })
    }
    
    func getPosts () -> [Post] {
        return self.posts
    }
}



