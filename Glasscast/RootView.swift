//
//  RootView.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import SwiftUI

//struct RootView: View {
//    @State private var selectedTab = 0
//    @State private var isAuthenticated = false
//    @State private var isCheckingAuth = true
//    
//    var body: some View {
//        Group {
//            if isCheckingAuth {
//                ZStack {
//                    LinearGradient(
//                        colors: [.blue.opacity(0.6), .purple.opacity(0.4)],
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
//                    .ignoresSafeArea()
//                    
//                    VStack(spacing: 20) {
//                        Image(systemName: "cloud.sun.fill")
//                            .font(.system(size: 60))
//                            .foregroundColor(.white)
//                        
//                        ProgressView()
//                            .tint(.white)
//                            .scaleEffect(1.5)
//                    }
//                }
//            } else if isAuthenticated {
//                mainTabView
//            } else {
//                AuthView()
//            }
//        }
//        .task {
//            SupabaseManager.shared.startAuthListener { loggedIn in
//                withAnimation {
//                    isAuthenticated = loggedIn
//                    isCheckingAuth = false
//                    if loggedIn {
//                        selectedTab = 0
//                    }
//                }
//            }
//
//            await checkAuthentication()
//        }
//        .onReceive(NotificationCenter.default.publisher(for: .userSignedOut)) { _ in
//            withAnimation {
//                isAuthenticated = false
//            }
//        }
//    }
//    
//    private var mainTabView: some View {
//        TabView(selection: $selectedTab) {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                }
//                .tag(0)
//            
//            SearchView()
//                .tabItem {
//                    Label("Search", systemImage: "magnifyingglass")
//                }
//                .tag(1)
//            
//            SettingsView()
//                .tabItem {
//                    Label("Settings", systemImage: "gear")
//                }
//                .tag(2)
//        }
//        .onAppear {
//            setupTabBarAppearance()
//        }
//    }
//    
//    private func checkAuthentication() async {
//        isCheckingAuth = true
//        
//        let hasSession = await SupabaseManager.shared.checkSession()
//        
//        withAnimation {
//            isAuthenticated = hasSession
//            isCheckingAuth = false
//        }
//    }
//
//    private func setupTabBarAppearance() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithTransparentBackground()
//        
//        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
//        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.1)
//        
//        let itemAppearance = UITabBarItemAppearance()
//        itemAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.6)
//        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
//        
//        itemAppearance.selected.iconColor = UIColor.systemBlue
//        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
//        
//        appearance.stackedLayoutAppearance = itemAppearance
//        appearance.inlineLayoutAppearance = itemAppearance
//        appearance.compactInlineLayoutAppearance = itemAppearance
//        
//        UITabBar.appearance().standardAppearance = appearance
//        if #available(iOS 15.0, *) {
//            UITabBar.appearance().scrollEdgeAppearance = appearance
//        }
//    }
//}

//extension Notification.Name {
//    static let userSignedOut = Notification.Name("userSignedOut")
////    static let userSignedIn = Notification.Name("userSignedIn")
//}

import SwiftUI

struct RootView: View {
    @State private var selectedTab = 0
    @State private var isAuthenticated = false
    @State private var isCheckingAuth = true
    
    var body: some View {
        Group {
            if isCheckingAuth {
                ZStack {
                    LinearGradient(
                        colors: [.blue.opacity(0.6), .purple.opacity(0.4)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Image(systemName: "cloud.sun.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(1.5)
                        
                        Text("Checking authentication...")
                            .foregroundColor(.white)
                    }
                }
            } else if isAuthenticated {
                mainTabView
            } else {
                AuthView()
                    .onAppear {
                        print("🔐 Showing Auth screen - no session found")
                    }
            }
        }
        .task {
            await checkAuthentication()
        }
        .onReceive(NotificationCenter.default.publisher(for: .userSignedOut)) { _ in
            print("🚪 User signed out - showing auth screen")
            withAnimation {
                isAuthenticated = false
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .userSignedIn)) { _ in
            print("✅ User signed in - showing home screen")
            Task {
                SupabaseManager.shared.startAuthListener { loggedIn in
                    withAnimation {
                        isAuthenticated = loggedIn
                        isCheckingAuth = false
                        if loggedIn {
                            selectedTab = 0
                        }
                    }
                }

                await checkAuthentication()
            }
        }
    }
    
    private var mainTabView: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
        .onAppear {
            setupTabBarAppearance()
        }
    }
    
    private func checkAuthentication() async {
        print("🔍 Checking authentication status...")
        isCheckingAuth = true
        
        let hasSession = await SupabaseManager.shared.checkSession()
        
        print("📊 Session check result: \(hasSession)")
        
        withAnimation {
            isAuthenticated = hasSession
            isCheckingAuth = false
        }
        
        if hasSession {
            print("✅ User is authenticated - showing home")
        } else {
            print("❌ User not authenticated - showing auth screen")
        }
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.1)
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.6)
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        
        itemAppearance.selected.iconColor = UIColor.systemBlue
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

extension Notification.Name {
    static let userSignedOut = Notification.Name("userSignedOut")
    static let userSignedIn = Notification.Name("userSignedIn")
}



#Preview {
    RootView()
}
