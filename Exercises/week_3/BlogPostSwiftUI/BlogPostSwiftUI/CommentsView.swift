//
//  CommentsView.swift
//  BlogPostSwiftUI
//
//  Created by Balink on 29/06/2023.
//

import SwiftUI

struct CommentsView: View {
    var postId: Int
    @StateObject var commensViewModel = CommentsViewModel()
    var body: some View {
        List{
            ForEach(commensViewModel.getComments(), id: \.self) { comment in
                Text(comment.body ?? "")
            }
        }.onAppear{ commensViewModel.getCommentsFromServer(postId: postId) }
    }
}

//struct CommentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentsView()
//    }
//}
