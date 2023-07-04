//
//  TabBarView.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 04/07/2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            CategoriesView()
                .tabItem{
                    Image(systemName: "list.bullet")
                    Text("Categories")
                }
            RegisterView()
                .tabItem{
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Logout")
                }
        }
        .navigationTitle("jjhhghgjjj")
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
