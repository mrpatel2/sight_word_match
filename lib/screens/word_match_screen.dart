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
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFF845EF7),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 32,
              ),
            );
          },
        ),
      ),
    );
  }
}