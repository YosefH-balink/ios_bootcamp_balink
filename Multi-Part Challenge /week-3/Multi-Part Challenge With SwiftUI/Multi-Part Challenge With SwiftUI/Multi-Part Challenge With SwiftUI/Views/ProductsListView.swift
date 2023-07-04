//
//  ShowProducts.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import SwiftUI

struct ProductsListView: View {
    @StateObject var productsViewModel = ProductsViewModel()
    @State var categorie: String
   
    var body: some View {
        List(productsViewModel.products, id: \.self) { product in
            VStack {
                SingelProductView(viewModel: productsViewModel, product: product)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Products")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            productsViewModel.fetchProducts(categorie: self.categorie)
        }
    }
}

//struct ShowProducts_Previews: PreviewProvider {
//    static var previews: some View {
//        Products()
//    }
//}
