//
//  CellTitleViewModel.swift
//  BlogPostApp
//
//  Created by Balink on 26/06/2023.
//

import Foundation

class CellTitleViewModel {
    private var post: Post
    init(post: Post) {
        self.post = post
    }
    func getTitle() -> String {
        return post.title
    }
}
