# Sight Word Match

A single-player Flutter app that helps early readers (ages 4–8) practice Dolch sight words through a concentration style memory matching game.

This app is distinct from my Solo 3 app and from my team project.

## What It Does

The player picks a difficulty level (Pre-Primer, Primer, 1st Grade, 2nd Grade, or 3rd Grade), then plays "Word Match": a 3×4 grid of face-down cards. Tapping two cards flips them; matching pairs of identical sight words stay face-up, non-matches flip back after a short delay. Completing a round shows a score, and a Stats screen tracks score history over time: both per-round and as a combined average, and is persisted locally so progress isn't lost when the app closes.

## Game Implemented

- Word Match (concentration/memory grid), all five Dolch levels (Pre-Primer through 3rd Grade). The optional Dolch Nouns list was not included.

## Screens

- Home / Level Select — large, color-coded cards for each difficulty level
- Gameplay (Word Match) — the matching grid itself, with a live matches/attempts counter
- Results — shown after each completed round, with a score, encouraging message, and options to play again or return home
- Stats — combined score across all play, broken down by game and by level, with a friendly empty state before any rounds have been played

## How to Run It

1. Make sure Flutter is installed (running "flutter doctor" should show no blocking issues).
2. Clone this repository and move into it:

   git clone https://github.com/mrpatel2/sight_word_match
   cd sight_word_match

3. Install dependencies:

   flutter pub get

4. Run on a connected device or simulator:

   flutter run


No login, account, or internet connection is required — all data is stored locally on the device.

## Tradeoff Statements

1. I chose accuracy-based scoring (matches ÷ attempts × 100) over a time-based or raw-points score because Word Match doesn't have a natural "points" unit the way a quiz might, and accuracy is the one measure that's meaningful regardless of how long a round takes or how many cards are on the board. The cost of this approach is that it doesn't reward speed at all. A child who matches everything slowly and carefully scores identically to one who does it quickly, even though speed is also a sign of growing fluency. This will hold up until a future game type needs to be averaged into the same combined score, at which point accuracy and speed-based scores would need to be normalized onto the same 0–100 scale to stay comparable.

2. I chose to store score history as a flat list of individual round records (each tagged with game type, level, and timestamp) rather than pre-aggregating stats at save time, because it keeps all historical detail available for any future breakdown I might want (by level, by date, by game) without needing to rewrite how data is saved. The cost of this approach is that every stats calculation (combined score, per-game average, per-level average) has to be recomputed from scratch each time the Stats screen loads, rather than being instantly available from a running total. This will hold up until a player accumulates an extremely large number of rounds, at which point recomputing from the full history on every screen load could become noticeably slow and would need to move to incremental aggregation instead.

3. I chose 'shared_preferences' (a simple local key-value store) over a local database like 'sqflite' for persistence, because the app only needs to save and reload one JSON-encoded list of results, with no complex queries, relationships, or filtering at the storage layer.** The cost of this approach is that every read or write loads and re-encodes the entire history at once rather than querying just what's needed, and 'shared_preferences' isn't designed for large or relational datasets. This will hold up as long as score history stays in the range of hundreds of rounds, which is reasonable for a single child's sight-word practice. If the app ever needed multiple user profiles or much longer-term history, a real local database would be the better fit.