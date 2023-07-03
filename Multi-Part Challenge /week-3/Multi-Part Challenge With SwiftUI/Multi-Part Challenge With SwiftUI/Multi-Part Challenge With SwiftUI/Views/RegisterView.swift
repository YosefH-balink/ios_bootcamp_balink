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
    @State private var valid = false
    @State var login = false
    @State var showAlert = false
    @State var alertMessage = ""
    @State var showProgressView = false
    
    func isValid (){
        if !registerViewModel.isValidUsername(input: registerViewModel.userName) {
            alertMessage = "Invalid email format"
            showAlert = true
            return        }
        if !registerViewModel.isValidPassword(input: registerViewModel.password) {
            alertMessage = "Password must contains at least one lowercase ,uppercase ,digit, and special character (@, #, $, %, ^, &, +, =)"
            showAlert = true
            return
        }
        else  {
            showProgressView = true
            registerViewModel.fetchAccessToken()
            valid = true
        }
    }
    
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
//                if showProgressView {
//                    ProgressView().progressViewStyle(CircularProgressViewStyle())
//                }
                Button("Register") {
                    isValid()
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            NavigationLink(destination: LoginView(),isActive: $login) { EmptyView() }
            NavigationLink(destination:  CategoriesView(),isActive: $valid) { EmptyView() }
        }.navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
