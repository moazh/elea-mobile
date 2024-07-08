# elea_mobile

## Introduction
**elea_mobile** is a minimal Flutter application designed to provide a simple yet effective audio recording and transcription service. Users can record audio, play back their recordings, and view a transcription of the spoken text directly within the application.

## Architectural Overview:
Adopting BLoC and Clean Architecture principles including:
- **Common Layer**: Houses utilities, and shared functionalities that are leveraged across the application.
- **Data Layer**: Responsible for data handling, such as network requests, and data caching.
- **Domain Layer**: Contains the core business logic of the application.
- **Presentation Layer**: Encompasses both the UI and functionality.

## Features
- **Audio Recording**: Capture audio using your mobile device's microphone.
- **Playback Functionality**: Listen to your recordings directly within the app.
- **Transcription**: Automatically transcribe spoken text from your recordings and display it in the user interface.

## Prerequisites
Before you can run **elea_mobile**, ensure you have the following installed:
- Flutter (latest version recommended)
- Dart SDK
- An IDE that supports Flutter development (e.g., Android Studio, VS Code)

##### Important Note
This application requires the use of the OpenAI Whisper-1 model for transcription. An API token is needed to access this service. Please ensure you have a valid OpenAI API token, which you can obtain from the OpenAI website. Insert your token in the specified location within the API class of this application.
## Installation
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/moazh/elea_mobile.git
2. Navigate to the project directory:
   ```bash
   cd elea_mobile
3. Install the required dependencies:
   ```bash
   flutter pub get
4. Run the application:
   ```bash
   flutter run
## Dependencies
- **flutter_bloc**: A predictable state management library that helps implement the BLoC design pattern.
- **bloc_concurrency**: Provides customizable concurrent event processing for Bloc instances.
- **audio_waveforms**: A Flutter plugin for displaying audio waveforms, allowing users to visually interact with audio streams.
- **permission_handler**: Manages and requests permissions.
- **get_it**: A simple service locator for dependency injection.
- **shared_preferences**: Provides a persistent store for simple data.
- **equatable**: Simplifies equality comparisons between objects.
- **intl**: Facilitates internationalization and localization processes, allowing for easy formatting and parsing of dates, numbers, and strings.
- **stream_transform**: Offers a collection of Stream transformers to efficiently manipulate data streams.
- **dio**: A robust HTTP client for Dart, optimized for making API requests.
