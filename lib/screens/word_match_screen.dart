import 'package:flutter/material.dart';
import '../data/dolch_words.dart';
import '../models/game_result.dart';
import '../services/score_storage_service.dart';

class WordMatchScreen extends StatefulWidget {
  final String level;

  const WordMatchScreen({super.key, required this.level});

  @override
  State<WordMatchScreen> createState() => _WordMatchScreenState();
}

class _WordCardData {
  final String word;
  bool isFaceUp = false;
  bool isMatched = false;

  _WordCardData({required this.word});
}

class _WordMatchScreenState extends State<WordMatchScreen> {
  late List<_WordCardData> _cards;
  final List<int> _flippedIndices = [];
  bool _isChecking = false;
  int _attempts = 0;
  int _matches = 0;
  bool _roundComplete = false;
  int _finalScore = 0;

  final ScoreStorageService _storageService = ScoreStorageService();

  @override
  void initState() {
    super.initState();
    _cards = _generateCards();
  }

  List<_WordCardData> _generateCards() {
    final allWords = List<String>.from(
      DolchWords.wordsByLevel[widget.level] ?? [],
    );
    allWords.shuffle();
    final selected = allWords.take(6).toList();
    final cardWords = [...selected, ...selected];
    cardWords.shuffle();
    return cardWords.map((w) => _WordCardData(word: w)).toList();
  }

  void _checkMatch() {
    _isChecking = true;
    _attempts++;

    final firstCard = _cards[_flippedIndices[0]];
    final secondCard = _cards[_flippedIndices[1]];

    if (firstCard.word == secondCard.word) {
      setState(() {
        firstCard.isMatched = true;
        secondCard.isMatched = true;
        _matches++;
        _flippedIndices.clear();
        _isChecking = false;
      });
      _checkRoundComplete();
    } else {
      Future.delayed(const Duration(milliseconds: 700), () {
        if (!mounted) return;
        setState(() {
          firstCard.isFaceUp = false;
          secondCard.isFaceUp = false;
          _flippedIndices.clear();
          _isChecking = false;
        });
      });
    }
  }

  void _checkRoundComplete() {
    final totalPairs = _cards.length ~/ 2;
    if (_matches == totalPairs) {
      final score = ((_matches / _attempts) * 100).round();
      setState(() {
        _roundComplete = true;
        _finalScore = score;
      });
      _saveResult(score);
    }
  }

  Future<void> _saveResult(int score) async {
    await _storageService.saveResult(
      GameResult(
        gameType: 'Word Match',
        level: widget.level,
        score: score,
        playedAt: DateTime.now(),
      ),
    );
  }

  void _playAgain() {
    setState(() {
      _cards = _generateCards();
      _flippedIndices.clear();
      _isChecking = false;
      _attempts = 0;
      _matches = 0;
      _roundComplete = false;
      _finalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Word Match: ${widget.level}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Matches: $_matches / ${_cards.length ~/ 2}   Attempts: $_attempts',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          if (_roundComplete)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Round complete! Score: $_finalScore',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _playAgain,
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: _cards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  return GestureDetector(
                    onTap: () {
                      if (_isChecking) return;
                      if (card.isMatched || card.isFaceUp) return;
                      if (_flippedIndices.length >= 2) return;

                      setState(() {
                        card.isFaceUp = true;
                        _flippedIndices.add(index);
                      });

                      if (_flippedIndices.length == 2) {
                        _checkMatch();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: card.isFaceUp
                            ? Colors.white
                            : const Color(0xFF845EF7),
                        border: Border.all(
                          color: const Color(0xFF845EF7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: card.isFaceUp
                          ? Text(
                              card.word,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF845EF7),
                              ),
                            )
                          : const Icon(
                              Icons.help_outline,
                              color: Colors.white,
                              size: 32,
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}