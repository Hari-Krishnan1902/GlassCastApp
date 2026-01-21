//
//  AuthView.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import SwiftUI
struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var isSignUpMode = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue.opacity(0.8), .purple.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Logo/Header
                    VStack(spacing: 12) {
                        Image(systemName: "cloud.sun.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                        
                        Text("Glasscast")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(isSignUpMode ? "Create your account" : "Welcome back")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.top, 60)
                    
                    // Auth Form
                    VStack(spacing: 16) {
                        // Email Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                            
                            TextField("", text: $viewModel.email)
                                .textFieldStyle(.plain)
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.white.opacity(0.2))
                                )
                                .foregroundColor(.white)
                        }
                        
                        // Password Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                            
                            SecureField("", text: $viewModel.password)
                                .textFieldStyle(.plain)
                                .textContentType(isSignUpMode ? .newPassword : .password)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.white.opacity(0.2))
                                )
                                .foregroundColor(.white)
                        }
                        
                        // Forgot Password
                        if !isSignUpMode {
                            Button {
                                viewModel.showForgotPassword = true
                            } label: {
                                Text("Forgot Password?")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.9))
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                        // Action Button
                        Button {
                            Task {
                                if isSignUpMode {
                                    await viewModel.signUp()
                                } else {
                                    await viewModel.signIn()
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                viewModel.email = ""
                                viewModel.password = ""
                            }
                        } label: {
                            HStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Text(isSignUpMode ? "Sign Up" : "Sign In")
                                        .fontWeight(.semibold)
                                }
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(viewModel.isFormValid ? Color.blue : Color.gray)
                            )
                        }
                        .disabled(!viewModel.isFormValid || viewModel.isLoading)
                        .padding(.top, 8)
                        
                        // Toggle Mode
                        Button {
                            withAnimation {
                                isSignUpMode.toggle()
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Text(isSignUpMode ? "Already have an account?" : "Don't have an account?")
                                    .foregroundColor(.white.opacity(0.8))
                                Text(isSignUpMode ? "Sign In" : "Sign Up")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            .font(.subheadline)
                        }
                        .padding(.top, 8)
                    }
                    .padding(24)
                    .glassCard()
                    .padding(.horizontal)
                }
                .frame(maxWidth:UIDevice.current.userInterfaceIdiom == .pad ? 700 : nil)
            }
        }
        .sheet(isPresented: $viewModel.showForgotPassword) {
            ForgotPasswordView(viewModel: viewModel)
        }
        .errorAlert(error: $viewModel.error)
    }
}

struct ForgotPasswordView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [.blue.opacity(0.6), .purple.opacity(0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Text("Enter your email address and we'll send you a link to reset your password.")
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                        
                        TextField("", text: $viewModel.email)
                            .textFieldStyle(.plain)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.white.opacity(0.2))
                            )
                            .foregroundColor(.white)
                    }
                    
                    Button {
                        Task {
                            await viewModel.resetPassword()
                        }
                    } label: {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text("Send Reset Link")
                                    .fontWeight(.semibold)
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                        )
                    }
                    .disabled(viewModel.isLoading)
                    
                    Spacer()
                }
                .padding()
                .padding(.top, 40)
            }
            .navigationTitle("Reset Password")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    AuthView()
}
