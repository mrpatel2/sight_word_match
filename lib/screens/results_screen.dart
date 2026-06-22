import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String level;
  final int score;

  const ResultsScreen({
    super.key,
    required this.level,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F0),
      body: Center(
        child: Text(
          'Score: $score ($level)',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}