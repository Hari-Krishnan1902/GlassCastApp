//
//  SupabaseManager.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import Foundation
import Supabase

//class SupabaseManager {
//    static let shared = SupabaseManager()
//    
//    let client: SupabaseClient
//    
//    private init() {
//        client = SupabaseClient(
//            supabaseURL: URL(string: "https://cawqgisdivrljdonhdmu.supabase.co")!,
//            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNhd3FnaXNkaXZybGpkb25oZG11Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg5MDU1OTIsImV4cCI6MjA4NDQ4MTU5Mn0.JMQG6X6X1lA90XcQwEarA6fGn1mPViBBTFQdhU4VOAE"
//        )
//    }
//    
//    // MARK: - Auth Methods
//    
//    var currentUser: User? {
//        try? client.auth.session.user
//    }
//    
//    var isAuthenticated: Bool {
//        currentUser != nil
//    }
//    
//    func signUp(email: String, password: String) async throws {
//        try await client.auth.signUp(email: email, password: password)
//    }
//    
//    func signIn(email: String, password: String) async throws {
//        try await client.auth.signIn(email: email, password: password)
//    }
//    
//    func signOut() async throws {
//        try await client.auth.signOut()
//    }
//    
//    func resetPassword(email: String) async throws {
//        try await client.auth.resetPasswordForEmail(email)
//    }
//    
//    // MARK: - Session Management
//    
//    func checkSession() async -> Bool {
//        do {
//            _ = try await client.auth.session
//            return true
//        } catch {
//            return false
//        }
//    }
//}



//class SupabaseManager {
//    static let shared = SupabaseManager()
//    
//    let client: SupabaseClient
//    
//    private init() {
//        client = SupabaseClient(
//            supabaseURL: URL(string: "https://cawqgisdivrljdonhdmu.supabase.co")!,
//            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNhd3FnaXNkaXZybGpkb25oZG11Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg5MDU1OTIsImV4cCI6MjA4NDQ4MTU5Mn0.JMQG6X6X1lA90XcQwEarA6fGn1mPViBBTFQdhU4VOAE"
//        )
//    }
//    
//    // MARK: - Auth Methods
//    
//    func getCurrentUser() async -> User? {
//        do {
//            let session = try await client.auth.session
//            return session.user
//        } catch {
//            return nil
//        }
//    }
//    
//    func isAuthenticated() async -> Bool {
//        await getCurrentUser() != nil
//    }
//    
//    func signUp(email: String, password: String) async throws {
//        try await client.auth.signUp(email: email, password: password)
//
//    }
//    
//    func signIn(email: String, password: String) async throws {
//        try await client.auth.signIn(email: email, password: password)
//    }
//    
//    func signOut() async throws {
//        try await client.auth.signOut()
//    }
//    
//    func resetPassword(email: String) async throws {
//        try await client.auth.resetPasswordForEmail(email)
//    }
//    
//    // MARK: - Session Management
//    
//    func checkSession() async -> Bool {
//        do {
//            _ = try await client.auth.session
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//    func getUserId() async -> UUID? {
//        await getCurrentUser()?.id
//    }
//    
//    @MainActor
//    func startAuthListener(onChange: @escaping (Bool) -> Void) {
//        Task {
//            for await state in client.auth.authStateChanges {
//                print("🔐 AUTH EVENT:", state.event)
//
//                switch state.event {
//                case .initialSession, .signedIn, .tokenRefreshed:
//                    onChange(true)
//
//                case .signedOut:
//                    onChange(false)
//
//                default:
//                    break
//                }
//            }
//        }
//    }
//
//
//}

import Foundation
import Supabase

//class SupabaseManager {
//    static let shared = SupabaseManager()
//    
//    let client: SupabaseClient
//    
//    private init() {
//        client = SupabaseClient(
//            supabaseURL: URL(string: "https://cawqgisdivrljdonhdmu.supabase.co")!,
//            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNhd3FnaXNkaXZybGpkb25oZG11Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg5MDU1OTIsImV4cCI6MjA4NDQ4MTU5Mn0.JMQG6X6X1lA90XcQwEarA6fGn1mPViBBTFQdhU4VOAE"
//        )
//    }
//    
//    // MARK: - Auth Methods
//    
//    func getCurrentUser() async -> User? {
//        do {
//            let session = try await client.auth.session
//            return session.user
//        } catch {
//            return nil
//        }
//    }
//    
//    func isAuthenticated() async -> Bool {
//        await getCurrentUser() != nil
//    }
//    
//    func signUp(email: String, password: String) async throws {
//        try await client.auth.signUp(email: email, password: password)
//    }
//    
//    func signIn(email: String, password: String) async throws {
//        try await client.auth.signIn(email: email, password: password)
//    }
//    
//    func signOut() async throws {
//        try await client.auth.signOut()
//    }
//    
//    func resetPassword(email: String) async throws {
//        try await client.auth.resetPasswordForEmail(email)
//    }
//    
//    // MARK: - Session Management
//    
//    func checkSession() async -> Bool {
//        do {
//            _ = try await client.auth.session
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//    func getUserId() async -> UUID? {
//        await getCurrentUser()?.id
//    }
//    
//    // MARK: - Favorites Methods
//    
//    func addFavorite(cityName: String, lat: Double, lon: Double) async throws {
//        guard let userId = await getUserId() else {
//            throw AppError.customMessage("User not authenticated")
//        }
//        
//        let favorite = FavoriteInsert(
//            userId: userId,
//            cityName: cityName,
//            lat: lat,
//            lon: lon
//        )
//        
//        try await client.database
//            .from("favorites")
//            .insert(favorite)
//            .execute()
//    }
//    
//    func removeFavorite(cityName: String) async throws {
//        guard let userId = await getUserId() else {
//            throw AppError.customMessage("User not authenticated")
//        }
//        
//        try await client.database
//            .from("favorites")
//            .delete()
//            .eq("user_id", value: userId)
//            .eq("city_name", value: cityName)
//            .execute()
//    }
//    
//    func fetchFavorites() async throws -> [Favorite] {
//        guard let userId = await getUserId() else {
//            throw AppError.customMessage("User not authenticated")
//        }
//        
//        let response = try await client.database
//            .from("favorites")
//            .select()
//            .eq("user_id", value: userId)
//            .order("created_at", ascending: false)
//            .execute()
//        
//        let favorites: [Favorite] = try JSONDecoder().decode(
//            [Favorite].self,
//            from: response.data
//        )
//        
//        return favorites
//    }
//    
//    func isFavorite(cityName: String) async throws -> Bool {
//        guard let userId = await getUserId() else {
//            return false
//        }
//        
//        let response = try await client.database
//            .from("favorites")
//            .select()
//            .eq("user_id", value: userId)
//            .eq("city_name", value: cityName)
//            .execute()
//        
//        let favorites: [Favorite] = try JSONDecoder().decode(
//            [Favorite].self,
//            from: response.data
//        )
//        
//        return !favorites.isEmpty
//    }
//        @MainActor
//        func startAuthListener(onChange: @escaping (Bool) -> Void) {
//            Task {
//                for await state in client.auth.authStateChanges {
//                    print("🔐 AUTH EVENT:", state.event)
//    
//                    switch state.event {
//                    case .initialSession, .signedIn, .tokenRefreshed:
//                        onChange(true)
//    
//                    case .signedOut:
//                        onChange(false)
//    
//                    default:
//                        break
//                    }
//                }
//            }
//        }
//}

import Foundation
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    private init() {
        client = SupabaseClient(
            supabaseURL: URL(string: "https://cawqgisdivrljdonhdmu.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNhd3FnaXNkaXZybGpkb25oZG11Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg5MDU1OTIsImV4cCI6MjA4NDQ4MTU5Mn0.JMQG6X6X1lA90XcQwEarA6fGn1mPViBBTFQdhU4VOAE"
        )
        
        // Session will be automatically persisted by Supabase SDK
        print("🔧 Supabase client initialized")
    }
    
    // MARK: - Auth Methods
    
    func getCurrentUser() async -> User? {
        do {
            let session = try await client.auth.session
            return session.user
        } catch {
            // Silent fail - no session is normal when not logged in
            return nil
        }
    }
    
    func isAuthenticated() async -> Bool {
        do {
            _ = try await client.auth.session
            return true
        } catch {
            return false
        }
    }
    
    func signUp(email: String, password: String) async throws {
        let response = try await client.auth.signUp(email: email, password: password)
        print("✅ Sign up successful for: \(email)")
        print("📧 Check email for verification")
    }
    
    func signIn(email: String, password: String) async throws {
        let response = try await client.auth.signIn(email: email, password: password)
        print("✅ Sign in successful")
        print("💾 Session saved automatically")
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
        print("🚪 Signed out successfully")
    }
    
    func resetPassword(email: String) async throws {
        try await client.auth.resetPasswordForEmail(email)
        print("📧 Password reset email sent to: \(email)")
    }
    
    // MARK: - Session Management
    
    func checkSession() async -> Bool {
        do {
            let session = try await client.auth.session
            print("✅ Session found for: \(session.user.email ?? "unknown")")
            return true
        } catch {
            print("ℹ️ No active session - user needs to sign in")
            return false
        }
    }
    
    func getUserId() async -> UUID? {
        do {
            let session = try await client.auth.session
            return session.user.id
        } catch {
            // Silent fail - user not logged in
            return nil
        }
    }
    
    // MARK: - Favorites Methods
    
    func addFavorite(cityName: String, lat: Double, lon: Double) async throws {
        guard let userId = await getUserId() else {
            print("❌ No user ID - not authenticated")
            throw AppError.customMessage("User not authenticated. Please sign in again.")
        }
        
        print("➕ Adding favorite: \(cityName) for user: \(userId)")
        
        let favorite = FavoriteInsert(
            userId: userId,
            cityName: cityName,
            lat: lat,
            lon: lon
        )
        
        try await client.database
            .from("favorites")
            .insert(favorite)
            .execute()
        
        print("✅ Favorite added successfully")
    }
    
    func removeFavorite(cityName: String) async throws {
        guard let userId = await getUserId() else {
            print("❌ No user ID - not authenticated")
            throw AppError.customMessage("User not authenticated. Please sign in again.")
        }
        
        print("🗑 Removing favorite: \(cityName) for user: \(userId)")
        
        try await client.database
            .from("favorites")
            .delete()
            .eq("user_id", value: userId.uuidString)
            .eq("city_name", value: cityName)
            .execute()
        
        print("✅ Favorite removed successfully")
    }
    
    func fetchFavorites() async throws -> [Favorite] {
        guard let userId = await getUserId() else {
            print("❌ No user ID - not authenticated")
            throw AppError.customMessage("User not authenticated. Please sign in again.")
        }
        
        print("📥 Fetching favorites for user: \(userId)")
        
        let favorites: [Favorite] = try await client.database
            .from("favorites")
            .select()
            .eq("user_id", value: userId.uuidString)
            .order("created_at", ascending: false)
            .execute()
            .value
        
        print("✅ Fetched \(favorites.count) favorites")
        return favorites
    }
    
    func isFavorite(cityName: String) async throws -> Bool {
        guard let userId = await getUserId() else {
            return false
        }
        
        print("🔍 Checking if '\(cityName)' is favorite")
        
        let favorites: [Favorite] = try await client.database
            .from("favorites")
            .select()
            .eq("user_id", value: userId.uuidString)
            .eq("city_name", value: cityName)
            .execute()
            .value
        
        let result = !favorites.isEmpty
        print(result ? "⭐️ Is favorite" : "☆ Not favorite")
        return result
    }
            @MainActor
            func startAuthListener(onChange: @escaping (Bool) -> Void) {
                Task {
                    for await state in client.auth.authStateChanges {
                        print("🔐 AUTH EVENT:", state.event)
    
                        switch state.event {
                        case .initialSession, .signedIn, .tokenRefreshed:
                            onChange(true)
    
                        case .signedOut:
                            onChange(false)
    
                        default:
                            break
                        }
                    }
                }
            }
}
