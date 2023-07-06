//
//  SearchBarView.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 05/07/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @StateObject var productsViewModel = ProductsViewModel()
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $searchText)
                    .padding(8)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    .padding(.horizontal, 8)
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(.systemGray))
                    .padding(8)
            }
            .frame(height: 40)
            .padding(.horizontal)
        }
    }
}


//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView()
//    }
//}
