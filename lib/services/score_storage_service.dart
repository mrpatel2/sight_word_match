import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_result.dart';

// Handles saving and loading game results to local device storage
class ScoreStorageService {
  static const String _storageKey = 'game_results';

  // Save a new result and adding it to the existing history
  Future<void> saveResult(GameResult result) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await getAllResults();
    existing.add(result);

    final jsonList = existing.map((r) => r.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }

  // Load every saved result with oldest first
  Future<List<GameResult>> getAllResults() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw == null || raw.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => GameResult.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // Results
  Future<List<GameResult>> getResultsForGame(String gameType) async {
    final all = await getAllResults();
    return all.where((r) => r.gameType == gameType).toList();
  }

  // The combined score across ALL games and rounds ever played
  // Returns null if nothing has been played yet which is the empty state
  Future<double?> getCombinedScore() async {
    final all = await getAllResults();
    if (all.isEmpty) return null;

    final total = all.fold<int>(0, (sum, r) => sum + r.score);
    return total / all.length;
  }
}