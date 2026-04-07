<div align="center">

# PsicApp

**Mobile platform for scheduling psychology appointments**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7.2+-0175C2?style=flat-square&logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

</div>

---

## About

**PsicApp** is a Flutter mobile application that connects **patients** with **psychologists**, streamlining the mental health triage process, professional discovery, and appointment scheduling.

The app provides distinct flows for each user role — patients can complete an initial mental health assessment, search for psychologists by specialty, and book sessions; psychologists manage their schedule and track linked patients.

---

## Features

### For Patients
- Mental health triage (emotional state, anxiety level, difficulties description)
- Search and filter psychologists by specialty
- Appointment booking with available time slot selection
- Appointment history and tracking

### For Psychologists
- Professional profile management with specialty
- Appointments agenda/calendar view
- Linked patient tracking
- Available time slot management

### General
- Phone number authentication (SMS) and Google Sign-In
- Role selection during registration (Patient or Psychologist)
- Profile photo upload
- Geolocation and map services
- Network connectivity detection
- Responsive interface for Android, iOS, and Web

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| Language | Dart 3.7.2+ |
| Authentication | Firebase Auth (Phone + Google) |
| Database | Cloud Firestore |
| Storage | Firebase Storage |
| State Management | GetX |
| Geolocation | Geolocator + Flutter Map |
| HTTP | http |
| Architecture | Clean Architecture (Domain / Data / Presentation) |

---

## Architecture

The project follows **Clean Architecture** principles with a clear three-layer separation:

```
lib/
└── app/
    ├── core/           # Utilities, theme, constants, extensions
    ├── data/           # Repositories, datasources (Firestore), services
    ├── domain/         # Domain models (business entities)
    └── presentation/   # UI, controllers (GetX), routes, and bindings
```

**Design patterns used:**
- Repository Pattern for data access abstraction
- Service Locator with GetX for dependency injection
- GetPages + Bindings for route-scoped dependency management
- Reactive State with GetX `Rx` variables

---

## Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- [Dart SDK](https://dart.dev/get-dart) 3.7.2+
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with the Flutter extension
- A project configured in the [Firebase Console](https://console.firebase.google.com/)
- For iOS: macOS with Xcode installed

---

## Installation & Setup

### 1. Clone the repository

```bash
git clone https://github.com/your-username/psic_app.git
cd psic_app
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

This project uses Firebase as its backend. You need to set up your own Firebase project and add the configuration files:

**Android:**
1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a project
2. Add an Android app with the project's package name
3. Download `google-services.json`
4. Place it at `android/app/google-services.json`

**iOS:**
1. Add an iOS app to the same Firebase project
2. Download `GoogleService-Info.plist`
3. Place it at `ios/Runner/GoogleService-Info.plist`

**Required Firebase services:**
- Authentication — enable providers: **Phone** and **Google**
- Cloud Firestore — create the database
- Firebase Storage — enable storage

### 4. Run the project

```bash
# Check Flutter environment
flutter doctor

# Run in debug mode
flutter run

# Run on a specific platform
flutter run -d android
flutter run -d ios
flutter run -d chrome   # Web
```

---

## Production Build

```bash
# Android (APK)
flutter build apk --release

# Android (App Bundle — recommended for Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

---

## Folder Structure

```
psic_app/
├── lib/
│   ├── main.dart
│   └── app/
│       ├── core/
│       │   ├── constants/       # App enums and constants
│       │   ├── extensions/      # Extension methods
│       │   ├── theme/           # Color palette
│       │   └── utils/           # Validators, formatters, utilities
│       │
│       ├── data/
│       │   ├── datasources/     # Firestore setup and collection references
│       │   ├── repositories/    # Data access layer (9 repositories)
│       │   └── services/        # Geolocation, image upload, connectivity
│       │
│       ├── domain/
│       │   └── models/          # Business entities (AppUser, Patient, Psychologist, Schedule...)
│       │
│       └── presentation/
│           ├── modules/         # Feature modules (auth, home, patient, schedule, agenda...)
│           ├── routes/          # Route definitions and pages
│           └── shared/          # Shared controllers, components, and handlers
│
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
├── assets/
│   └── images/
├── test/
├── pubspec.yaml
└── README.md
```

---

## Core Domain Models

| Model | Description |
|---|---|
| `AppUser` | Base user profile with role (patient/psychologist) and onboarding step |
| `Patient` | Patient-specific data |
| `Psychologist` | Psychologist data with specialty field |
| `Schedule` | Booked appointment with status (`requested`, `scheduled`, `cancelled`) |
| `TimeSlot` | Available appointment time slots |
| `Follower` | Patient-psychologist relationship tracking |

---

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m 'feat: add my feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

<div align="center">
  Developed by <strong>Luiz Pozza</strong>
</div>
