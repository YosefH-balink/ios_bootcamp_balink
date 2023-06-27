//
//  ContentView.swift
//  MyFirstSwiftUI
//
//  Created by Balink on 27/06/2023.
//

import SwiftUI


struct TitleView: View {
    
    @StateObject var titlesViewModel = TitlesViewModel()
       
    var body: some View {
        NavigationView {
            List(titlesViewModel.posts) { post in
                NavigationLink(post.title ?? "",
                               destination: PostView(post: post) )
            } .navigationTitle("Post Title")
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .task {
                    try? await titlesViewModel.getPosts()
                }
        }
    }
}



struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
