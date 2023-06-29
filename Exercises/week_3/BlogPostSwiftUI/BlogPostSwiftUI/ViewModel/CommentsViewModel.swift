//
//  CommentsViewModel.swift
//  BlogPostSwiftUI
//
//  Created by Balink on 29/06/2023.
//

import Foundation
import Combine

class CommentsViewModel: ObservableObject {
    @Published private var comments:[Comments] = []
    var observer: AnyCancellable?
    
    func getCommentsFromServer(postId: Int){
        observer = DataServiceWithCombine.fetcComments(postId: postId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: {[weak self] value in
                print(value)
                self?.comments = value
            })
    }
    
    func getComments () -> [Comments] {
        return self.comments
    }
}
