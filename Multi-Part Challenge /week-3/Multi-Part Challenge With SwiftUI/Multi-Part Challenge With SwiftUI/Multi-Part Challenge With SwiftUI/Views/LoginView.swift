//
//  LoginView.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import SwiftUI
import Combine

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.title)
                    .foregroundColor(.black.opacity(0.8))
                    .padding()
                 TextField("User Name (Email)", text: $loginViewModel.userName)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .multilineTextAlignment(.center)
                     .font(.headline)
                 SecureField("Password", text: $loginViewModel.password)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .multilineTextAlignment(.center)
                     .font(.headline)
                Button("Login") {
                    loginViewModel.isValid()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .padding(.horizontal, 40)
                .background(Color.cyan)
                .cornerRadius(10)
                .padding(.top, 20)
            }
            .alert(isPresented: $loginViewModel.failure) {
                Alert(
                    title: Text("Error"),
                    message: Text(loginViewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            NavigationLink(destination: TabBarView(),isActive: $loginViewModel.serverCompletion) { EmptyView() }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
