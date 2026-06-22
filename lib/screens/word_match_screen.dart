import 'package:flutter/material.dart';
import '../data/dolch_words.dart';

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

  List<int> _flippedIndices = [];
  bool _isChecking = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Word Match: ${widget.level}')),
      body: Padding(
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
              },
              child: Container(
                decoration: BoxDecoration(
                  color: card.isFaceUp ? Colors.white : const Color(0xFF845EF7),
                  border: Border.all(color: const Color(0xFF845EF7), width: 2),
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
    );
  }
}