//
//  PostView.swift
//  MyFirstSwiftUI
//
//  Created by Balink on 27/06/2023.
//

import SwiftUI

struct PostView: View {
    var post: Post
    var body: some View {
        NavigationView {
            VStack {
                Text("userId: \(post.userId ?? 0)")
                Text("id: \(post.id ?? 0)")
                Text("title: \(post.title ?? "")")
                Text("body: \(post.body ?? "")")
            }
          
        }.navigationTitle("Post")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
