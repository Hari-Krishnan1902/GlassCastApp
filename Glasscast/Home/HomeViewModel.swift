//
//  HomeViewModel.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import Foundation
import Combine

//@MainActor
//class HomeViewModel: ObservableObject {
//    @Published var weather: WeatherViewModel?
//    @Published var forecast: [DailyForecast] = []
//    @Published var isLoading = false
//    @Published var error: AppError?
//    
//    private let apiManager = APIManager.shared
//    private let userDefaults = UserDefaultsManager.shared
//    
//    var currentUnit: TemperatureUnit {
//        userDefaults.temperatureUnit
//    }
//    
//    func loadWeather(for city: String = "kumbakonam") async {
//        isLoading = true
//        error = nil
//        
//        do {
//            async let weatherTask: WeatherResponse = apiManager.request(
//                endpoint: .currentWeather(city: city, units: currentUnit.rawValue)
//            )
//            async let forecastTask: ForecastResponse = apiManager.request(
//                endpoint: .forecast(city: city, units: currentUnit.rawValue)
//            )
//            
//            let (weatherResponse, forecastResponse) = try await (weatherTask, forecastTask)
//            
//            self.weather = WeatherViewModel(from: weatherResponse, unit: currentUnit)
//            self.forecast = DailyForecast.from(forecastResponse.list, unit: currentUnit)
//            
//            userDefaults.lastSearchedCity = city
//            
//        } catch let appError as AppError {
//            self.error = appError
//        } catch {
//            self.error = .unknown
//        }
//        
//        isLoading = false
//    }
//    
//    func refreshWeather() async {
//        if let lastCity = userDefaults.lastSearchedCity {
//            await loadWeather(for: lastCity)
//        } else {
//            await loadWeather()
//        }
//    }
//}
import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var weather: WeatherViewModel?
    @Published var forecast: [DailyForecast] = []
    @Published var isLoading = false
    @Published var error: AppError?
    
    private let apiManager = APIManager.shared
    private let userDefaults = UserDefaultsManager.shared
    
    var currentUnit: TemperatureUnit {
        userDefaults.temperatureUnit
    }
    
    var selectedCity: String {
        userDefaults.selectedCity
    }
    
    func loadWeather(for city: String? = nil) async {
        let cityToLoad = city ?? userDefaults.selectedCity
        
        print("🏠 Home: Loading weather for \(cityToLoad)")
        isLoading = true
        error = nil
        
        do {
            async let weatherTask: WeatherResponse = apiManager.request(
                endpoint: .currentWeather(city: cityToLoad, units: currentUnit.rawValue)
            )
            async let forecastTask: ForecastResponse = apiManager.request(
                endpoint: .forecast(city: cityToLoad, units: currentUnit.rawValue)
            )
            
            let (weatherResponse, forecastResponse) = try await (weatherTask, forecastTask)
            
            self.weather = WeatherViewModel(from: weatherResponse, unit: currentUnit)
            self.forecast = DailyForecast.from(forecastResponse.list, unit: currentUnit)
            
            print("✅ Home: Weather loaded for \(cityToLoad)")
            
        } catch let appError as AppError {
            self.error = appError
        } catch {
            self.error = .unknown
        }
        
        isLoading = false
    }
    
    func refreshWeather() async {
        await loadWeather()
    }
}
//import Foundation
//import Combine

//@MainActor
//class HomeViewModel: ObservableObject {
//    @Published var weather: WeatherViewModel?
//    @Published var forecast: [DailyForecast] = []
//    @Published var isLoading = false
//    @Published var error: AppError?
//    
//    private let apiManager = APIManager.shared
//    private let userDefaults = UserDefaultsManager.shared
//    
//    var currentUnit: TemperatureUnit {
//        userDefaults.temperatureUnit
//    }
//    
//    func loadWeather(for city: String = "London") async {
//        isLoading = true
//        error = nil
//        
//        do {
//            async let weatherTask: WeatherResponse = apiManager.request(
//                endpoint: .currentWeather(city: city, units: currentUnit.rawValue)
//            )
//            async let forecastTask: ForecastResponse = apiManager.request(
//                endpoint: .forecast(city: city, units: currentUnit.rawValue)
//            )
//            
//            let (weatherResponse, forecastResponse) = try await (weatherTask, forecastTask)
//            
//            self.weather = WeatherViewModel(from: weatherResponse, unit: currentUnit)
//            self.forecast = DailyForecast.from(forecastResponse.list, unit: currentUnit)
//            
//            userDefaults.lastSearchedCity = city
//            
//        } catch let appError as AppError {
//            self.error = appError
//        } catch {
//            self.error = .unknown
//        }
//        
//        isLoading = false
//    }
//    
//    func refreshWeather() async {
//        if let lastCity = userDefaults.lastSearchedCity {
//            await loadWeather(for: lastCity)
//        } else {
//            await loadWeather()
//        }
//    }
//}
