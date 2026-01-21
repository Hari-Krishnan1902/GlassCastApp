//
//  SearchViewModel.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import Foundation
import Combine

//@MainActor
//class SearchViewModel: ObservableObject {
//    @Published var searchText = ""
//    @Published var searchResults: WeatherViewModel?
//    @Published var favorites: [Favorite] = []
//    @Published var favoritesWeather: [WeatherViewModel] = []
//    @Published var isLoading = false
//    @Published var isFetchingFavorites = false
//    @Published var error: AppError?
//    @Published var hasSearched = false
//    @Published var searchIsFavorite = false
////    private let favoriteService = FavoriteService()
//    
//    private let apiManager = APIManager.shared
//    private let supabase = SupabaseManager.shared
//    private let userDefaults = UserDefaultsManager.shared
//    
//    var currentUnit: TemperatureUnit {
//        userDefaults.temperatureUnit
//    }
//    
//    func searchCity() async {
//        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
//            return
//        }
//        
//        isLoading = true
//        error = nil
//        hasSearched = true
//        
//        do {
//            let response: WeatherResponse = try await apiManager.request(
//                endpoint: .currentWeather(city: searchText, units: currentUnit.rawValue)
//            )
//            
//            searchResults = WeatherViewModel(from: response, unit: currentUnit)
//            userDefaults.lastSearchedCity = searchText
//            
//            // Check if this city is in favorites
//            await checkIfFavorite(cityName: response.name)
//            
//        } catch let appError as AppError {
//            self.error = appError
//            searchResults = nil
//        } catch {
//            self.error = .unknown
//            searchResults = nil
//        }
//        
//        isLoading = false
//    }
//    
//    func clearSearch() {
//        searchText = ""
//        searchResults = nil
//        hasSearched = false
//        searchIsFavorite = false
//        error = nil
//    }
//    
//    // MARK: - Favorites
//    
//    func fetchFavorites() async {
//        isFetchingFavorites = true
//        defer { isFetchingFavorites = false }
//        
//        do {
//            favorites = try await supabase.fetchFavorites()
//            await loadFavoritesWeather()
//        } catch {
//            self.error = AppError.customMessage("Failed to load favorites")
//        }
//        
//        isFetchingFavorites = false
//    }
//    
//    func toggleFavorite() async {
//        print("🔁 toggleFavorite called")
//        guard let weather = searchResults else {
//            print("❌ searchResults is nil")
//            return
//        }
//        print("🌆 City:", weather.cityName)
//          print("⭐️ searchIsFavorite BEFORE:", searchIsFavorite)
//        do {
//            let session = try await SupabaseManager.shared.client.auth.session
//            let userId = session.user.id
//            if searchIsFavorite {
//                print("🗑 Removing favorite")
//                try await supabase.removeFavorite(cityName: weather.cityName)
//                searchIsFavorite = false
//            } else {
//                print("➕ Adding favorite")
//                try await supabase.addFavorite(
//                    cityName: weather.cityName,
//                    lat: weather.lat,
//                    lon: weather.lon
//                )
//                searchIsFavorite = true
//            }
//            
//            // Refresh favorites list
//            await fetchFavorites()
//            
//        } catch {
//            guard let _ = try? await supabase.client.auth.session else {
//                self.error = AppError.customMessage("User not logged in")
//                return
//            }
//        }
//    }
//    
//    func removeFavorite(cityName: String) async {
//        
//        do {
//            let session = try await SupabaseManager.shared.client.auth.session
//            let userId = session.user.id
//            try await supabase.removeFavorite(cityName: cityName)
//            await fetchFavorites()
//        } catch {
//            self.error = AppError.customMessage("Failed to remove favorite")
//        }
//    }
//    
//    private func checkIfFavorite(cityName: String) async {
//        do {
//            searchIsFavorite = try await supabase.isFavorite(cityName: cityName)
//        } catch {
//            searchIsFavorite = false
////            error = .customMessage("Failed to check favorite status")
//        }
//    }
//    
//    private func loadFavoritesWeather() async {
//        var weatherData: [WeatherViewModel] = []
//        
//        for favorite in favorites {
//            do {
//                let response: WeatherResponse = try await apiManager.request(
//                    endpoint: .currentWeather(city: favorite.cityName, units: currentUnit.rawValue)
//                )
//                weatherData.append(WeatherViewModel(from: response, unit: currentUnit))
//            } catch {
//                // Skip if city weather can't be loaded
//                continue
//            }
//        }
//        
//        favoritesWeather = weatherData
//    }
//    
//    func addFavorite(
//        cityName: String,
//        lat: Double,
//        lon: Double
//    ) async throws {
//
//        guard let user = await SupabaseManager.shared.getCurrentUser() else {
//            throw AppError.customMessage("User not logged in")
//        }
//        let session = try await SupabaseManager.shared.client.auth.session
//        let userId = session.user.id
//        let insert = FavoriteInsert(
//            userId: user.id,
//            cityName: cityName,
//            lat: lat,
//            lon: lon
//        )
//
//        try await SupabaseManager.shared.client
//            .from("favorites")
//            .insert(insert)
//            .execute()
//    }
//
//}
import Foundation
import Combine

//@MainActor
//class SearchViewModel: ObservableObject {
//    @Published var searchText = ""
//    @Published var searchResults: WeatherViewModel?
//    @Published var favorites: [Favorite] = []
//    @Published var favoritesWeather: [WeatherViewModel] = []
//    @Published var isLoading = false
//    @Published var isFetchingFavorites = false
//    @Published var error: AppError?
//    @Published var hasSearched = false
//    @Published var searchIsFavorite = false
//    
//    private let apiManager = APIManager.shared
//    private let supabase = SupabaseManager.shared
//    private let userDefaults = UserDefaultsManager.shared
//    
//    var currentUnit: TemperatureUnit {
//        userDefaults.temperatureUnit
//    }
//    
//    func searchCity() async {
//        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
//            return
//        }
//        
//        isLoading = true
//        error = nil
//        hasSearched = true
//        
//        do {
//            let response: WeatherResponse = try await apiManager.request(
//                endpoint: .currentWeather(city: searchText, units: currentUnit.rawValue)
//            )
//            
//            searchResults = WeatherViewModel(from: response, unit: currentUnit)
//            userDefaults.lastSearchedCity = searchText
//            
//            // Check if this city is in favorites
//            await checkIfFavorite(cityName: response.name)
//            
//        } catch let appError as AppError {
//            self.error = appError
//            searchResults = nil
//        } catch {
//            self.error = .unknown
//            searchResults = nil
//        }
//        
//        isLoading = false
//    }
//    
//    func clearSearch() {
//        searchText = ""
//        searchResults = nil
//        hasSearched = false
//        searchIsFavorite = false
//        error = nil
//    }
//    
//    // MARK: - Favorites
//    
//    func fetchFavorites() async {
//        isFetchingFavorites = true
//        
//        do {
//            favorites = try await supabase.fetchFavorites()
//            await loadFavoritesWeather()
//        } catch {
//            self.error = AppError.customMessage("Failed to load favorites")
//        }
//        
//        isFetchingFavorites = false
//    }
//    
//    func toggleFavorite() async {
//        print("🔁 toggleFavorite called")
//        guard let weather = searchResults else {
//            print("❌ searchResults is nil")
//            return
//        }
//        
//        print("🌆 City:", weather.cityName)
//        print("⭐️ searchIsFavorite BEFORE:", searchIsFavorite)
//        
//        // Check authentication first
//        guard await supabase.isAuthenticated() else {
//            print("❌ User not authenticated")
//            self.error = AppError.customMessage("Please sign in to add favorites")
//            return
//        }
//        
//        do {
//            if searchIsFavorite {
//                print("🗑 Removing favorite")
//                try await supabase.removeFavorite(cityName: weather.cityName)
//                searchIsFavorite = false
//                print("✅ Favorite removed, searchIsFavorite:", searchIsFavorite)
//            } else {
//                print("➕ Adding favorite")
//                try await supabase.addFavorite(
//                    cityName: weather.cityName,
//                    lat: weather.lat,
//                    lon: weather.lon
//                )
//                searchIsFavorite = true
//                print("✅ Favorite added, searchIsFavorite:", searchIsFavorite)
//            }
//            
//            // Refresh favorites list
//            print("🔄 Refreshing favorites list")
//            await fetchFavorites()
//            
//        } catch let error as AppError {
//            print("❌ AppError:", error.localizedDescription)
//            self.error = error
//        } catch {
//            print("❌ Unknown error:", error)
//            self.error = AppError.customMessage("Failed to update favorite: \(error.localizedDescription)")
//        }
//    }
//    
//    func removeFavorite(cityName: String) async {
//        do {
//            try await supabase.removeFavorite(cityName: cityName)
//            await fetchFavorites()
//        } catch {
//            self.error = AppError.customMessage("Failed to remove favorite")
//        }
//    }
//    
//    private func checkIfFavorite(cityName: String) async {
//        do {
//            searchIsFavorite = try await supabase.isFavorite(cityName: cityName)
//        } catch {
//            searchIsFavorite = false
//        }
//    }
//    
//    private func loadFavoritesWeather() async {
//        var weatherData: [WeatherViewModel] = []
//        
//        for favorite in favorites {
//            do {
//                let response: WeatherResponse = try await apiManager.request(
//                    endpoint: .currentWeather(city: favorite.cityName, units: currentUnit.rawValue)
//                )
//                weatherData.append(WeatherViewModel(from: response, unit: currentUnit))
//            } catch {
//                // Skip if city weather can't be loaded
//                continue
//            }
//        }
//        
//        favoritesWeather = weatherData
//    }
//}


import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: WeatherViewModel?
    @Published var favorites: [Favorite] = []
    @Published var favoritesWeather: [WeatherViewModel] = []
    @Published var isLoading = false
    @Published var isFetchingFavorites = false
    @Published var error: AppError?
    @Published var hasSearched = false
    @Published var searchIsFavorite = false
    
    private let apiManager = APIManager.shared
    private let supabase = SupabaseManager.shared
    private let userDefaults = UserDefaultsManager.shared
    
    var currentUnit: TemperatureUnit {
        userDefaults.temperatureUnit
    }
    
    func searchCity() async {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        isLoading = true
        error = nil
        hasSearched = true
        
        do {
            let response: WeatherResponse = try await apiManager.request(
                endpoint: .currentWeather(city: searchText, units: currentUnit.rawValue)
            )
            
            searchResults = WeatherViewModel(from: response, unit: currentUnit)
            userDefaults.lastSearchedCity = searchText
            
            // Check if this city is in favorites
            await checkIfFavorite(cityName: response.name)
            
        } catch let appError as AppError {
            self.error = appError
            searchResults = nil
        } catch {
            self.error = .unknown
            searchResults = nil
        }
        
        isLoading = false
    }
    
    func clearSearch() {
        searchText = ""
        searchResults = nil
        hasSearched = false
        searchIsFavorite = false
        error = nil
    }
    
    // MARK: - Favorites
    
    func fetchFavorites() async {
        isFetchingFavorites = true
        
        do {
            favorites = try await supabase.fetchFavorites()
            print("📦 Fetched \(favorites.count) favorites from DB")
            
            // Load weather for each favorite
            await loadFavoritesWeather()
            
        } catch {
            print("❌ Error fetching favorites: \(error)")
            self.error = AppError.customMessage("Failed to load favorites")
        }
        
        isFetchingFavorites = false
    }
    
    func toggleFavorite() async {
        print("🔁 toggleFavorite called")
        guard let weather = searchResults else {
            print("❌ searchResults is nil")
            return
        }
        
        print("🌆 City:", weather.cityName)
        print("⭐️ searchIsFavorite BEFORE:", searchIsFavorite)
        
        // Check authentication first
        guard await supabase.isAuthenticated() else {
            print("❌ User not authenticated")
            self.error = AppError.customMessage("Please sign in to add favorites")
            return
        }
        
        do {
            if searchIsFavorite {
                print("🗑 Removing favorite")
                try await supabase.removeFavorite(cityName: weather.cityName)
                searchIsFavorite = false
                print("✅ Favorite removed, searchIsFavorite:", searchIsFavorite)
            } else {
                print("➕ Adding favorite")
                try await supabase.addFavorite(
                    cityName: weather.cityName,
                    lat: weather.lat,
                    lon: weather.lon
                )
                searchIsFavorite = true
                print("✅ Favorite added, searchIsFavorite:", searchIsFavorite)
            }
            
            // Refresh favorites list
            print("🔄 Refreshing favorites list")
            await fetchFavorites()
            
        } catch let error as AppError {
            print("❌ AppError:", error.localizedDescription)
            self.error = error
        } catch {
            print("❌ Unknown error:", error)
            self.error = AppError.customMessage("Failed to update favorite: \(error.localizedDescription)")
        }
    }
    
    func removeFavorite(cityName: String) async {
        do {
            try await supabase.removeFavorite(cityName: cityName)
            await fetchFavorites()
        } catch {
            self.error = AppError.customMessage("Failed to remove favorite")
        }
    }
    
    private func checkIfFavorite(cityName: String) async {
        do {
            searchIsFavorite = try await supabase.isFavorite(cityName: cityName)
        } catch {
            searchIsFavorite = false
        }
    }
    
    private func loadFavoritesWeather() async {
        print("🌤 Loading weather for \(favorites.count) favorites")
        var weatherData: [WeatherViewModel] = []
        
        for (index, favorite) in favorites.enumerated() {
            do {
                print("📍 Loading weather for: \(favorite.cityName)")
                let response: WeatherResponse = try await apiManager.request(
                    endpoint: .currentWeather(city: favorite.cityName, units: currentUnit.rawValue)
                )
                let weather = WeatherViewModel(from: response, unit: currentUnit)
                weatherData.append(weather)
                print("✅ Loaded weather for \(favorite.cityName): \(weather.temperature)")
            } catch {
                print("⚠️ Failed to load weather for \(favorite.cityName): \(error)")
                // Continue loading other favorites
                continue
            }
        }
        
        favoritesWeather = weatherData
        print("🎉 Total favorites weather loaded: \(favoritesWeather.count)")
    }
}
