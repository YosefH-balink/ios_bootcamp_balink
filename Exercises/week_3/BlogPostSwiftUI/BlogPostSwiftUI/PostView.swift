//
//  PostView.swift
//  MyFirstSwiftUI
//
//  Created by Balink on 27/06/2023.
//

import SwiftUI

struct PostView: View {
    var post: Post
    @State var showComments = false
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                    Text("Title")
                        .font(.largeTitle)
                    Spacer()
                }
                HStack{
                    Text(post.title ?? "")
                        .multilineTextAlignment(.center)
                }.padding(.horizontal)
                HStack{
                    Spacer()
                    Text("Post")
                        .font(.largeTitle)
                    Spacer()
                }
                HStack{
                    Text(post.body ?? "")
                        .multilineTextAlignment(.leading)
                }.padding(.horizontal)
                
                HStack{
                    Spacer()
                    Button {
                        showComments = !showComments
                    } label: {
                        Text(!showComments ? "Show Comments" : "Hide Comments")
                    }
                    Spacer()
                }.padding()
                Spacer()
                if showComments {
                    CommentsView(postId: post.id ?? 0)
                }
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
