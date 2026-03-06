# Kigali Services

A modern Flutter application that helps residents and visitors of Kigali, Rwanda discover and share local services. Find hospitals, police stations, restaurants, cafes, parks, libraries, and tourist attractions with an intuitive map interface and community-driven listings.

##  Features

- ** Secure Authentication**: Firebase-powered user authentication with email verification
- ** Interactive Map**: OpenStreetMap-powered map view with location markers
- ** Service Directory**: Browse categorized local services and businesses
- ** Personal Listings**: Create and manage your own service listings
- ** Modern UI**: Clean, accessible design with dark/light theme support
- ** Cross-Platform**: Built with Flutter for iOS, Android, Web, and Desktop
- ** Real-time Updates**: Live data synchronization with Firebase Firestore

##  Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Firebase project with Authentication and Firestore enabled
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/kigali_services.git
   cd kigali_services
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication (Email/Password) and Firestore
   - Download `google-services.json` and place it in `android/app/`
   - Update `lib/firebase_options.dart` with your Firebase config

4. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

```bash
# Android APK
flutter build apk --release

# iOS (on macOS)
flutter build ios --release

# Web
flutter build web --release
```

##  Usage

### For Users
1. **Sign Up**: Create an account with email verification
2. **Browse Directory**: Explore local services by category
3. **View on Map**: Interactive map with location markers
4. **Add Listings**: Share services you've discovered
5. **Manage Your Listings**: Edit or delete your contributions

### For Developers
- **State Management**: Provider pattern for clean architecture
- **Theming**: Centralized color system in `AppColors`
- **Navigation**: Custom page transitions with fade effects
- **Error Handling**: User-friendly error messages and loading states

##  Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **Backend**: Firebase (Auth + Firestore)
- **Maps**: Flutter Map with OpenStreetMap
- **State Management**: Provider
- **UI**: Material Design 3 with Google Fonts
- **Location**: Geolocator for GPS services

##  Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/
│   └── listing_model.dart    # Service listing data model
├── providers/
│   ├── auth_provider.dart    # Authentication state
│   └── listing_provider.dart # Listings state
├── services/
│   ├── auth_service.dart     # Firebase auth operations
│   └── listing_service.dart  # Firestore operations
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── main_screen.dart      # Bottom navigation container
│   ├── directory/
│   │   ├── directory_screen.dart
│   │   └── listing_detail_screen.dart
│   ├── my_listings/
│   │   └── add_edit_listing_screen.dart
│   ├── map/
│   │   └── map_screen.dart
│   └── settings/
│       └── settings_screen.dart
└── theme/
    └── app_theme.dart        # Colors and typography
```



### Development Guidelines
- Follow Flutter best practices
- Use Provider for state management
- Maintain consistent code formatting
- Add tests for new features
- Update documentation


