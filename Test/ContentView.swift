//
//  ContentView.swift
//  Test
//
//  Created by karwan Syborg on 30/05/2025.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    let text: Binding<String>
    let isSecure: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if !text.wrappedValue.isEmpty {
                Text(title)
                    .foregroundColor(.gray)
                    .font(.caption)
                    .transition(.move(edge: .bottom))
            }
            
            if isSecure {
                SecureField(text.wrappedValue.isEmpty ? title : "", text: text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                TextField(text.wrappedValue.isEmpty ? title : "", text: text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .animation(.easeInOut(duration: 0.2), value: text.wrappedValue)
    }
}

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            // Content
            VStack(spacing: 25) {
                // Logo
                Image(systemName: "lock.shield")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(spacing: 20) {
                    FloatingTextField(title: "Email", text: $email, isSecure: false)
                    FloatingTextField(title: "Password", text: $password, isSecure: true)
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.9))
                )
                .padding(.horizontal)
                
                Button(action: {
                    withAnimation {
                        isLoading = true
                    }
                    // Add login logic here
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.blue)
                            .frame(height: 50)
                        
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Sign In")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    Button("Forgot Password?") {
                        // Add forgot password logic
                    }
                    .foregroundColor(.white)
                    
                    Text("|")
                        .foregroundColor(.white)
                    
                    Button("Sign Up") {
                        // Add sign up logic
                    }
                    .foregroundColor(.white)
                }
                .font(.subheadline)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

