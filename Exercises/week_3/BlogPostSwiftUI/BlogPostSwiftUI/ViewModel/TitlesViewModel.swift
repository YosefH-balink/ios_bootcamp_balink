//
//  TitlesViewModel.swift
//  MyFirstSwiftUI
//
//  Created by Balink on 27/06/2023.
//

import Foundation

class TitlesViewModel: ObservableObject {
    
    @Published var posts:[Post] = []
   
    func getPosts() async throws {
        do {

            try posts = await DataService().fetchPosts()
        }
        catch let error as ServerError {
            print(error)
        }
    }
    
//
//    func getPosts() ->[Post]? {
//        return self.posts
//    }

}

