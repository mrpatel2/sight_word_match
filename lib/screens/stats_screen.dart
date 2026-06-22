import 'package:flutter/material.dart';
import '../models/game_result.dart';
import '../services/score_storage_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final ScoreStorageService _storageService = ScoreStorageService();
  late Future<List<GameResult>> _resultsFuture;

  @override
  void initState() {
    super.initState();
    _resultsFuture = _storageService.getAllResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Stats')),
      body: FutureBuilder<List<GameResult>>(
        future: _resultsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final results = snapshot.data ?? [];

          if (results.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'No games played yet!\nGo play a round to see your stats here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          }

          return Center(
            child: Text(
              'Total rounds played: ${results.length}',
              style: const TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}