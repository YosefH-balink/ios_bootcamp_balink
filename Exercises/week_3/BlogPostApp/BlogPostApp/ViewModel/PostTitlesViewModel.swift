//
//  PostTitlesModelView.swift
//  BlogPostApp
//
//  Created by Balink on 26/06/2023.
//

import Foundation
import Combine

class PostTitlesViewModelWithCombine: ObservableObject {
    
    @Published private var posts:[Post] = []
    var observer: AnyCancellable?
    
    func getPostFromServer(){
        observer = DataServiceWithCombine.fetcPost()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: {[weak self] value in
                print(value)
                self?.posts = value
            })
    }
    
    func getnumberOfRows() -> Int{
        return self.posts.count
    }
    
    func getCellTitle(index: Int) -> CellTitleViewModel{
        let cellTitleViewModel = CellTitleViewModel(post: posts[index])
        return cellTitleViewModel
    }
}



// old PostTitlesViewModel with no Combine
//
//class PostTitlesViewModel {
//    private var posts:[Post]?
//   
//    func getPostTitles() async throws{
//        do {
//            try posts = await DataServiceWithAsyncAwait.shared.fetchPosts()
//        }
//        catch let error as ServerError {
//            print(error)
//        }
//    }
//
//    func getnumberOfRows() -> Int{
//        return self.posts?.count ?? 0
//    }
//    
//    func getCellTitle(index: Int) -> CellTitleViewModel{
//        let cellTitleViewModel = CellTitleViewModel(post: posts![index])
//        return cellTitleViewModel
//    }
//}


