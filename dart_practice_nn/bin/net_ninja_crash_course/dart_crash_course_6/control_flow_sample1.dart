//------------------------------------------------------------------------------
// C O N T R O L  F L O W  —  S A M P L E  1:  F O R  L O O P S
//------------------------------------------------------------------------------
//
// This sample covers all the different ways to use FOR loops in Dart.
// For loops are the most common way to iterate through collections.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                        | KEYWORDS USED          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | for-in loop with .where()    | for, in, .where()      | Filter items before looping
//  2  | if / else inside a loop      | for, in, if, else      | Categorize items while iterating
//  3  | for-in loop (forEach style)  | for, in                | Loop through every item without needing an index
//  4  | Standard for loop with index | for, i++, .length      | When you need the position, not just the value
// -----------------------------------------------------------------------
//
// TIP: Use for-in when you just need the values.
//      Use a standard for loop when you need the INDEX (position).
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. FOR-IN LOOP WITH .where() — Filter items before looping
  //    .where() returns an Iterable of elements that pass the
  //    condition. Only those elements enter the for-in body.
  //
  //    Think of it like a bouncer at a club:
  //    .where() checks the guest list → only approved guests
  //    (elements that pass the test) get inside the loop.
  //
  //    This is MORE EFFICIENT than looping through everything
  //    and using if/else inside, because the filtering happens
  //    BEFORE the loop starts.
  // ============================================================
  print('');
  print('##############################################');
  print('# SECTION 1: for-in with .where()            #');
  print('##############################################');

  List<int> scores = [50, 75, 20, 99, 100, 30];
  print('  All scores: $scores');
  print('');

  // .where((s) => s > 50) returns only scores greater than 50.
  // The for-in loop then iterates ONLY over those filtered scores.
  // scores that are 50 or below are completely skipped.
  print('  Scores greater than 50:');
  for (int score in scores.where((s) => s > 50)) {
    print('    The score $score is greater than 50!');
  }

  // You can also store the filtered result in a variable first:
  print('');
  print('  Scores less than or equal to 50:');
  var lowScores = scores.where((s) => s <= 50);
  for (int score in lowScores) {
    print('    The score $score is 50 or below.');
  }

  print('');

  // ============================================================
  // 2. IF / ELSE INSIDE A LOOP — Categorize items while iterating
  //    Instead of filtering BEFORE the loop (like .where()),
  //    you check each item INSIDE the loop and react differently.
  //
  //    Use this when you need to handle ALL items but treat
  //    them differently based on some condition.
  //
  //    Think of it like sorting mail:
  //    You look at EVERY letter, but put bills in one pile
  //    and personal letters in another.
  // ============================================================
  print('##############################################');
  print('# SECTION 2: if/else inside a loop           #');
  print('##############################################');

  List<int> scores2 = [50, 75, 20, 99, 100, 30];
  print('  All scores: $scores2');
  print('');

  // Every score is checked — nothing is skipped.
  // Each score gets categorized as "Passed" or "Not high enough."
  for (int score in scores2) {
    if (score > 50) {
      print('    $score - Passed!');
    } else {
      print('    $score - Not high enough.');
    }
  }

  print('');

  // ============================================================
  // 3. FOR-IN LOOP (forEach style) — Loop through every item
  //    The simplest loop. No index, no filtering — just go
  //    through every item in the list, one by one.
  //
  //    Use this when you want to DO something with every item
  //    and you don't care about its position in the list.
  //
  //    Dart also has a .forEach() method, but the for-in syntax
  //    is generally preferred because:
  //      - It supports break and continue
  //      - It's easier to read
  //      - It works with async/await
  // ============================================================
  print('##############################################');
  print('# SECTION 3: for-in loop (forEach style)     #');
  print('##############################################');

  List<int> scores3 = [50, 75, 20, 99, 100, 30];
  print('  Printing all scores:');

  // "score" takes on each value in the list, one at a time.
  // First iteration: score = 50
  // Second iteration: score = 75
  // ... and so on until the list is exhausted.
  for (int score in scores3) {
    print('    Score: $score');
  }

  // For comparison, here's the .forEach() method doing the same thing.
  // NOTE: Dart's linter prefers for-in over .forEach() because for-in
  // supports break, continue, and async/await. The .forEach() is shown
  // here purely for educational purposes so you recognize it in code.
  print('');
  print('  Same thing with .forEach():');
  // ignore: avoid_function_literals_in_foreach_calls
  scores3.forEach((score) {
    print('    Score: $score');
  });

  print('');

  // ============================================================
  // 4. STANDARD FOR LOOP WITH INDEX — When position matters
  //    The classic C-style for loop. Use when you need:
  //      - The index (position) of each item
  //      - To access items by their position
  //      - To skip items (i += 2 for every other item)
  //      - To loop backward (i-- instead of i++)
  //
  //    Structure: for (initialize; condition; update)
  //      - int i = 0       → start at index 0
  //      - i < list.length → keep going while there are items
  //      - i++             → move to the next index each time
  // ============================================================
  print('##############################################');
  print('# SECTION 4: Standard for loop with index    #');
  print('##############################################');

  List<int> scores4 = [50, 75, 20, 99, 100, 30];
  print('  Printing scores with their index:');

  // i goes from 0 to 5 (scores4.length - 1).
  // We can use i to access both the position AND the value.
  for (int i = 0; i < scores4.length; i++) {
    print('    Score at index $i is ${scores4[i]}');
  }

  // BONUS: Looping backward — from last to first
  print('');
  print('  Scores in reverse order:');
  for (int i = scores4.length - 1; i >= 0; i--) {
    print('    Score at index $i is ${scores4[i]}');
  }

  // BONUS: Looping every other item
  print('');
  print('  Every other score (even indices):');
  for (int i = 0; i < scores4.length; i += 2) {
    print('    Score at index $i is ${scores4[i]}');
  }

  print('');
}

// =============================================================================
// =============================================================================
//  NOTES: For Loops — Summary
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | LOOP TYPE                   | WHEN TO USE
//  -----------------------------------------------------------------------
//   1  | for-in with .where()        | Filter FIRST, then loop over matches
//   2  | if/else inside a loop       | Process ALL items with different logic
//   3  | for-in (forEach style)      | Simple iteration — no index needed
//   4  | Standard for loop (i++)     | When you need the index / position
//  -----------------------------------------------------------------------
//
//  CHOOSING THE RIGHT FOR LOOP:
//  ┌──────────────────────────────────────┬──────────────────────────────────┐
//  │  Question                            │  Use this                        │
//  ├──────────────────────────────────────┼──────────────────────────────────┤
//  │  Just need each value?               │  for (var item in list)          │
//  │  Need the index (position)?          │  for (int i = 0; i < ...; i++)  │
//  │  Only want SOME items?               │  for (var x in list.where(...)) │
//  │  Need to categorize each item?       │  for-in + if/else inside        │
//  │  Loop backward?                      │  for (int i = len-1; i >= 0; i--) │
//  │  Skip items (every other)?           │  for (int i = 0; ...; i += 2)  │
//  └──────────────────────────────────────┴──────────────────────────────────┘
//
//  PERFORMANCE TIP:
//  .where() creates a LAZY iterable — it doesn't build a new list.
//  Elements are tested one-by-one as the loop requests them.
//  This is memory-efficient for large collections.
//
// =============================================================================
