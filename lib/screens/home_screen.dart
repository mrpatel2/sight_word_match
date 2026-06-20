import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 242),
      appBar: AppBar(
        title: const Text(
          'Sight Word Match',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 132, 94, 248),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Pick a level to play!'),
      ),
    );
  }
}