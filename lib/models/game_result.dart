//the result of a single completed round of any game.
class GameResult {
  final String gameType; 
  final String level;    // like "Pre-Primer"
  final int score;       // from 1-100
  final DateTime playedAt;

  GameResult({
    required this.gameType,
    required this.level,
    required this.score,
    required this.playedAt,
  });

  Map<String, dynamic> toJson() => {
        'gameType': gameType,
        'level': level,
        'score': score,
        'playedAt': playedAt.toIso8601String(),
      };

  factory GameResult.fromJson(Map<String, dynamic> json) => GameResult(
        gameType: json['gameType'] as String,
        level: json['level'] as String,
        score: json['score'] as int,
        playedAt: DateTime.parse(json['playedAt'] as String),
      );
}