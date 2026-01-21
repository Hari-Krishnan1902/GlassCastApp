//
//  SettingsView.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [.blue.opacity(0.6), .purple.opacity(0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Temperature Unit Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Temperature Unit")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            VStack(spacing: 0) {
                                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                                    Button {
                                        viewModel.updateTemperatureUnit(unit)
                                    } label: {
                                        HStack {
                                            Text(unit.displayName)
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            if viewModel.selectedUnit == unit {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        .padding()
                                        .background(
                                            Rectangle()
                                                .fill(.clear)
                                        )
                                    }
                                    
                                    if unit != TemperatureUnit.allCases.last {
                                        Divider()
                                            .background(Color.white.opacity(0.2))
                                    }
                                }
                            }
                            .glassCard()
                            .padding(.horizontal)
                        }
                        
                        // Sign Out Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Account")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Button {
                                Task {
                                    await viewModel.signOut()
                                }
                            } label: {
                                HStack {
                                    if viewModel.isLoading {
                                        ProgressView()
                                            .tint(.red)
                                    } else {
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                        Text("Sign Out")
                                    }
                                }
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .glassCard()
                                .padding(.horizontal)
                            }
                            .disabled(viewModel.isLoading)
                        }
                        
                        // App Info
                        VStack(spacing: 8) {
                            Text("Weather App")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                            
                            Text("Version 1.0.0")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .padding(.top, 20)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .errorAlert(error: $viewModel.error)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    SettingsView()
}
