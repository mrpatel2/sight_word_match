import 'package:flutter/material.dart';
import '../data/dolch_words.dart';
import 'word_match_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Color> _levelColors = [
    Color(0xFFFF6B6B), // Pre-Primer - red
    Color(0xFFFFA94D), // Primer - orange
    Color(0xFFFFD43B), // 1st Grade - yellow
    Color(0xFF69DB7C), // 2nd Grade - green
    Color(0xFF4DABF7), // 3rd Grade - blue
  ];

  @override
  Widget build(BuildContext context) {
    final levels = DolchWords.levels;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F0),
      appBar: AppBar(
        title: const Text(
          'Sight Word Match',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF845EF7),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: levels.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final level = levels[index];
              final color = _levelColors[index % _levelColors.length];
              return _LevelCard(
                level: level,
                color: color,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WordMatchScreen(level: level),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final String level;
  final Color color;
  final VoidCallback onTap;

  const _LevelCard({
    required this.level,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            level,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}