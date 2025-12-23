
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kabil_jedraoui/features/chat/presentation/chat_screen.dart';

void main() {
  runApp(const ProviderScope(child: AntiGravityApp()));
}

class AntiGravityApp extends StatelessWidget {
  const AntiGravityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anti-Gravity Tutor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F2027),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const ChatScreen(),
    );
  }
}
