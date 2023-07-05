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
        VStack{
            if categorie == "all"  {
                SearchBarView(searchText: $productsViewModel.searchText)
            }
            List(productsViewModel.filteredProducts, id: \.self) { product in
                VStack {
                    SingelProductView(viewModel: productsViewModel, product: product)
                }
            }
        }
        .onAppear {
            if categorie == "favorites" {
                productsViewModel.fetchFavoritesProducts()
            } else if categorie == "all" {
                productsViewModel.fetchAllProducts()
            } else {
                productsViewModel.fetchProducts(categorie: self.categorie)
            }
        }
    }

}

//struct ShowProducts_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductsListView()
//    }
//}
