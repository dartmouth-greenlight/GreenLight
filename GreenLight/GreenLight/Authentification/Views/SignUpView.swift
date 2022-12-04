//
//  SignUpView.swift
//  GreenLight
//
//  Created by Jack Desmond on 11/13/22.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Create your accout!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(.systemGreen))
            
            VStack(spacing: 40) {
                CustomTextField(imageName: "envelope",placeholderText: "Email", text: $email)
                CustomTextField(imageName: "person",placeholderText: "Username", text: $username)
                CustomTextField(imageName: "person",placeholderText: "Full Name", text: $fullname)
                CustomTextField(imageName: "lock",placeholderText: "Password", isSecureField: true, text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            Button {
                viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemGreen))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10)
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color(.systemGreen))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
