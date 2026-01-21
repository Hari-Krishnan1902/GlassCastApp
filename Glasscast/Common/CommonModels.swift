//
//  CommonModels.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import Foundation

// MARK: - Weather Model
struct WeatherResponse: Codable {
    let coord: Coordinates?
    let main: MainWeather
    let weather: [WeatherCondition]
    let name: String
    let dt: Int
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct MainWeather: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
}

struct WeatherCondition: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Forecast Model
struct ForecastResponse: Codable {
    let list: [ForecastItem]
    let city: City
}

struct ForecastItem: Codable {
    let dt: Int
    let main: MainWeather
    let weather: [WeatherCondition]
    let dtTxt: String
}

struct City: Codable {
    let name: String
    let country: String
    let coord: Coordinates
}

// MARK: - View Models for UI
struct WeatherViewModel {
    let cityName: String
    let temperature: String
    let condition: String
    let description: String
    let high: String
    let low: String
    let iconCode: String
    let lat: Double
    let lon: Double
    
    init(from response: WeatherResponse, unit: TemperatureUnit) {
        self.cityName = response.name
        self.temperature = "\(Int(response.main.temp))\(unit.symbol)"
        self.condition = response.weather.first?.main ?? ""
        self.description = response.weather.first?.description.capitalized ?? ""
        self.high = "\(Int(response.main.tempMax))\(unit.symbol)"
        self.low = "\(Int(response.main.tempMin))\(unit.symbol)"
        self.iconCode = response.weather.first?.icon ?? ""
        self.lat = response.coord?.lat ?? 0.0
        self.lon = response.coord?.lon ?? 0.0
    }
}

struct DailyForecast: Identifiable {
    let id = UUID()
    let day: String
    let iconCode: String
    let high: String
    let low: String
    
    static func from(_ items: [ForecastItem], unit: TemperatureUnit) -> [DailyForecast] {
        let grouped = Dictionary(grouping: items) { item -> String in
            let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
        
        let sorted = grouped.sorted { $0.key < $1.key }
        
        return sorted.prefix(5).map { key, items in
            let date = key
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let parsedDate = formatter.date(from: date) {
                formatter.dateFormat = "EEE"
                let dayName = formatter.string(from: parsedDate)
                
                let temps = items.map { $0.main.temp }
                let high = temps.max() ?? 0
                let low = temps.min() ?? 0
                let icon = items.first?.weather.first?.icon ?? ""
                
                return DailyForecast(
                    day: dayName,
                    iconCode: icon,
                    high: "\(Int(high))\(unit.symbol)",
                    low: "\(Int(low))\(unit.symbol)"
                )
            }
            return DailyForecast(day: "", iconCode: "", high: "", low: "")
        }
    }
}

struct Favorite: Codable, Identifiable {
    let id: UUID
    let userId: UUID
    let cityName: String
    let lat: Double
    let lon: Double
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case cityName = "city_name"
        case lat
        case lon
        case createdAt = "created_at"
    }
}

struct FavoriteInsert: Codable {
    let userId: UUID
    let cityName: String
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case cityName = "city_name"
        case lat
        case lon
    }
}
