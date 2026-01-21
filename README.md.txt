🌤️ GlassCast
A beautiful, modern weather app for iOS with a stunning glass-morphic design. Stay informed about the weather in your favorite cities with real-time data and elegant animations.

✨ Features
🏠 Home Screen
Real-time weather for your selected city
Current temperature, conditions, and weather description
High and low temperature display
Beautiful 5-day forecast with horizontal scroll
Animated weather icons
Pull-to-refresh functionality

🔍 Search & Favorites
Search for any city worldwide
Save unlimited favorite cities
Tap any city card to set as home screen display
Visual indicators for selected city
Persistent favorites with cloud sync

⚙️ Settings
Toggle between Celsius and Fahrenheit
Instant temperature unit conversion
Sign out functionality
Clean, minimal interface

🎨 Design
Liquid glass morphism throughout
Translucent blur effects
Smooth gradient backgrounds
Adaptive layouts for iPhone and iPad
Consistent design language
Dark mode optimized

🔐 Authentication
Secure email/password authentication
Password reset capability
Persistent sessions
Automatic sign-in on app launch

🛠️ Technologies
SwiftUI - Modern declarative UI framework
MVVM Architecture - Clean separation of concerns
Async/Await - Modern concurrency for network calls
Supabase - Backend as a service for auth and database
OpenWeatherMap API - Real-time weather data
Row Level Security - Database-level user data protection
📖 Usage
First Launch
Sign up with email and password
Verify your email (check spam folder)
Sign in to access the app

Adding Favorites
Go to the Search tab
Enter a city name
Tap the star icon to add to favorites
City appears in your favorites list

Setting Home Screen City
Search for a city or go to favorites
Tap on the city card (not the star)
Green checkmark indicates selected city
Switch to Home tab to see the weather

Changing Temperature Unit
Go to Settings tab
Tap Celsius or Fahrenheit
All screens update automatically

🏗️ Architecture
GlassCast follows the MVVM (Model-View-ViewModel) architecture pattern:

Views - SwiftUI views that display the UI
ViewModels - Manage business logic and state
Models - Data structures for API responses and database
Managers - Handle external services (API, Database, Storage)

Key Components
APIManager - Centralized network layer with async/await
SupabaseManager - Authentication and database operations
UserDefaultsManager - Local settings persistence
AppError - Global error handling

🔒 Security
Row Level Security (RLS) enabled on all database tables
Users can only access their own data
Secure session management with Supabase
API keys stored in code 
