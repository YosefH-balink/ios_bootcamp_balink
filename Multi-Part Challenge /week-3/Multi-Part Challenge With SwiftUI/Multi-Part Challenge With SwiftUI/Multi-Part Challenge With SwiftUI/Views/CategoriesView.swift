//
//  CategoriesView.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var categoriesViewModel = CategoriesViewModel.shared
    var body: some View {
        List(categoriesViewModel.categories, id: \.self) { category in
            NavigationLink(destination: ProductsListView(category: category, products: .category)) {
                HStack {
                    Text(category.capitalized)
                        .font(.headline)
                    Spacer()
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}