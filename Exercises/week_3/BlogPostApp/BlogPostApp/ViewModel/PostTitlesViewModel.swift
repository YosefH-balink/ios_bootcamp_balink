//
//  PostTitlesModelView.swift
//  BlogPostApp
//
//  Created by Balink on 26/06/2023.
//

import Foundation

class PostTitlesViewModel {
    
    private var posts:[Post]?
   
    func getPostTitles() async throws{
        do {
            try posts = await DataService.shared.fetchPosts()
        }
        catch let error as ServerError {
            print(error)
        }
    }

    func getnumberOfRows() -> Int{
        return self.posts?.count ?? 0
    }
    
    func getCellTitle(index: Int) -> CellTitleViewModel{
        let cellTitleViewModel = CellTitleViewModel(post: posts![index])
        return cellTitleViewModel
    }
}


