# GlassCast - Weather App

## Project Overview

**GlassCast** is a modern iOS weather application built with SwiftUI, featuring a beautiful glass-morphic design, real-time weather data, and user favorites management with Supabase backend.

**Platforms**: iPhone & iPad (iOS 15.0+)  
**Architecture**: MVVM (Model-View-ViewModel)  
**Design Language**: Liquid Glass / Glassmorphism  
**Backend**: Supabase (Auth + Database)  
**Weather API**: OpenWeatherMap

---

## Key Features

### 1. **Authentication** (Supabase)
- Email/password sign up and sign in
- Password reset functionality
- Session persistence using Supabase SDK
- Automatic session management
- Secure sign out

### 2. **Home Screen**
- Displays weather for user-selected city
- Current weather card with:
  - Temperature
  - Weather condition & description
  - High/Low temperatures
  - Weather icon
- 5-day forecast with horizontal scroll
- Refresh button in navigation bar
- Auto-updates on city or unit change
- Default city: Kumbakonam (user configurable)

### 3. **Search & Favorites**
- City search with real-time weather
- Add/remove favorites (star icon)
- Tap city card to set as home screen city
- Visual indicator (green checkmark) for selected city
- Favorites list with current weather
- Persisted to Supabase with Row Level Security (RLS)
- Haptic feedback on selection

### 4. **Settings**
- Temperature unit toggle (Celsius/Fahrenheit)
- Unit preference persists across sessions
- Sign out functionality
- App version display

### 5. **Design System**
- Glass-morphic cards (`.ultraThinMaterial`)
- Translucent tab bar with blur effect
- Gradient backgrounds
- Consistent spacing and corner radius
- Adaptive layouts for iPhone and iPad

---

## Technical Architecture

**MVVM Pattern** with clean separation of concerns:
- Views handle UI presentation
- ViewModels manage business logic and state
- Models represent data structures
- Managers handle external services (API, Database, Storage)

---

## Data Models

### **WeatherResponse** (OpenWeatherMap API)
```swift
struct WeatherResponse: Codable {
    let coord: Coordinates?
    let main: MainWeather
    let weather: [WeatherCondition]
    let name: String
    let dt: Int
}
```

### **Favorite** (Supabase Database)
```swift
struct Favorite: Codable {
    let id: UUID
    let userId: UUID
    let cityName: String
    let lat: Double
    let lon: Double
    let createdAt: Date
}
```

### **Database Schema** (Supabase)
```sql
favorites (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES auth.users,
  city_name TEXT NOT NULL,
  lat DOUBLE PRECISION NOT NULL,
  lon DOUBLE PRECISION NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, city_name)
)
```

---

## API Integration

### **OpenWeatherMap API**
- **Base URL**: `https://api.openweathermap.org/data/2.5`
- **Endpoints Used**:
  - `/weather` - Current weather
  - `/forecast` - 5-day forecast
- **Units**: metric (Celsius) / imperial (Fahrenheit)
- **Authentication**: API key in query params

### **Supabase**
- **Auth**: Email/password authentication
- **Database**: PostgreSQL with Row Level Security
- **RLS Policies**:
  - Users can only view their own favorites
  - Users can only insert their own favorites
  - Users can only delete their own favorites
  - Enforced at database level

---

## State Management

### **UserDefaults Persisted Data**
- `temperatureUnit` - User's preferred temperature unit
- `selectedCity` - City displayed on home screen (default: "Kumbakonam")
- `lastSearchedCity` - Last searched city name

### **Supabase Persisted Data**
- User authentication session (automatic)
- User favorites (city name, coordinates)

### **NotificationCenter Events**
- `temperatureUnitChanged` - Temperature unit toggled
- `selectedCityChanged` - Home screen city changed
- `userSignedIn` - User authenticated
- `userSignedOut` - User logged out

---

## Key Patterns & Conventions

### **MVVM Architecture**
- **Views**: SwiftUI views (declarative UI)
- **ViewModels**: `@MainActor` classes with `@Published` properties
- **Models**: Codable structs for API and database

### **Async/Await**
- All network calls use async/await
- No completion handlers or Combine publishers for API calls
- Task-based concurrency

### **Error Handling**
- Centralized `AppError` enum
- Global error alert modifier: `.errorAlert(error:)`
- User-friendly error messages

### **Naming Conventions**
- ViewModels end with `ViewModel`
- API models end with `Response`
- Database insert models end with `Insert`
- Constants in `Constants` struct
- Extensions in `View+Extensions.swift`

### **Design Constants**
```swift
struct Constants {
    struct Design {
        static let cardCornerRadius: CGFloat = 20
        static let cardPadding: CGFloat = 16
    }
}
```

---

## Setup Requirements

### **1. OpenWeatherMap API**
- Sign up at [openweathermap.org](https://openweathermap.org)
- Get API key
- Add to `Constants.swift`:
  ```swift
  static let apiKey = "YOUR_API_KEY_HERE"
  ```

### **2. Supabase Project**
- Create project at [supabase.com](https://supabase.com)
- Get Project URL and anon key
- Add to `SupabaseManager.swift`:
  ```swift
  supabaseURL: URL(string: "YOUR_SUPABASE_URL")!
  supabaseKey: "YOUR_SUPABASE_ANON_KEY"
  ```
- Run SQL to create favorites table with RLS (see SQL artifact)

### **3. Xcode Dependencies**
- Add Supabase Swift package:
  ```
  https://github.com/supabase/supabase-swift
  ```

---

## User Flows

### **First Launch**
1. App checks for session → None found
2. Shows **AuthView** (sign in/sign up)
3. User signs up/signs in
4. Session saved automatically
5. Navigate to **Home** screen

### **Authenticated User**
1. App checks session → Found
2. Go directly to **Home** screen
3. Load weather for selected city (default: Kumbakonam)

### **Search & Add Favorite**
1. Go to **Search** tab
2. Enter city name → Tap "Search"
3. Weather displayed with star icon
4. Tap **star** → Add to favorites
5. Star turns yellow
6. City appears in favorites list below

### **Select Home Screen City**
1. Search or go to favorites
2. **Tap city card** (not star)
3. Green checkmark appears
4. Switch to **Home** tab
5. Home shows selected city weather

### **Change Temperature Unit**
1. Go to **Settings** tab
2. Tap Celsius or Fahrenheit
3. All screens refresh with new unit
4. Preference saved

### **Sign Out**
1. Go to **Settings** tab
2. Tap "Sign Out"
3. Session cleared
4. Return to **AuthView**

---

## Known Behaviors

### **Session Persistence**
- Sessions persist in Keychain (managed by Supabase SDK)
- User stays signed in across app restarts
- No manual session storage needed

### **Weather Data Refresh**
- Home: Tap refresh button (↻) in navigation bar
- Search results refresh on each search
- Favorites reload on tab appearance
- All data refreshes on unit change

### **Favorites Loading**
1. Fetch favorites from Supabase
2. For each favorite, fetch current weather from OpenWeatherMap
3. Display weather cards
4. If weather fetch fails for a city, skip it (continue loading others)

### **City Selection**
- Only one city can be selected for home screen
- Selected city persists in UserDefaults
- Green checkmark shows current selection
- Haptic feedback on selection

---

## Important Notes

### **API Rate Limits**
- OpenWeatherMap free tier: 60 calls/minute
- Favorites weather loads sequentially to avoid rate limits

### **Row Level Security (RLS)**
- **Critical**: RLS must be enabled on favorites table
- Each user can only see their own data
- Enforced at database level (not app level)
- Prevents data leakage between users

### **Error Messages**
- All errors show user-friendly alerts
- Network errors handled gracefully
- "City not found" for invalid searches
- "User not authenticated" for favorites without login

### **Design Philosophy**
- Minimalist, clean UI
- Glass-morphic aesthetic throughout
- Consistent spacing and padding
- Natural, conversational tone
- Avoid over-engineering

---

## Environment

**Minimum iOS Version**: 15.0  
**Xcode Version**: 14.0+  
**Swift Version**: 5.5+  
**SwiftUI**: Yes  
**UIKit**: No (pure SwiftUI)

---

## Dependencies

### **Swift Package Manager**
1. **Supabase** (`https://github.com/supabase/supabase-swift`)
   - Auth client
   - Database client (PostgREST)
   - Automatic session management

### **System Frameworks**
- SwiftUI
- Foundation
- Combine (minimal usage)

---

## Console Debug Logs

The app includes extensive logging for debugging:

- 🔧 Initialization
- ✅ Success operations
- ❌ Errors
- 📥 Data fetching
- 🔄 Refreshing
- 🏠 Home screen operations
- ⭐️ Favorites operations
- 👤 User operations
- 🌡 Unit changes

**Example**:
```
🔧 Supabase client initialized
✅ Sign in successful
🏠 Home: Loading weather for Chennai
✅ Home: Weather loaded for Chennai
📥 Fetching favorites for user: [UUID]
✅ Fetched 3 favorites
```

---

## Common Issues & Solutions

### **"User not authenticated"**
- Session not found
- Sign out and sign in again
- Check Supabase credentials

### **"City not found"**
- Invalid city name
- Check spelling
- Try adding country (e.g., "Paris, FR")

### **Favorites not showing**
- Check console for weather fetch errors
- Verify RLS policies in Supabase
- Check network connection

### **Weather data not updating**
- Tap refresh button
- Check API key validity
- Verify internet connection

---

## Code Style Guidelines

- Use `async/await` for asynchronous operations
- Keep ViewModels `@MainActor`
- Use `@Published` for observable state
- Avoid force unwrapping (use optional binding)
- Use guard statements for early returns
- Add print logs for debugging
- Use meaningful variable names
- Group related code with `// MARK: -`

---

## Contact & Support

For issues or questions about GlassCast development, refer to:
- OpenWeatherMap API docs: [openweathermap.org/api](https://openweathermap.org/api)
- Supabase docs: [supabase.com/docs](https://supabase.com/docs)
- SwiftUI documentation: [developer.apple.com](https://developer.apple.com/documentation/swiftui)

---

**Last Updated**: January 2026  
**App Version**: 1.0.0  
**Status**: Active Development
