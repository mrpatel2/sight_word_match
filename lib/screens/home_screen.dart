import 'package:flutter/material.dart';
import '../data/dolch_words.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              return Container(
                height: 90,
                alignment: Alignment.center,
                color: Colors.grey[300],
                child: Text(
                  level,
                  style: const TextStyle(fontSize: 22),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}