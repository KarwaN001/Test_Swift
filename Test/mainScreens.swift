
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Home")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
    }
}

struct ExploreView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Explore")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
    }
}

struct MainScreens: View {
    @State private var selectedTab = 0
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Home")
                }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "safari.fill" : "safari")
                    Text("Explore")
                }
                .tag(1)
            
            ProfileScreen()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                    Text("Profile")
                }
                .tag(2)
        }
        .accentColor(Color(red: 0.6, green: 0.4, blue: 0.8)) // Matching the login screen's theme
        .onAppear {
            // Customize the tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

struct MainScreens_Previews: PreviewProvider {
    static var previews: some View {
        MainScreens()
    }
}
