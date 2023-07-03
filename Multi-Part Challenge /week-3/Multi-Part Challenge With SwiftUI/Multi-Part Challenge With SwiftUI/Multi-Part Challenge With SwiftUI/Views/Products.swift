//
//  ShowProducts.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import SwiftUI

struct Products: View {
    @StateObject var productsViewModel = ProductsViewModel.shared
    @State var categorie: String
   
    var body: some View {
        List(productsViewModel.products, id: \.self) { product in
            VStack {
                ProductView(product: product)
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


struct ProductView: View {
    let product: Product
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: product.thumbnail) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(product.title ?? "")
                    .font(.headline)
                Text(product.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("\(product.price ?? 0)$")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
    }
}
//struct ShowProducts_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowProducts()
//    }
//}
