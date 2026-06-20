import 'package:flutter/material.dart';

class WordMatchScreen extends StatelessWidget {
  final String level;

  const WordMatchScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Word Match: $level')),
      body: const Center(
        child: Text(
          'Game coming soon!',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}