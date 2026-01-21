//
//  SearchView.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import SwiftUI

//struct SearchView: View {
//    @StateObject private var viewModel = SearchViewModel()
//    @FocusState private var isSearchFocused: Bool
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
//                VStack(spacing: 0) {
//                    // Search Bar
//                    HStack {
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.white.opacity(0.6))
//                            
//                            TextField("Search city", text: $viewModel.searchText)
//                                .textFieldStyle(.plain)
//                                .foregroundColor(.white)
//                                .focused($isSearchFocused)
//                                .submitLabel(.search)
//                                .autocorrectionDisabled()
//                                .onSubmit {
//                                    Task {
//                                        await viewModel.searchCity()
//                                    }
//                                }
//                            
//                            if !viewModel.searchText.isEmpty {
//                                Button {
//                                    viewModel.clearSearch()
//                                } label: {
//                                    Image(systemName: "xmark.circle.fill")
//                                        .foregroundColor(.white.opacity(0.6))
//                                }
//                            }
//                        }
//                        .padding()
//                        .glassCard()
//                        
//                        Button {
//                            Task {
//                                await viewModel.searchCity()
//                            }
//                        } label: {
//                            Text("Search")
//                                .foregroundColor(.white)
//                                .padding(.horizontal, 16)
//                                .padding(.vertical, 12)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 12)
//                                        .fill(.blue)
//                                )
//                        }
//                    }
//                    .padding()
//                    
//                    // Results
//                    ScrollView {
//                        VStack(spacing: 20) {
//                            if viewModel.isLoading {
//                                ProgressView()
//                                    .scaleEffect(1.5)
//                                    .tint(.white)
//                                    .padding(.top, 50)
//                            } else if let result = viewModel.searchResults {
//                                VStack(alignment: .leading, spacing: 12) {
//                                    Text("Search Result")
//                                        .font(.headline)
//                                        .foregroundColor(.white)
//                                        .padding(.horizontal)
//                                    
//                                    CityCardView(weather: result, isFavorite: $viewModel.searchIsFavorite, onFavoriteTap: {
//                                        Task {
//                                            await viewModel.toggleFavorite()
//                                        }
//                                    })
//                                        .padding(.horizontal)
//                                }
//                                .padding(.top)
//                            } else if viewModel.hasSearched {
//                                Text("No results found")
//                                    .foregroundColor(.white.opacity(0.7))
//                                    .padding(.top, 50)
//                            }
//                            
//                            // Favorites Section (placeholder for now)
//                            if !viewModel.hasSearched || viewModel.searchResults != nil {
//                                VStack(alignment: .leading, spacing: 12) {
//                                    Text("Favorite Cities")
//                                        .font(.headline)
//                                        .foregroundColor(.white)
//                                        .padding(.horizontal)
//                                    
//                                    Text("Favorites will appear here")
//                                        .font(.subheadline)
//                                        .foregroundColor(.white.opacity(0.6))
//                                        .padding(.horizontal)
//                                        .padding(.vertical, 40)
//                                        .frame(maxWidth: .infinity)
//                                        .glassCard()
//                                        .padding(.horizontal)
//                                }
//                                .padding(.top, 20)
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Search")
//            .navigationBarTitleDisplayMode(.large)
//            .errorAlert(error: $viewModel.error)
//        }
//        .navigationViewStyle(.stack)
//    }
//}
//
//
struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @FocusState private var isSearchFocused: Bool
    @State private var selectedCityForHome: String
    
    init() {
        _selectedCityForHome = State(initialValue: UserDefaultsManager.shared.selectedCity)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [.blue.opacity(0.6), .purple.opacity(0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Search Bar
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white.opacity(0.6))
                            
                            TextField("Search city", text: $viewModel.searchText)
                                .textFieldStyle(.plain)
                                .foregroundColor(.white)
                                .focused($isSearchFocused)
                                .submitLabel(.search)
                                .onSubmit {
                                    Task {
                                        await viewModel.searchCity()
                                    }
                                }
                            
                            if !viewModel.searchText.isEmpty {
                                Button {
                                    viewModel.clearSearch()
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.white.opacity(0.6))
                                }
                            }
                        }
                        .padding()
                        .glassCard()
                        
                        Button {
                            Task {
                                await viewModel.searchCity()
                            }
                        } label: {
                            Text("Search")
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.blue)
                                )
                        }
                    }
                    .padding()
                    
                    // Results
                    ScrollView {
                        VStack(spacing: 20) {
                            if viewModel.isLoading {
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .tint(.white)
                                    .padding(.top, 50)
                            } else if let result = viewModel.searchResults {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Search Result")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                    
                                    CityCardView(
                                        weather: result,
                                        isFavorite: $viewModel.searchIsFavorite,
                                        onFavoriteTap: {
                                            Task {
                                                await viewModel.toggleFavorite()
                                            }
                                        },
                                        onCardTap: {
                                            selectCityForHome(result.cityName)
                                        },
                                        showSelectIndicator: true,
                                        isSelected: selectedCityForHome == result.cityName
                                    )
                                    .padding(.horizontal)
                                    
                                    Text("Tap card to set as home screen city")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.6))
                                        .padding(.horizontal)
                                }
                                .padding(.top)
                            } else if viewModel.hasSearched {
                                Text("No results found")
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding(.top, 50)
                            }
                            
                            // Favorites Section
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Favorite Cities")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text("\(viewModel.favorites.count) saved")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                .padding(.horizontal)
                                
                                if viewModel.isFetchingFavorites {
                                    ProgressView()
                                        .tint(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 40)
                                } else if viewModel.favorites.isEmpty {
                                    Text("No favorites yet. Search for a city and tap the star to add it!")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.6))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                        .padding(.vertical, 40)
                                        .frame(maxWidth: .infinity)
                                        .glassCard()
                                        .padding(.horizontal)
                                } else if viewModel.favoritesWeather.isEmpty {
                                    Text("Loading weather data for \(viewModel.favorites.count) favorites...")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.6))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                        .padding(.vertical, 40)
                                        .frame(maxWidth: .infinity)
                                        .glassCard()
                                        .padding(.horizontal)
                                } else {
                                    ForEach(Array(viewModel.favoritesWeather.enumerated()), id: \.offset) { index, weather in
                                        CityCardView(
                                            weather: weather,
                                            isFavorite: .constant(true),
                                            onFavoriteTap: {
                                                Task {
                                                    await viewModel.removeFavorite(cityName: weather.cityName)
                                                }
                                            },
                                            onCardTap: {
                                                selectCityForHome(weather.cityName)
                                            },
                                            showSelectIndicator: true,
                                            isSelected: selectedCityForHome == weather.cityName
                                        )
                                        .padding(.horizontal)
                                    }
                                    
                                    Text("Tap any card to set as home screen city")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.6))
                                        .padding(.horizontal)
                                        .padding(.top, 8)
                                }
                            }
                            .padding(.top, 20)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .errorAlert(error: $viewModel.error)
            .task {
                print("🔄 SearchView appeared - fetching favorites")
                await viewModel.fetchFavorites()
            }
            .onReceive(NotificationCenter.default.publisher(for: .temperatureUnitChanged)) { _ in
                Task {
                    print("🌡 Temperature unit changed - refreshing favorites")
                    await viewModel.fetchFavorites()
                }
            }
            .onAppear {
                print("👁 SearchView onAppear")
                print("📊 Current state:")
                print("   - Favorites count: \(viewModel.favorites.count)")
                print("   - Weather loaded: \(viewModel.favoritesWeather.count)")
                print("   - Is fetching: \(viewModel.isFetchingFavorites)")
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func selectCityForHome(_ cityName: String) {
        print("🏠 Setting home screen city to: \(cityName)")
        selectedCityForHome = cityName
        UserDefaultsManager.shared.selectedCity = cityName
        
        // Show feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}//struct CityCardView: View {
//    let weather: WeatherViewModel
//    @Binding var isFavorite:Bool
//    var onFavoriteTap: () -> Void
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 8) {
//                Text(weather.cityName)
//                    .font(.title2)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
//                
//                Text(weather.description)
//                    .font(.subheadline)
//                    .foregroundColor(.white.opacity(0.8))
//                
//                HStack(spacing: 16) {
//                    Label(weather.high, systemImage: "arrow.up")
//                        .font(.caption)
//                        .foregroundColor(.white.opacity(0.9))
//                    
//                    Label(weather.low, systemImage: "arrow.down")
//                        .font(.caption)
//                        .foregroundColor(.white.opacity(0.9))
//                }
//            }
//            
//            Spacer()
//            
//            VStack {
//                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.iconCode)@2x.png")) { image in
//                    image
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 60, height: 60)
//                } placeholder: {
//                    ProgressView()
//                        .frame(width: 60, height: 60)
//                }
//                
//                Text(weather.temperature)
//                    .font(.system(size: 32, weight: .medium))
//                    .foregroundColor(.white)
//            }
//            Image(systemName: isFavorite ? "star.fill" : "star")
//                .resizable()
//                .frame(width: 15, height: 15)
//                .foregroundColor(isFavorite ? .yellow : .white.opacity(0.5))
//                .font(.system(size: 10))
//                .frame(maxHeight: .infinity,alignment: .top)
//                .onTapGesture {
//                    print("⭐️ Star tapped in CityCardView")
//                    onFavoriteTap()
//                }
//        }
//        .padding()
//        .glassCard()
//    }
//}
// coorrect above
//import SwiftUI

//struct SearchView: View {
//    @StateObject private var viewModel = SearchViewModel()
//    @FocusState private var isSearchFocused: Bool
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
//                VStack(spacing: 0) {
//                    // Search Bar
//                    HStack {
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.white.opacity(0.6))
//                            
//                            TextField("Search city", text: $viewModel.searchText)
//                                .textFieldStyle(.plain)
//                                .foregroundColor(.white)
//                                .focused($isSearchFocused)
//                                .submitLabel(.search)
//                                .onSubmit {
//                                    Task {
//                                        await viewModel.searchCity()
//                                    }
//                                }
//                            
//                            if !viewModel.searchText.isEmpty {
//                                Button {
//                                    viewModel.clearSearch()
//                                } label: {
//                                    Image(systemName: "xmark.circle.fill")
//                                        .foregroundColor(.white.opacity(0.6))
//                                }
//                            }
//                        }
//                        .padding()
//                        .glassCard()
//                        
//                        Button {
//                            Task {
//                                await viewModel.searchCity()
//                            }
//                        } label: {
//                            Text("Search")
//                                .foregroundColor(.white)
//                                .padding(.horizontal, 16)
//                                .padding(.vertical, 12)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 12)
//                                        .fill(.blue)
//                                )
//                        }
//                    }
//                    .padding()
//                    
//                    // Results
//                    ScrollView {
//                        VStack(spacing: 20) {
//                            if viewModel.isLoading {
//                                ProgressView()
//                                    .scaleEffect(1.5)
//                                    .tint(.white)
//                                    .padding(.top, 50)
//                            } else if let result = viewModel.searchResults {
//                                VStack(alignment: .leading, spacing: 12) {
//                                    Text("Search Result")
//                                        .font(.headline)
//                                        .foregroundColor(.white)
//                                        .padding(.horizontal)
//                                    
//                                    CityCardView(
//                                        weather: result,
//                                        isFavorite: $viewModel.searchIsFavorite,
//                                        onFavoriteTap: {
//                                            Task {
//                                                await viewModel.toggleFavorite()
//                                            }
//                                        }
//                                    )
//                                    .padding(.horizontal)
//                                }
//                                .padding(.top)
//                            } else if viewModel.hasSearched {
//                                Text("No results found")
//                                    .foregroundColor(.white.opacity(0.7))
//                                    .padding(.top, 50)
//                            }
//                            
//                            // Favorites Section
//                            VStack(alignment: .leading, spacing: 12) {
//                                Text("Favorite Cities")
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal)
//                                
//                                if viewModel.isFetchingFavorites {
//                                    ProgressView()
//                                        .tint(.white)
//                                        .frame(maxWidth: .infinity)
//                                        .padding(.vertical, 40)
//                                } else if viewModel.favoritesWeather.isEmpty {
//                                    Text("No favorites yet. Search for a city and tap the star to add it!")
//                                        .font(.subheadline)
//                                        .foregroundColor(.white.opacity(0.6))
//                                        .multilineTextAlignment(.center)
//                                        .padding(.horizontal)
//                                        .padding(.vertical, 40)
//                                        .frame(maxWidth: .infinity)
//                                        .glassCard()
//                                        .padding(.horizontal)
//                                } else {
//                                    ForEach(Array(viewModel.favoritesWeather.enumerated()), id: \.offset) { index, weather in
//                                        CityCardView(
//                                            weather: weather,
//                                            isFavorite: .constant(true),
//                                            onFavoriteTap: {
//                                                Task {
//                                                    await viewModel.removeFavorite(cityName: weather.cityName)
//                                                }
//                                            }
//                                        )
//                                        .padding(.horizontal)
//                                    }
//                                }
//                            }
//                            .padding(.top, 20)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Search")
//            .navigationBarTitleDisplayMode(.large)
//            .errorAlert(error: $viewModel.error)
//            .task {
//                await viewModel.fetchFavorites()
//            }
//            .onReceive(NotificationCenter.default.publisher(for: .temperatureUnitChanged)) { _ in
//                Task {
//                    await viewModel.fetchFavorites()
//                }
//            }
//        }
//        .navigationViewStyle(.stack)
//    }
//}

import SwiftUI

struct CityCardView: View {
    let weather: WeatherViewModel
    @Binding var isFavorite: Bool
    var onFavoriteTap: () -> Void
    var onCardTap: (() -> Void)? = nil
    var showSelectIndicator: Bool = false
    var isSelected: Bool = false
    
    var body: some View {
//        Button {
//            onCardTap?()
//        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(weather.cityName)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        if showSelectIndicator && isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 16))
                        }
                    }
                    
                    Text(weather.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    HStack(spacing: 16) {
                        Label(weather.high, systemImage: "arrow.up")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.9))
                        
                        Label(weather.low, systemImage: "arrow.down")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.9))
                    }
                }
                
                Spacer()
                
                VStack {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.iconCode)@2x.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 60, height: 60)
                    }
                    
                    Text(weather.temperature)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(.white)
                }
                
                Button {
                    onFavoriteTap()
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isFavorite ? .yellow : .white.opacity(0.6))
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 8)
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                onCardTap?()
            }
//        }
        .buttonStyle(.plain)
        .glassCard()
    }
}

#Preview {
    SearchView()
}
