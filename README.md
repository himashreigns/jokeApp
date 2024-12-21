
# Joke App

Welcome to the Joke App, a Flutter application designed to fetch and display the top 5 jokes with an engaging and modern UI.

# Features

Fetches jokes from a joke API.
Displays jokes in a user-friendly card layout.
Caches jokes for offline access.
Attractive UI with gradient backgrounds and modern typography.

# Getting Started

Follow these steps to set up and run the project on your local machine.

# Prerequisites

Flutter SDK (Version: 3.5.1 or later)
Android Studio or VS Code (with Flutter and Dart plugins installed).
Kotlin version: 1.9.0 (or compatible)

# Installation

## Clone the Repository

git clone https://github.com/himashreigns/jokeApp.git

cd joke_app

## Install Dependencies
Run the following command to install the required dependencies:

flutter pub get

## Run the Application
Connect an emulator or physical device and run:

flutter run

# Note

If you encounter a Kotlin compatibility issue, ensure that the Kotlin version is updated in the android/build.gradle file:
ext.kotlin_version = '1.9.0'

# Project Structure

lib/
|-- main.dart                # Main entry point of the application
|-- joke_service.dart        # Handles fetching and caching jokes
|-- joke.dart                # Data model for a joke

# Dependencies

Flutter: The core framework for building the app.
http: For making API requests.
shared_preferences: For caching jokes locally.
google_fonts: For modern typography.

Add these dependencies in the pubspec.yaml file:

dependencies:
flutter:
sdk: flutter
http: ^1.1.2
shared_preferences: ^2.0.9
google_fonts: ^4.0.3

# API Integration

The app fetches jokes using the JokeService class. Update the joke_service.dart file to specify the API endpoint or logic for fetching jokes.

# Customization

Change Themes or Fonts
Modify the ThemeData in the main.dart file.

Modify Joke Limit
Change the number of jokes displayed by editing the _loadJokes() method in main.dart:

jokes = newJokes.take(5).toList();

# Contributing

Contributions are welcome! If you have suggestions or find issues, feel free to create a pull request or open an issue in the repository.


Author

Himash Ruwanga
Email: himashreigns@gmail.com
=======
# jokeApp

