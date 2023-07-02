//
//  ShowProducts.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import SwiftUI

struct ShowProducts: View {
    var categorie: String
    var body: some View {
        Text(categorie)
//        NavigationView {
//            List(products) { product in
//                Text(product.title ?? "")
//
//            } .navigationTitle("Products")
//                .navigationBarTitleDisplayMode(.inline)
//                .padding()
//        }
    }
}

//struct ShowProducts_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowProducts()
//    }
//}
