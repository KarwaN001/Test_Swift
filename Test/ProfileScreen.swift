

import SwiftUI

struct StatsCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
    }
}

struct ProfileActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(Color(red: 0.6, green: 0.4, blue: 0.8))
                    .frame(width: 32)
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
        }
    }
}

struct ProfileScreen: View {
    @State private var isEditing = false
    @State private var showingLogoutAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    // Add this to handle navigation back to login
    @State private var shouldNavigateToLogin = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    VStack(spacing: 16) {
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color(red: 0.6, green: 0.4, blue: 0.8))
                            
                            Button(action: {
                                // Add photo action
                            }) {
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color(red: 0.6, green: 0.4, blue: 0.8))
                                    .clipShape(Circle())
                            }
                            .offset(x: 5, y: 5)
                        }
                        
                        VStack(spacing: 4) {
                            Text("John Doe")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("john.doe@example.com")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 20)
                    
                    // Stats Section
                    HStack(spacing: 12) {
                        StatsCard(title: "Posts", value: "156")
                        StatsCard(title: "Followers", value: "1.2K")
                        StatsCard(title: "Following", value: "845")
                    }
                    .padding(.horizontal)
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        ProfileActionButton(icon: "person.fill", title: "Edit Profile") {
                            isEditing = true
                        }
                        
                        ProfileActionButton(icon: "bell.fill", title: "Notifications") {
                            // Handle notifications
                        }
                        
                        ProfileActionButton(icon: "lock.fill", title: "Privacy") {
                            // Handle privacy
                        }
                        
                        ProfileActionButton(icon: "gear", title: "Settings") {
                            // Handle settings
                        }
                        
                        ProfileActionButton(icon: "questionmark.circle", title: "Help & Support") {
                            // Handle help
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        Text("Log Out")
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $isEditing) {
            NavigationView {
                Text("Edit Profile View")
                    .navigationTitle("Edit Profile")
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            isEditing = false
                        },
                        trailing: Button("Save") {
                            isEditing = false
                        }
                    )
            }
        }
        .alert(isPresented: $showingLogoutAlert) {
            Alert(
                title: Text("Log Out"),
                message: Text("Are you sure you want to log out?"),
                primaryButton: .destructive(Text("Log Out")) {
                    // Clear any user data here
                    UserDefaults.standard.removeObject(forKey: "userSession")
                    
                    // Navigate back to login screen
                    NotificationCenter.default.post(name: NSNotification.Name("LogoutUser"), object: nil)
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
