import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String level;
  final int score;

  const ResultsScreen({
    super.key,
    required this.level,
    required this.score,
  });

  String _emojiForScore(int score) {
    if (score >= 90) return '🌟';
    if (score >= 70) return '👍';
    return '💪';
  }

  String _messageForScore(int score) {
    if (score >= 90) return 'Excellent!';
    if (score >= 70) return 'Good job!';
    return 'Keep practicing!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F0),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _emojiForScore(score),
                  style: const TextStyle(fontSize: 64),
                ),
                const SizedBox(height: 16),
                Text(
                  _messageForScore(score),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Text(
                  '$score',
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF845EF7),
                  ),
                ),
                Text(
                  level,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}