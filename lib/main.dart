import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SightWordMatchApp());
}

class SightWordMatchApp extends StatelessWidget {
  const SightWordMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sight Word Match',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 131, 93, 247),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 250, 242),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}