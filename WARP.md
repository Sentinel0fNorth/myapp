# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a Flutter application for sports talent recognition. It's a multi-screen app that allows athletes to create profiles and perform physical tests (Sit & Reach Test, Sit-ups Test) with video recording capabilities.

## Common Development Commands

### Essential Flutter Commands
```powershell
# Get dependencies
flutter pub get

# Run the app (with hot reload)
flutter run

# Run on web specifically
flutter run -d chrome

# Build for Android
flutter build apk

# Build for web
flutter build web

# Run tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Code analysis
flutter analyze

# Format code
dart format .

# Apply available fixes
flutter fix --apply
```

### Package Management
```powershell
# Add a new dependency
flutter pub add package_name

# Add a development dependency
flutter pub add dev:package_name

# Update dependencies
flutter pub upgrade
```

## Architecture Overview

### State Management Architecture
- **State Management**: Uses `provider` package with `ChangeNotifier` pattern
- **Main State Class**: `AthleteData` in `lib/athlete_data.dart` manages all athlete profile data
- **Provider Setup**: App wrapped with `ChangeNotifierProvider` in `main.dart`

### Navigation Architecture  
- **Router**: Uses `go_router` for declarative navigation
- **Routes**:
  - `/` - Profile setup (entry point)
  - `/main` - Main dashboard with tabbed interface (Tests & History)
  - `/test/:testName` - Dynamic test screens with parameter
  - `/profile` - Profile management screen with back navigation
  - `/results` - Standalone test results display (deprecated in favor of History tab)

### UI Architecture
- **Design System**: Material Design 3 with custom color scheme
- **Typography**: Poppins font via `google_fonts` package
- **Color Palette**:
  - Primary: Deep Blue (`Color(0xFF0D47A1)`)
  - Secondary: Energetic Green (`Color(0xFF00C853)`)
  - Accent: Vibrant Orange (`Color(0xFFFF6D00)`)

### Project Structure
```
lib/
├── main.dart                    # App entry point, routing, theming
├── athlete_data.dart            # State management model
├── test_result.dart            # Test result data model
├── profile_setup_screen.dart    # Initial profile creation
├── main_screen.dart            # Tabbed dashboard (Tests & History tabs)
├── test_screen.dart            # Reusable test instruction screen  
├── test_results_screen.dart    # Historical test results display
└── profile_screen.dart         # Profile viewing/editing
```

## Key Dependencies

- **flutter**: Core Flutter SDK
- **provider**: State management and dependency injection
- **go_router**: Declarative routing and navigation
- **google_fonts**: Poppins typography
- **video_player**: Video playback for instruction videos
- **cupertino_icons**: iOS-style icons

## Development Workflow

### Adding New Features
1. Consider if new state is needed in `AthleteData`
2. Add any new routes to `_router` in `main.dart`
3. Follow existing Material 3 theming patterns
4. Use `Provider.of<AthleteData>` to access state
5. Use `context.go()` for navigation

### Testing Strategy
- Widget tests in `test/` directory
- Uses standard Flutter testing framework
- Current test: `test/widget_test.dart`

### Code Quality
- Linting enabled via `package:flutter_lints/flutter.yaml`
- Analysis options in `analysis_options.yaml`
- Follows Flutter/Dart conventions

## Firebase Studio Context

This project appears configured for Firebase Studio development environment based on the `.idx/` directory and `GEMINI.md` guidelines. Key points from GEMINI.md:

### Error Detection & Remediation
- Code automatically monitored for compilation errors
- Hot reload enabled for rapid development  
- Preview server provides real-time feedback

### Material Design Implementation
- Uses Material 3 with `ColorScheme.fromSeed` pattern
- Custom theming for AppBar, ElevatedButton, Card components
- Implements proper spacing and typography hierarchy

### State Management Best Practices
- Uses `ChangeNotifier` for complex app state
- Provider pattern for dependency injection
- Unidirectional data flow from state to UI

## Special Considerations

### Gender Selection
- Uses `SegmentedButton<Gender>` with custom enum
- Modern Material 3 component for binary choices

### Form Validation
- Comprehensive form validation in profile setup
- Uses Flutter's built-in `Form` and `TextFormField` validation

### Video Functionality
- **Instruction Videos**: Full video player integration for test instructions
- **Smart Video Loading**: Different videos per test type (Vertical Jump, Sit-ups)
- **Video Controls**: Play/pause, progress scrubbing, time display
- **Fallback UI**: Graceful handling when video files are missing
- **File Paths**:
  - Vertical Jump: `assets/videos/vertical_jump_instructions.mp4`
  - Sit-ups: `assets/videos/situps_instructions.mp4`
  - Default: `assets/videos/default_instructions.mp4`
- **Recording**: "Record" button for athlete performance capture
- Uses `video_player` package for robust video playback

### Tabbed Interface
- Main screen divided into two tabs: Tests and History
- Uses `TabController` with `SingleTickerProviderStateMixin`
- **Tests Tab**: Available test selection (Vertical Jump, Sit-ups)
- **History Tab**: Historical test results in card-based layout
- Tab styling matches app's Material 3 theme with appropriate icons

### Test Results Display
- Historical test results shown in card-based layout
- Uses `TestResult` data model with performance metrics
- **Vertical Jump**: Displays jump height in cm and form score
- **Sit-ups**: Displays number of reps in 1 minute and form score
- Shows athlete name (email removed for cleaner UI)
- Confidence ratings and submission timestamps
- Dynamically uses logged-in user's name from `AthleteData`
- Available both in History tab and standalone results screen

### Navigation Enhancements
- **Back Button Integration**: Test screens include back navigation to main screen
- **Consistent Navigation Flow**: Profile screen has back button to main dashboard
- **Simplified UI**: "Upload" button (simplified from "Record or Upload Video")
- **User-Friendly Experience**: Easy navigation between all screens

### Platform Support
- Configured for web and Android platforms
- Web assets in `web/` directory
- Android configuration in `android/` directory
