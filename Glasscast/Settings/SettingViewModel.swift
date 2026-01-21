//
//  SettingViewModel.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import Foundation
import Combine

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var selectedUnit: TemperatureUnit
    @Published var isLoading = false
    @Published var error: AppError?
    
    private let userDefaults = UserDefaultsManager.shared
    private let supabase = SupabaseManager.shared
    
    init() {
        self.selectedUnit = userDefaults.temperatureUnit
    }
    
    func updateTemperatureUnit(_ unit: TemperatureUnit) {
        selectedUnit = unit
        userDefaults.temperatureUnit = unit
        
        // Post notification to refresh weather data
        NotificationCenter.default.post(name: .temperatureUnitChanged, object: nil)
    }
    
    func signOut() async {
        isLoading = true
        error = nil
        
        do {
            try await supabase.signOut()
            NotificationCenter.default.post(name: .userSignedOut, object: nil)
        } catch {
            self.error = AppError.customMessage("Sign out failed: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}

extension Notification.Name {
    static let temperatureUnitChanged = Notification.Name("temperatureUnitChanged")
}
