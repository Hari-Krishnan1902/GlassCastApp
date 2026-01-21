//
//  AuthViewModel.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import Foundation
import Combine

//@MainActor
//class AuthViewModel: ObservableObject {
//    @Published var email = ""
//    @Published var password = ""
//    @Published var isLoading = false
//    @Published var error: AppError?
//    @Published var showForgotPassword = false
//    
//    private let supabase = SupabaseManager.shared
//    
//    var isFormValid: Bool {
//        !email.isEmpty &&
//        !password.isEmpty &&
//        password.count >= 6 &&
//        email.contains("@")
//    }
//    
//    func signIn() async {
//        guard isFormValid else {
//            error = AppError.customMessage("Please enter valid email and password (min 6 characters)")
//            return
//        }
//        
//        isLoading = true
//        error = nil
//        
//        do {
//            try await supabase.signIn(email: email, password: password)
//            // Success - RootView will handle navigation
//        } catch {
//            self.error = AppError.customMessage("Sign in failed: \(error.localizedDescription)")
//        }
//        
//        isLoading = false
//    }
//    
//    func signUp() async {
//        guard isFormValid else {
//            error = AppError.customMessage("Please enter valid email and password (min 6 characters)")
//            return
//        }
//        
//        isLoading = true
//        error = nil
//        
//        do {
//            try await supabase.signUp(email: email, password: password)
//            // Success - user may need to verify email
//            error = AppError.customMessage("Account created! Please check your email to verify.")
//        } catch {
//            self.error = AppError.customMessage("Sign up failed: \(error.localizedDescription)")
//        }
//        
//        isLoading = false
//    }
//    
//    func resetPassword() async {
//        guard !email.isEmpty, email.contains("@") else {
//            error = AppError.customMessage("Please enter a valid email address")
//            return
//        }
//        
//        isLoading = true
//        error = nil
//        
//        do {
//            try await supabase.resetPassword(email: email)
//            error = AppError.customMessage("Password reset email sent! Please check your inbox.")
//            showForgotPassword = false
//        } catch {
//            self.error = AppError.customMessage("Reset failed: \(error.localizedDescription)")
//        }
//        
//        isLoading = false
//    }
//}

import Foundation
import Combine

//extension Notification.Name {
//    static let userSignedIn = Notification.Name("userSignedIn")
//}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var error: AppError?
    @Published var showForgotPassword = false
    
    private let supabase = SupabaseManager.shared
    
    var isFormValid: Bool {
        !email.isEmpty &&
        !password.isEmpty &&
        password.count >= 6 &&
        email.contains("@")
    }
    
    func signIn() async {
        guard isFormValid else {
            error = AppError.customMessage("Please enter valid email and password (min 6 characters)")
            return
        }
        
        isLoading = true
        error = nil
        
        do {
            try await supabase.signIn(email: email, password: password)
            // Notify RootView that user signed in
            NotificationCenter.default.post(name: .userSignedIn, object: nil)
        } catch {
            self.error = AppError.customMessage("Sign in failed: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func signUp() async {
        guard isFormValid else {
            error = AppError.customMessage("Please enter valid email and password (min 6 characters)")
            return
        }
        
        isLoading = true
        error = nil
        
        do {
            try await supabase.signUp(email: email, password: password)
            // Success - user may need to verify email
            error = AppError.customMessage("Account created! Please check your email to verify.")
        } catch {
            self.error = AppError.customMessage("Sign up failed: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func resetPassword() async {
        guard !email.isEmpty, email.contains("@") else {
            error = AppError.customMessage("Please enter a valid email address")
            return
        }
        
        isLoading = true
        error = nil
        
        do {
            try await supabase.resetPassword(email: email)
            error = AppError.customMessage("Password reset email sent! Please check your inbox.")
            showForgotPassword = false
        } catch {
            self.error = AppError.customMessage("Reset failed: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}
