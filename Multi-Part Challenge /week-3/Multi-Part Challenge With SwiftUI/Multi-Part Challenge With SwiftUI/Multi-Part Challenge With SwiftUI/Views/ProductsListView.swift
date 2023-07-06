//
//  ShowProducts.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import SwiftUI

struct ProductsListView: View {
    @StateObject var productsViewModel = ProductsListViewModel()
    @State var category: String?
    @State var productsListType: ProductsListType
    var body: some View {
        VStack{
            if productsListType == .all  {
                SearchBarView(searchText: $productsViewModel.searchText)
            }
            List(productsViewModel.filteredProducts, id: \.self) { product in
                VStack {
                    SingelProductView(viewModel: productsViewModel, product: product, productsListType: self.productsListType)
                }
            }
        }
        .onAppear {
            switch productsListType {
            case .all:
                productsViewModel.getProducts(products: .all, category: nil)
            case .favorites:
                productsViewModel.getProducts(products: .favorites, category: nil)
            case .category:
                productsViewModel.getProducts(products: .category, category: self.category)
            }
        }
    }

}

//struct ShowProducts_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductsListView()
//    }
//}
