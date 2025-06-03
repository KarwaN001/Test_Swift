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
    @State private var isFocused: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                if isSecure {
                    SecureField(title, text: text)
                        .textFieldStyle(.plain)
                        .onChange(of: text.wrappedValue) { _ in
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isFocused = true
                            }
                        }
                } else {
                    TextField(title, text: text)
                        .textFieldStyle(.plain)
                        .onChange(of: text.wrappedValue) { _ in
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isFocused = true
                            }
                        }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isFocused ? Color.white.opacity(0.5) : Color.clear, lineWidth: 1)
                    )
            )
            .foregroundColor(.white)
        }
    }
}

struct SocialLoginButton: View {
    let imageName: String
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
            action()
        }) {
            Image(systemName: imageName)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.15))
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                )
                .scaleEffect(isPressed ? 0.9 : 1)
        }
    }
}

struct GradientButton: View {
    let title: String
    let action: () -> Void
    let isLoading: Bool
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white, Color.white.opacity(0.9)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .frame(height: 54)
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 0.6, green: 0.4, blue: 0.8)))
                } else {
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 0.6, green: 0.4, blue: 0.8))
                }
            }
            .scaleEffect(isPressed ? 0.98 : 1)
        }
    }
}

enum Route: Hashable {
    case signup
}

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var rememberMe = false
    @State private var appearAnimation = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [
                    Color(red: 0.6, green: 0.4, blue: 0.8),
                    Color(red: 0.8, green: 0.3, blue: 0.7)
                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                // Content
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("Log In")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .offset(x: appearAnimation ? 0 : -20)
                        .opacity(appearAnimation ? 1 : 0)
                    
                    VStack(spacing: 16) {
                        FloatingTextField(title: "login/e-mail", text: $email, isSecure: false)
                            .offset(y: appearAnimation ? 0 : 20)
                            .opacity(appearAnimation ? 1 : 0)
                        
                        FloatingTextField(title: "password", text: $password, isSecure: true)
                            .offset(y: appearAnimation ? 0 : 20)
                            .opacity(appearAnimation ? 1 : 0)
                        
                        HStack {
                            Toggle("Remember me", isOn: $rememberMe)
                                .foregroundColor(.white)
                                .font(.subheadline)
                            Spacer()
                        }
                        .offset(y: appearAnimation ? 0 : 20)
                        .opacity(appearAnimation ? 1 : 0)
                    }
                    .padding(.horizontal)
                    
                    GradientButton(title: "Log In", action: {
                        withAnimation {
                            isLoading = true
                        }
                    }, isLoading: isLoading)
                    .padding(.horizontal)
                    .offset(y: appearAnimation ? 0 : 20)
                    .opacity(appearAnimation ? 1 : 0)
                    
                    Button("Forgot your password?") {
                        // Add forgot password logic
                    }
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .offset(y: appearAnimation ? 0 : 20)
                    .opacity(appearAnimation ? 1 : 0)
                    
                    VStack(spacing: 20) {
                        Text("Log in with social account")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.subheadline)
                        
                        HStack(spacing: 20) {
                            SocialLoginButton(imageName: "g.circle.fill") {
                                // Google login
                            }
                            
                            SocialLoginButton(imageName: "apple.logo") {
                                // Apple login
                            }
                            
                            SocialLoginButton(imageName: "message.fill") {
                                // Message login
                            }
                        }
                    }
                    .offset(y: appearAnimation ? 0 : 20)
                    .opacity(appearAnimation ? 1 : 0)
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.white.opacity(0.8))
                        
                        NavigationLink(value: Route.signup) {
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    .font(.subheadline)
                    .padding(.top)
                    .offset(y: appearAnimation ? 0 : 20)
                    .opacity(appearAnimation ? 1 : 0)
                    
                    Spacer()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .signup:
                    SignUpView(navigationPath: $navigationPath)
                        .navigationBarBackButtonHidden()
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                appearAnimation = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

