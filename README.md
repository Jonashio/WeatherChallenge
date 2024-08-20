# WeatherChallenge

A universal iOS application (iPhone) providing a 5-day weather forecast for Paris, featuring both a summary and a detailed view for each day. This project showcases modern SwiftUI techniques and architectural best practices.

[![License](https://img.shields.io/github/license/Jonashio/WeatherChallenge)](https://img.shields.io/github/license/Jonashio/WeatherChallenge) [![Compatibility](https://img.shields.io/badge/Platform%20Compatibility-iOS-red)](https://img.shields.io/badge/Platform%20Compatibility-iOS-red) [![Language](https://img.shields.io/badge/Language-SwiftUI-yellow)](https://img.shields.io/badge/Language-SwiftUI-yellow)

## Table of Contents

- [Demo](#demo)
- [Features](#features)
- [Architecture](#architecture)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Important Notes](#important-notes)
- [Dependencies](#dependencies)
- [Author](#author)

## Demo

![Example1](_Gifs/demo.gif)

## Features

- **5-Day Weather Forecast**: Provides a detailed forecast for the next 5 days in Paris.
- **Summary and Detailed Views**: Easily switch between a high-level summary and detailed weather information for each day.
- **Universal iOS Support**: Fully optimized for both iPhone and iPad devices.
- **Interactive UI**: Smooth animations and transitions using SwiftUI.

## Architecture

The project follows the MVVM (Model-View-ViewModel) architectural pattern. The architecture is enriched with additional layers to enhance code organization and maintainability.

- **Model**: Defines the data structures and handles business logic.
- **View**: Comprises SwiftUI views that represent the UI layer.
- **ViewModel**: Bridges the Model and View, handling data manipulation and business logic while maintaining the state.
- **Networking Layer**: Responsible for API communication.
- **Persistence Layer**: Manages local data storage using SwiftData.

## Technologies Used

- **SwiftUI**: For building the user interface.
- **SwiftData**: For data persistence.
- **Async/Await**: Used for asynchronous operations as an alternative to Combine.
- **Kingfisher**: For downloading and caching images.
- **SnapshotTesting**: For creating and verifying UI snapshots in tests.

## Installation

To run the project locally, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/Jonashio/WeatherChallenge.git
    ```
2. Open the project in Xcode:
    ```bash
    cd WeatherChallenge
    open WeatherChallenge.xcodeproj
    ```
3. Install dependencies:
    - If using CocoaPods:
        ```bash
        pod install
        ```
4. Build and run the project in Xcode.

## Important Notes

- **Persistence**: SwiftData has been utilized for data persistence, ensuring a smooth and responsive experience.
- **Async Operations**: The project leverages async/await for asynchronous operations, replacing Combine for a more modern approach.
- **UI Framework**: All views are created using SwiftUI, embracing declarative UI principles.
- **Architecture**: The MVVM architecture is adopted, supplemented with additional layers for enhanced code organization and maintainability.
- **Testing**: The project includes basic testing, but test coverage is limited as this is primarily a demonstration of knowledge and skills.

## Dependencies

- [**Kingfisher**](https://github.com/onevcat/Kingfisher): For efficient image downloading and caching.
- [**SnapshotTesting**](https://github.com/pointfreeco/swift-snapshot-testing): For UI snapshot testing.

## Author

* [**Jonashio**](https://github.com/Jonashio)
