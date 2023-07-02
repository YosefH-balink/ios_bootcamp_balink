//
//  CategoriesView.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var categoriesViewModel = CategoriesViewModel()
    
    var body: some View {
        List(categoriesViewModel.getCategories(), id: \.self) { category in
            NavigationLink(destination: ShowProducts(categorie: category)) {
                HStack {
                    Text(category)
                        .font(.headline)
                    Spacer()
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
    }
}



struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
