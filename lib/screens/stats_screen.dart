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

          final byGame = <String, List<GameResult>>{};
          for (final r in results) {
            byGame.putIfAbsent(r.gameType, () => []).add(r);
          }

          final totalRounds = results.length;
          final combinedScore =
              results.fold<int>(0, (sum, r) => sum + r.score) / totalRounds;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF845EF7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Combined Score',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        combinedScore.round().toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$totalRounds rounds played',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'By Game',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...byGame.entries.map((entry) {
                  final gameResults = entry.value;
                  final gameAverage =
                      gameResults.fold<int>(0, (sum, r) => sum + r.score) /
                          gameResults.length;

                  final byLevel = <String, List<GameResult>>{};
                  for (final r in gameResults) {
                    byLevel.putIfAbsent(r.level, () => []).add(r);
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('${gameResults.length} rounds played'),
                              ],
                            ),
                            Text(
                              gameAverage.round().toString(),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF845EF7),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        ...byLevel.entries.map((levelEntry) {
                          final levelResults = levelEntry.value;
                          final levelAverage = levelResults.fold<int>(
                                0,
                                (sum, r) => sum + r.score,
                              ) /
                              levelResults.length;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(levelEntry.key),
                                Text('${levelAverage.round()}'),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}