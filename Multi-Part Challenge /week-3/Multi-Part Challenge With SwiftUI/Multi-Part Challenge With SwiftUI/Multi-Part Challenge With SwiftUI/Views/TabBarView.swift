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
            ProductsListView(products: .favorites)
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            ProductsListView(products: .all)
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Search All Products")
                }
        }
        .accentColor(Color.yellow)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
