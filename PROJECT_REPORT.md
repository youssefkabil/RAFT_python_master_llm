# Project Report: Your Personal Python Tutor

## 1. Project Overview
**Name:** Anti-Gravity Tutor
**Purpose:** An intelligent, real-time chat application designed to assist users with Python programming. It leverages a modern "Glassy UI" for an immersive experience and integrates with an advanced AI backend to provide instant, context-aware coding help.

## 2. Technical Stack
The application is built using **Flutter**, ensuring cross-platform compatibility (Android, iOS, Windows, Web, Linux, MacOS).

### Key Technologies:
- **State Management:** `flutter_riverpod` (v3.0.3) - For robust, scalable, and testable state management.
- **Networking:** `dio` (v5.9.0) - For handling HTTP requests to the AI backend with support for interceptors and global configuration.
- **Typography:** `google_fonts` (v6.3.3) - Utilizing the 'Inter' and 'Orbitron' font families for a modern aesthetic.
- **Markdown Rendering:** `flutter_markdown` (v0.7.7+1) - To correctly render code blocks and formatted text from the AI responses.
- **Reactive Programming:** Uses Riverpod's reactive features for real-time UI updates.

## 3. Project Structure
The project follows a **Feature-First** architecture for better scalability and maintainability.

### File Tree
```
lib/
├── core/
│   ├── services/
│   │   └── api_service.dart       # Handles external API communications
│   └── widgets/
│       └── glass_container.dart   # Reusable "Glassmorphism" UI component
├── features/
│   └── chat/
│       ├── models/
│       │   └── message.dart       # Data model for chat messages
│       ├── presentation/
│       │   ├── chat_bubble.dart   # UI widget for individual message bubbles
│       │   └── chat_screen.dart   # Main screen containing the chat interface
│       └── provider/
│           ├── chat_provider.dart # Logic and state management for chat
│           └── chat_provider.g.dart # Generated code for Riverpod
└── main.dart                      # Application entry point
```

## 4. Dependencies
Defined in `pubspec.yaml`:

### Production Dependencies
| Package | Version | Purpose |
| :--- | :--- | :--- |
| **flutter** | sdk | Core Flutter SDK |
| **cupertino_icons** | ^1.0.8 | iOS-style icons |
| **flutter_riverpod** | ^3.0.3 | State management library |
| **riverpod_annotation**| ^3.0.3 | Annotations for code generation |
| **dio** | ^5.9.0 | Powerful HTTP client for Dart |
| **flutter_markdown** | ^0.7.7+1 | Renders Markdown content (essential for code) |
| **google_fonts** | ^6.3.3 | custom web fonts |
| **http** | ^1.6.0 | Basic HTTP requests (fallback/utility) |

### Dev Dependencies
| Package | Version | Purpose |
| :--- | :--- | :--- |
| **flutter_test** | sdk | Testing framework |
| **flutter_lints** | ^5.0.0 | Linter rules for Dart/Flutter |
| **build_runner** | ^2.7.1 | Tool to run code generation |
| **riverpod_generator** | ^3.0.3 | Generates Riverpod providers |

## 5. Key Components Description

### **AntiGravityApp (`main.dart`)**
The root widget that sets up the `MaterialApp`, applies the dark theme with `GoogleFonts.inter`, and strictly scopes the `ProviderScope` for state management.

### **ChatScreen (`features/chat/presentation/chat_screen.dart`)**
The primary interface. It features:
- A custom gradient background.
- `GlassContainer` input area.
- Auto-scrolling list view for messages.
- Real-time interaction with the `ChatProvider`.

### **ChatProvider (`features/chat/provider/chat_provider.dart`)**
Manages the list of messages. It handles sending user messages, calling the API service, and updating the state with the AI's response.
