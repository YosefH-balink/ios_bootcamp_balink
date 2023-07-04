//
//  ContentView.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 29/06/2023.
//

import SwiftUI
import Combine

struct RegisterView: View {
    @StateObject private var registerViewModel = RegisterViewModel()
    @State var login = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create an acount")
                    .font(.title)
                    .foregroundColor(.black.opacity(0.8))
                    .padding()
                TextField("First Name", text: $registerViewModel.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .font(.headline)
                TextField("Last Name", text: $registerViewModel.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .font(.headline)
                TextField("User Name (Email)", text: $registerViewModel.userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .font(.headline)
                SecureField("Password", text: $registerViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .font(.headline)
                
                Button("Register") {
                    self.registerViewModel.isValid()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .padding(.horizontal, 40)
                .background(Color.cyan)
                .cornerRadius(10)
                .padding(.top, 20)
            }
            HStack{
                Text("Already have an account ?")
                Button("Login") {
                    login = true
                }
            }
            .padding()
            .alert(isPresented: $registerViewModel.failure) {
                Alert(
                    title: Text("Error"),
                    message: Text(registerViewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .padding(.top, 5)
            NavigationLink(destination: LoginView(),isActive: $login) { EmptyView() }
            NavigationLink(destination:  TabBarView(),isActive: $registerViewModel.serverCompletion) { EmptyView() }
        }.navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
