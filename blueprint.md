
# Blueprint: Sports Talent Recognition App

## Overview

This document outlines the plan for creating a multi-screen Flutter application for a sports talent recognition app. The app will feature a clean, modern design with a sports-themed color palette and will be built using the `google_fonts`, `provider`, and `go_router` packages.

## Features & Design

### Style and Design
- **Color Palette:**
    - **Primary:** Deep Blue
    - **Accent:** Vibrant Orange
    - **Secondary:** Energetic Green
- **Typography:** 'Poppins' font from `google_fonts`.
- **UI Components:** Modern, card-based layouts for interactive elements.

### Implemented Features
- **Profile Setup:** Collects initial user data including name, age, weight, height, city, state, and gender.
- **Main Dashboard:** A central hub to access different physical tests and the user's profile.
- **Test Screens:** Reusable screens that provide instructions and an option to upload a video for analysis.
- **Profile Management:** A screen to view and edit user information, and upload documents.

## Current Plan

### Step 1: Project Setup
- Add `google_fonts`, `provider`, and `go_router` to `pubspec.yaml`.
- Create a data model for the athlete's data and a `ChangeNotifier` to manage the state.

### Step 2: Theming and Routing
- Define the app's `ThemeData` in `lib/main.dart` using the specified color palette and font.
- Configure `go_router` for navigation between the four screens.

### Step 3: Screen Implementation
- Create the following screen files:
    - `lib/profile_setup_screen.dart`
    - `lib/main_screen.dart`
    - `lib/test_screen.dart`
    - `lib/profile_screen.dart`
- Implement the UI and functionality for each screen as per the requirements.

### Step 4: Main Application File
- Update `lib/main.dart` to initialize `go_router`, `ChangeNotifierProvider`, and set up the `MaterialApp.router`.
