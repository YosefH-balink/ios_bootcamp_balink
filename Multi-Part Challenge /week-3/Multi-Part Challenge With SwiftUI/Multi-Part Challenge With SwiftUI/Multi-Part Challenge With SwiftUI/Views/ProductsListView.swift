//
//  ShowProducts.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import SwiftUI

struct ProductsListView: View {
    @StateObject var productsViewModel = ProductsViewModel()
    @State var category: String?
    @State var products: ProductsList
    var body: some View {
        VStack{
            if category == "all"  {
                SearchBarView(searchText: $productsViewModel.searchText)
            }
            List(productsViewModel.filteredProducts, id: \.self) { product in
                VStack {
                    SingelProductView(viewModel: productsViewModel, product: product)
                }
            }
        }
        .onAppear {
            switch products {
            case .all:
                productsViewModel.fetchProducts(products: .all, category: nil)
            case .favorites:
                productsViewModel.fetchProducts(products: .favorites, category: nil)
            case .category:
                productsViewModel.fetchProducts(products: .category, category: self.category)
            }
        }
    }

}

//struct ShowProducts_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductsListView()
//    }
//}
