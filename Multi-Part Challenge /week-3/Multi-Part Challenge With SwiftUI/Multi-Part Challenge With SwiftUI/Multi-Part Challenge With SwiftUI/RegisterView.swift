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
    @State var showAlert = false
    @State var alertMessage = ""
    
    func isValid (){
        if !registerViewModel.isValidUsername(input: registerViewModel.userName) {
            alertMessage = "Invalid email format"
            showAlert = true
            return
        }
        if !registerViewModel.isValidPassword(input: registerViewModel.password) {
            alertMessage = "Password must contains at least one lowercase ,uppercase ,digit, and special character (@, #, $, %, ^, &, +, =)"
            showAlert = true
            return
        }
        else  {
            registerViewModel.fetchAccessToken()
            valid = true
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
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
                    isValid()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.top, 20)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Title"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
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
