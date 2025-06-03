import SwiftUI

struct SignUpView: View {
    @Binding var navigationPath: NavigationPath
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isLoading = false
    @State private var appearAnimation = false
    @State private var agreedToTerms = false
    
    init(navigationPath: Binding<NavigationPath>) {
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.6, green: 0.4, blue: 0.8),
                Color(red: 0.8, green: 0.3, blue: 0.7)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            // Content
            ScrollView {
                VStack(spacing: 30) {
                    // Back button and title
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                navigationPath.removeLast()
                            }
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Text("Create Account")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .offset(x: appearAnimation ? 0 : -20)
                        .opacity(appearAnimation ? 1 : 0)
                    
                    VStack(spacing: 16) {
                        FloatingTextField(title: "Full Name", text: $fullName, isSecure: false)
                            .offset(y: appearAnimation ? 0 : 20)
                            .opacity(appearAnimation ? 1 : 0)
                        
                        FloatingTextField(title: "Email", text: $email, isSecure: false)
                            .offset(y: appearAnimation ? 0 : 20)
                            .opacity(appearAnimation ? 1 : 0)
                        
                        FloatingTextField(title: "Password", text: $password, isSecure: true)
                            .offset(y: appearAnimation ? 0 : 20)
                            .opacity(appearAnimation ? 1 : 0)
                        
                        FloatingTextField(title: "Confirm Password", text: $confirmPassword, isSecure: true)
                            .offset(y: appearAnimation ? 0 : 20)
                            .opacity(appearAnimation ? 1 : 0)
                        
                        Toggle("I agree to the Terms and Privacy Policy", isOn: $agreedToTerms)
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .padding(.top, 8)
                            .offset(y: appearAnimation ? 0 : 20)
                            .opacity(appearAnimation ? 1 : 0)
                    }
                    .padding(.horizontal)
                    
                    GradientButton(title: "Sign Up", action: {
                        withAnimation {
                            isLoading = true
                        }
                        // Add sign up logic
                    }, isLoading: isLoading)
                    .padding(.horizontal)
                    .offset(y: appearAnimation ? 0 : 20)
                    .opacity(appearAnimation ? 1 : 0)
                    
                    VStack(spacing: 20) {
                        Text("Or sign up with")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.subheadline)
                        
                        HStack(spacing: 20) {
                            SocialLoginButton(imageName: "g.circle.fill") {
                                // Google sign up
                            }
                            
                            SocialLoginButton(imageName: "apple.logo") {
                                // Apple sign up
                            }
                            
                            SocialLoginButton(imageName: "message.fill") {
                                // Message sign up
                            }
                        }
                    }
                    .offset(y: appearAnimation ? 0 : 20)
                    .opacity(appearAnimation ? 1 : 0)
                    
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.white.opacity(0.8))
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                navigationPath.removeLast()
                            }
                        }) {
                            Text("Log In")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    .font(.subheadline)
                    .padding(.top)
                    .offset(y: appearAnimation ? 0 : 20)
                    .opacity(appearAnimation ? 1 : 0)
                }
                .padding(.vertical, 20)
            }
        }
        .transition(.asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        ))
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                appearAnimation = true
            }
        }
    }
} 
