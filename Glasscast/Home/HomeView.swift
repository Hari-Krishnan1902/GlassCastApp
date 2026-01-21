//
//  HomeView.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import SwiftUI

//struct HomeView: View {
//    @StateObject private var viewModel = HomeViewModel()
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                LinearGradient(
//                    colors: [.blue.opacity(0.6), .purple.opacity(0.4)],
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
//                .ignoresSafeArea()
//                
//                if viewModel.isLoading && viewModel.weather == nil {
//                    ProgressView()
//                        .scaleEffect(1.5)
//                        .tint(.white)
//                } else {
//                    ScrollView {
//                        VStack(spacing: 20) {
//                            if let weather = viewModel.weather {
//                                WeatherCardView(weather: weather)
//                                    .padding(.horizontal)
//                                
//                                if !viewModel.forecast.isEmpty {
//                                    VStack(alignment: .leading, spacing: 12) {
//                                        Text("5-Day Forecast")
//                                            .font(.headline)
//                                            .foregroundColor(.white)
//                                            .padding(.horizontal)
//                                        
//                                        ScrollView(.horizontal, showsIndicators: false) {
//                                            HStack(spacing: 12) {
//                                                ForEach(viewModel.forecast) { day in
//                                                    ForecastCardView(forecast: day)
//                                                }
//                                            }
//                                            .padding(.horizontal)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.vertical)
//                    }
//                    .refreshable {
//                        await viewModel.refreshWeather()
//                    }
//                }
//            }
//            .navigationTitle("Weather")
//            .navigationBarTitleDisplayMode(.large)
//            .task {
//                await viewModel.loadWeather()
//            }
//            .errorAlert(error: $viewModel.error)
//        }
//        .navigationViewStyle(.stack)
//    } correct
//}

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [.blue.opacity(0.6), .purple.opacity(0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if viewModel.isLoading && viewModel.weather == nil {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.white)
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            if let weather = viewModel.weather {
                                WeatherCardView(weather: weather)
                                    .padding(.horizontal)
                                
                                if !viewModel.forecast.isEmpty {
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text("5-Day Forecast")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.horizontal)
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 12) {
                                                ForEach(viewModel.forecast) { day in
                                                    ForecastCardView(forecast: day)
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
//                    .refreshable {
//                        await viewModel.refreshWeather()
//                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {                     // ✅ Wrap async call in Task
                            await viewModel.refreshWeather()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .navigationTitle(viewModel.weather?.cityName ?? "Weather")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await viewModel.loadWeather()
            }
            .onReceive(NotificationCenter.default.publisher(for: .selectedCityChanged)) { _ in
                Task {
                    print("🔄 Home: Selected city changed, reloading...")
                    await viewModel.loadWeather()
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .temperatureUnitChanged)) { _ in
                Task {
                    print("🌡 Home: Temperature unit changed, reloading...")
                    await viewModel.loadWeather()
                }
            }
            .errorAlert(error: $viewModel.error)
        }
        .navigationViewStyle(.stack)
    }
}


#Preview {
    HomeView()
}



struct WeatherCardView: View {
    let weather: WeatherViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text(weather.cityName)
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.white)
            
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.iconCode)@2x.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            
            Text(weather.temperature)
                .font(.system(size: 64, weight: .thin))
                .foregroundColor(.white)
            
            Text(weather.description)
                .font(.title3)
                .foregroundColor(.white.opacity(0.9))
            
            HStack(spacing: 40) {
                VStack {
                    Text("High")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text(weather.high)
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                VStack {
                    Text("Low")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text(weather.low)
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 8)
        }
        .padding(Constants.Design.cardPadding)
        .frame(maxWidth:UIDevice.current.userInterfaceIdiom == .phone ? .infinity : UIScreen.main.bounds.width*0.7)
        .glassCard()
    }
}


struct ForecastCardView: View {
    let forecast: DailyForecast
    
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Text(forecast.day)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.iconCode)@2x.png")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
                
                VStack(spacing: 4) {
                    Text(forecast.high)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text(forecast.low)
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .padding()
            .frame(width: UIDevice.current.userInterfaceIdiom == .phone ?  120 : 200 )
            .glassCard()
        }
    }
}
