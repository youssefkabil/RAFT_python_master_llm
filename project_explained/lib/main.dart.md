# File: `lib/main.dart`

This file is the entry point of the Flutter application. It sets up the root widget tree, initializes state management, and defines the global theme.

### 1. Imports
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kabil_jedraoui/features/chat/presentation/chat_screen.dart';
```
**Explanation:**
- `package:flutter/material.dart`: Imports the Material Design library which provides standard UI components.
- `package:flutter_riverpod/flutter_riverpod.dart`: Imports Riverpod for state management. This is essential for the `ProviderScope`.
- `package:google_fonts/google_fonts.dart`: Allows us to use custom fonts like 'Inter' easily.
- `chat_screen.dart`: Imports the main screen of our app so we can set it as the `home`.

### 2. Main Function
```dart
void main() {
  runApp(const ProviderScope(child: AntiGravityApp()));
}
```
**Explanation:**
- `main()`: The starting point of every Dart program.
- `runApp()`: Inflates the given widget and attaches it to the screen.
- `ProviderScope`: This is **critical** for Riverpod. It stores the state of all providers. Without wrapping the app in this, Riverpod will not work.

### 3. Application Root Widget
```dart
class AntiGravityApp extends StatelessWidget {
  const AntiGravityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anti-Gravity Tutor',
      debugShowCheckedModeBanner: false,
      // ... Theme configuration
      home: const ChatScreen(),
    );
  }
}
```
**Explanation:**
- `AntiGravityApp`: A `StatelessWidget` representing the root of our app.
- `MaterialApp`: The top-level container for a Material Design app. It handles routing, theming, and title.
- `title`: The name of the app seen in the task switcher.
- `debugShowCheckedModeBanner`: Set to `false` to remove the "Debug" banner from the top-right corner.
- `home`: Sets `ChatScreen` as the first screen the user sees.

### 4. Theme Configuration
```dart
theme: ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF0F2027),
  textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
),
```
**Explanation:**
- `ThemeData.dark()`: Starts with a default dark theme.
- `scaffoldBackgroundColor`: Sets the background color of the app to a specific dark blue/teal (`#0F2027`).
- `textTheme`: Applies the 'Inter' font family globally to all text in the app.
- `colorScheme`: Generates a cohesive set of colors based on a "seed" color (`Colors.deepPurple`), ensuring the app looks consistent and premium.
