//
//  Constant.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

//import Foundation
//import SwiftUICore
//import SwiftUI
//struct Constants {
//    struct API {
//        static let baseURL = "https://api.openweathermap.org/data/2.5"
//        static let apiKey = "483047e8a753d8e105c12c916afba1d9" 
//    }
//    
//    struct UserDefaults {
//        static let temperatureUnit = "temperatureUnit"
//        static let lastSearchedCity = "lastSearchedCity"
//    }
//    
//    struct Design {
//        static let cardCornerRadius: CGFloat = 20
//        static let cardPadding: CGFloat = 16
//    }
//}
//
//enum TemperatureUnit: String, CaseIterable {
//    case celsius = "metric"
//    case fahrenheit = "imperial"
//    
//    var symbol: String {
//        switch self {
//        case .celsius: return "°C"
//        case .fahrenheit: return "°F"
//        }
//    }
//    
//    var displayName: String {
//        switch self {
//        case .celsius: return "Celsius"
//        case .fahrenheit: return "Fahrenheit"
//        }
//    }
//}
//
enum AppError: LocalizedError {
    case networkError(Error)
    case invalidResponse
    case decodingError
    case invalidURL
    case noData
    case cityNotFound
    case customMessage(String)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Unable to process weather data"
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .cityNotFound:
            return "City not found. Please check the name and try again."
        case .customMessage(let message):
            return message
        case .unknown:
            return "An unknown error occurred"
        }
    }
}
//
enum Endpoint {
    case currentWeather(city: String, units: String)
    case forecast(city: String, units: String)
    
    var url: URL? {
        var components = URLComponents(string: Constants.API.baseURL)
        
        switch self {
        case .currentWeather(let city, let units):
            components?.path += "/weather"
            components?.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "units", value: units),
                URLQueryItem(name: "appid", value: Constants.API.apiKey)
            ]
            
        case .forecast(let city, let units):
            components?.path += "/forecast"
            components?.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "units", value: units),
                URLQueryItem(name: "appid", value: Constants.API.apiKey)
            ]
        }
        
        return components?.url
    }
}
//
//class UserDefaultsManager {
//    static let shared = UserDefaultsManager()
//    private init() {}
//    
//    var temperatureUnit: TemperatureUnit {
//        get {
//            let unitString = UserDefaults.standard.string(forKey: Constants.UserDefaults.temperatureUnit) ?? TemperatureUnit.celsius.rawValue
//            return TemperatureUnit(rawValue: unitString) ?? .celsius
//        }
//        set {
//            UserDefaults.standard.set(newValue.rawValue, forKey: Constants.UserDefaults.temperatureUnit)
//        }
//    }
//    
//    var lastSearchedCity: String? {
//        get {
//            UserDefaults.standard.string(forKey: Constants.UserDefaults.lastSearchedCity)
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.lastSearchedCity)
//        }
//    }
//}
//
//MARK: Extensions
extension View {
    func glassCard() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: Constants.Design.cardCornerRadius)
                    .fill(.ultraThinMaterial.opacity(0.7))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
    }
    
    func errorAlert(error: Binding<AppError?>) -> some View {
        self.alert("Error", isPresented: Binding(
            get: { error.wrappedValue != nil },
            set: { if !$0 { error.wrappedValue = nil } }
        )) {
            Button("OK") {
                error.wrappedValue = nil
            }
        } message: {
            if let error = error.wrappedValue {
                Text(error.localizedDescription)
            }
        }
    }
} //correct

import Foundation
import SwiftUICore

struct Constants {
    struct API {
        static let baseURL = "https://api.openweathermap.org/data/2.5"
        static let apiKey = "483047e8a753d8e105c12c916afba1d9" // Replace with your OpenWeatherMap API key
    }
    
    struct UserDefaults {
        static let temperatureUnit = "temperatureUnit"
        static let lastSearchedCity = "lastSearchedCity"
        static let selectedCity = "selectedCity"
    }
    
    struct Design {
        static let cardCornerRadius: CGFloat = 20
        static let cardPadding: CGFloat = 16
    }
}

enum TemperatureUnit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
    
    var symbol: String {
        switch self {
        case .celsius: return "°C"
        case .fahrenheit: return "°F"
        }
    }
    
    var displayName: String {
        switch self {
        case .celsius: return "Celsius"
        case .fahrenheit: return "Fahrenheit"
        }
    }
}
  //  import Foundation
//
//struct Constants {
//    struct API {
//        static let baseURL = "https://api.openweathermap.org/data/2.5"
//        static let apiKey = "YOUR_API_KEY_HERE" // Replace with your OpenWeatherMap API key
//    }
//    
//    struct UserDefaults {
//        static let temperatureUnit = "temperatureUnit"
//        static let lastSearchedCity = "lastSearchedCity"
//    }
//    
//    struct Design {
//        static let cardCornerRadius: CGFloat = 20
//        static let cardPadding: CGFloat = 16
//    }
//}

//enum TemperatureUnit: String, CaseIterable {
//    case celsius = "metric"
//    case fahrenheit = "imperial"
//    
//    var symbol: String {
//        switch self {
//        case .celsius: return "°C"
//        case .fahrenheit: return "°F"
//        }
//    }
//    
//    var displayName: String {
//        switch self {
//        case .celsius: return "Celsius"
//        case .fahrenheit: return "Fahrenheit"
//        }
//    }
//}

import Foundation
import SwiftUI

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}
    
    var temperatureUnit: TemperatureUnit {
        get {
            let unitString = UserDefaults.standard.string(forKey: Constants.UserDefaults.temperatureUnit) ?? TemperatureUnit.celsius.rawValue
            return TemperatureUnit(rawValue: unitString) ?? .celsius
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Constants.UserDefaults.temperatureUnit)
        }
    }
    
    var lastSearchedCity: String? {
        get {
            UserDefaults.standard.string(forKey: Constants.UserDefaults.lastSearchedCity)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.lastSearchedCity)
        }
    }
    
    var selectedCity: String {
        get {
            UserDefaults.standard.string(forKey: Constants.UserDefaults.selectedCity) ?? "Kumbakonam"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.selectedCity)
            // Notify HomeView to refresh
            NotificationCenter.default.post(name: .selectedCityChanged, object: nil)
        }
    }
}

extension Notification.Name {
    static let selectedCityChanged = Notification.Name("selectedCityChanged")
}
//import Foundation
//import SwiftUI

//class UserDefaultsManager {
//    static let shared = UserDefaultsManager()
//    private init() {}
//    
//    var temperatureUnit: TemperatureUnit {
//        get {
//            let unitString = UserDefaults.standard.string(forKey: Constants.UserDefaults.temperatureUnit) ?? TemperatureUnit.celsius.rawValue
//            return TemperatureUnit(rawValue: unitString) ?? .celsius
//        }
//        set {
//            UserDefaults.standard.set(newValue.rawValue, forKey: Constants.UserDefaults.temperatureUnit)
//        }
//    }
//    
//    var lastSearchedCity: String? {
//        get {
//            UserDefaults.standard.string(forKey: Constants.UserDefaults.lastSearchedCity)
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.lastSearchedCity)
//        }
//    }
//}
