//
//  ProductView.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 04/07/2023.
//
import SwiftUI

struct SingelProductView: View {
    @ObservedObject var viewModel: ProductsListViewModel
    let product: Product
    let productsListType: ProductsListType
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: product.thumbnail) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame( height: 120)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            } placeholder: {
                ProgressView()
                    .frame( height: 120)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(product.title ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                Text(product.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(5)
            }
            VStack() {
                Image(systemName: viewModel.isFavorite(productId: product.id ?? 0) ? "star.fill" : "star")
                    .foregroundColor(viewModel.isFavorite(productId: product.id ?? 0) ? .yellow : .gray)
                    .onTapGesture {
                        viewModel.toggleFavorite(productId: product.id ?? 0)
                        if productsListType == .favorites {
                            if let index = viewModel.filteredProducts.firstIndex(of: product) {
                                withAnimation {
                                    viewModel.filteredProducts.remove(at: index)
                                }
                            }
                        }
                    }
                    .font(.title)
                    .padding(.top)
                Spacer()
                Text("\(product.price ?? 0)$")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(5)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

//struct ProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductView()
//    }
//}
