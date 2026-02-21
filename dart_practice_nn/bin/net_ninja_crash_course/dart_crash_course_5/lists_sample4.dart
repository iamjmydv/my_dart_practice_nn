//------------------------------------------------------------------------------
// L I S T S  —  T R A N S F O R M I N G  &  I T E R A T I N G
//------------------------------------------------------------------------------
//
// Dart lists have powerful methods for transforming data, iterating
// over elements, and rearranging content. These methods are similar
// to what you find in JavaScript arrays.
//
// This sample covers:
//   1. join()     — combine all elements into a single String
//   2. where()    — filter elements based on a condition
//   3. map()      — transform each element into something new
//   4. forEach()  — execute a function on each element
//   5. sort()     — sort the list in place (ascending / descending)
//   6. reversed   — get elements in reverse order (without modifying)
//   7. sublist()  — extract a portion of the list by index range
//   8. shuffle()  — randomly rearrange elements in place
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. join() — Combine ALL elements into a single String
  //    Each element is converted to a String and separated by
  //    the given separator.
  //    Useful for displaying lists in a readable format.
  //
  //    Think of it like stringing beads together with thread —
  //    each bead is an element, the thread is the separator.
  // ============================================================
  print('=== 1. join() ===');

  List<int> scores = [80, 83, 85, 90, 95, 100];
  print('  scores: $scores');

  String joined = scores.join(', ');
  print('  join(", "): $joined');
  // output: join(", "): 80, 83, 85, 90, 95, 100

  print('  join(" | "): ${scores.join(' | ')}');
  // output: join(" | "): 80 | 83 | 85 | 90 | 95 | 100

  print('  join(""): ${scores.join('')}');
  // output: join(""): 808385909510 (no separator)

  List<String> words = ['Dart', 'is', 'awesome'];
  print('  words.join(" "): ${words.join(' ')}');
  // output: words.join(" "): Dart is awesome

  print('');

  // ============================================================
  // 2. where() — Filter elements based on a CONDITION
  //    Returns a new Iterable containing only the elements
  //    that satisfy the condition (return true).
  //    The original list is NOT modified.
  //
  //    Think of it like a bouncer at a club — only elements
  //    that pass the test get through.
  //
  //    Note: Returns an Iterable, not a List.
  //    Use .toList() to convert it back to a List.
  // ============================================================
  print('=== 2. where() ===');

  List<int> whereScores = [80, 83, 85, 90, 95, 100];
  print('  whereScores: $whereScores');

  var highScores = whereScores.where((score) => score >= 90);
  print('  where(score >= 90): ${highScores.toList()}');
  // output: where(score >= 90): [90, 95, 100]

  var lowScores = whereScores.where((score) => score < 85);
  print('  where(score < 85): ${lowScores.toList()}');
  // output: where(score < 85): [80, 83]

  var evenScores = whereScores.where((score) => score % 2 == 0);
  print('  where(even): ${evenScores.toList()}');
  // output: where(even): [80, 90, 100]

  print('  Original unchanged: $whereScores');
  // output: Original unchanged: [80, 83, 85, 90, 95, 100]

  print('');

  // ============================================================
  // 3. map() — Transform EACH element into something new
  //    Applies a function to every element and returns a new
  //    Iterable with the results.
  //    The original list is NOT modified.
  //
  //    Think of it like a machine on an assembly line —
  //    each item goes in, gets transformed, and comes out changed.
  //
  //    Note: Returns an Iterable. Use .toList() to get a List.
  // ============================================================
  print('=== 3. map() ===');

  List<int> mapScores = [80, 83, 85, 90, 95, 100];
  print('  mapScores: $mapScores');

  var doubled = mapScores.map((score) => score * 2);
  print('  map(score * 2): ${doubled.toList()}');
  // output: map(score * 2): [160, 166, 170, 180, 190, 200]

  var asStrings = mapScores.map((score) => 'Score: $score');
  print('  map to strings: ${asStrings.toList()}');
  // output: map to strings: [Score: 80, Score: 83, Score: 85, Score: 90, Score: 95, Score: 100]

  var bonusScores = mapScores.map((score) => score + 5);
  print('  map(score + 5): ${bonusScores.toList()}');
  // output: map(score + 5): [85, 88, 90, 95, 100, 105]

  print('  Original unchanged: $mapScores');
  // output: Original unchanged: [80, 83, 85, 90, 95, 100]

  print('');

  // ============================================================
  // 4. forEach() — Execute a function on EACH element
  //    Similar to a for-in loop but written as a method call.
  //    Does NOT return anything (void) — used for side effects
  //    like printing, logging, or updating external state.
  //
  //    Think of it like a teacher calling on each student
  //    one by one — each student does something when called.
  // ============================================================
  print('=== 4. forEach() ===');

  List<int> forEachScores = [80, 83, 85, 90, 95, 100];
  print('  forEachScores: $forEachScores');
  print('  forEach output:');

  forEachScores.forEach((score) => print('    Score: $score'));
  // output:
  //   Score: 80
  //   Score: 83
  //   Score: 85
  //   Score: 90
  //   Score: 95
  //   Score: 100

  // forEach with multi-line function body
  print('  forEach with grade labels:');
  forEachScores.forEach((score) {
    String grade = score >= 90 ? 'A' : 'B';
    print('    $score -> Grade $grade');
  });

  print('');

  // ============================================================
  // 5. sort() — Sort the list IN PLACE
  //    Modifies the original list (does NOT create a new one).
  //    By default, sorts in ascending order.
  //    Use a custom comparator for descending or custom sorting.
  //
  //    Comparator: (a, b) => a.compareTo(b)
  //      returns negative if a < b, zero if a == b, positive if a > b
  //      Swap a and b for descending order.
  // ============================================================
  print('=== 5. sort() ===');

  List<int> unsorted = [95, 80, 100, 83, 90, 85];
  print('  Before sort: $unsorted');

  unsorted.sort();
  print('  After sort() (ascending): $unsorted');
  // output: After sort() (ascending): [80, 83, 85, 90, 95, 100]

  unsorted.sort((a, b) => b.compareTo(a));
  print('  After sort descending: $unsorted');
  // output: After sort descending: [100, 95, 90, 85, 83, 80]

  // Sorting strings alphabetically
  List<String> names = ['Charlie', 'Alice', 'Bob', 'Diana'];
  names.sort();
  print('  Sorted names: $names');
  // output: Sorted names: [Alice, Bob, Charlie, Diana]

  print('');

  // ============================================================
  // 6. reversed — Get elements in REVERSE order
  //    Returns an Iterable with elements in reverse order.
  //    The original list is NOT modified.
  //    Use .toList() to convert back to a List.
  //
  //    This is a property (no parentheses), not a method.
  //    Unlike sort(), it does NOT change the original list.
  // ============================================================
  print('=== 6. reversed ===');

  List<int> revScores = [80, 83, 85, 90, 95, 100];
  print('  revScores: $revScores');

  var reversedList = revScores.reversed.toList();
  print('  reversed: $reversedList');
  // output: reversed: [100, 95, 90, 85, 83, 80]

  print('  Original unchanged: $revScores');
  // output: Original unchanged: [80, 83, 85, 90, 95, 100]

  print('');

  // ============================================================
  // 7. sublist() — Extract a PORTION of the list
  //    Returns a new list containing elements from start index
  //    to end index.
  //
  //    Syntax: list.sublist(start, [end])
  //      - start: inclusive (this index IS included)
  //      - end:   exclusive (this index is NOT included)
  //      - If end is omitted, goes to the end of the list
  //
  //    Think of it like cutting a piece from a ribbon —
  //    you choose where to start and stop cutting.
  // ============================================================
  print('=== 7. sublist() ===');

  List<int> subScores = [80, 83, 85, 90, 95, 100];
  print('  subScores: $subScores');
  print('  Indexes:   [0,  1,  2,  3,  4,   5]');

  print('  sublist(1, 4): ${subScores.sublist(1, 4)}');
  // output: sublist(1, 4): [83, 85, 90]
  // Includes index 1, 2, 3 — but NOT index 4

  print('  sublist(3): ${subScores.sublist(3)}');
  // output: sublist(3): [90, 95, 100]
  // From index 3 to the end

  print('  sublist(0, 2): ${subScores.sublist(0, 2)}');
  // output: sublist(0, 2): [80, 83]
  // First two elements

  print('  Original unchanged: $subScores');
  // output: Original unchanged: [80, 83, 85, 90, 95, 100]

  print('');

  // ============================================================
  // 8. shuffle() — Randomly rearrange elements IN PLACE
  //    The list is modified in place (no new list is created).
  //    The order is random — different every time you run it.
  //
  //    Think of it like shuffling a deck of cards.
  // ============================================================
  print('=== 8. shuffle() ===');

  List<int> shuffleScores = [80, 83, 85, 90, 95, 100];
  print('  Before shuffle: $shuffleScores');

  shuffleScores.shuffle();
  print('  After shuffle:  $shuffleScores');
  // output: random order, e.g. [95, 80, 100, 83, 90, 85]

  shuffleScores.shuffle();
  print('  Shuffle again:  $shuffleScores');
  // output: another random order

  print('');
}

// =============================================================================
// NOTES: Transforming & Iterating — Summary
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | METHOD     | WHAT IT DOES                      | MODIFIES ORIGINAL?
//  -----------------------------------------------------------------------
//   1  | join()     | Combine into a String             | No (returns String)
//   2  | where()    | Filter by condition               | No (returns Iterable)
//   3  | map()      | Transform each element            | No (returns Iterable)
//   4  | forEach()  | Run function on each element      | No (returns void)
//   5  | sort()     | Sort in place (asc/desc)          | YES
//   6  | reversed   | Get reversed view                 | No (returns Iterable)
//   7  | sublist()  | Extract a range of elements       | No (returns new List)
//   8  | shuffle()  | Randomly rearrange                | YES
//  -----------------------------------------------------------------------
//
//  MODIFIES vs DOES NOT MODIFY:
//  ┌───────────────────────┬───────────────────────────┐
//  │  Modifies original    │  Does NOT modify          │
//  ├───────────────────────┼───────────────────────────┤
//  │  sort()               │  join()                   │
//  │  shuffle()            │  where()                  │
//  │                       │  map()                    │
//  │                       │  forEach()                │
//  │                       │  reversed                 │
//  │                       │  sublist()                │
//  └───────────────────────┴───────────────────────────┘
//
//  KEY TAKEAWAYS:
//  - where() and map() return Iterables — use .toList() to get a List
//  - sort() changes the original list; reversed does NOT
//  - forEach() is for side effects (printing, logging), not transforming
//  - Use map() when you want to transform data, forEach() when you don't
//  - sublist(start, end) — start is inclusive, end is exclusive
//  - shuffle() gives a different order every time
//
// =============================================================================
