//
//  ProductView.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 04/07/2023.
//

import SwiftUI
struct ProductView: View {
    @ObservedObject var viewModel: ProductsViewModel
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
            Image(systemName: viewModel.isFavorite(productId: product.id ?? 0) ? "heart.fill" : "heart")
                .foregroundColor(viewModel.isFavorite(productId: product.id ?? 0) ? .red : .gray)
                .onTapGesture {
                    viewModel.toggleFavorite(productId: product.id ?? 0)
                }
        }
    }
}

//struct ProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductView()
//    }
//}
