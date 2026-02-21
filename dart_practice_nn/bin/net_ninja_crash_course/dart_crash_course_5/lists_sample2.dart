//------------------------------------------------------------------------------
// L I S T S  —  A D D I N G  &  R E M O V I N G  E L E M E N T S
//------------------------------------------------------------------------------
//
// Once you have a list, you'll often need to grow it (add items)
// or shrink it (remove items). Dart provides several methods for both.
//
// This sample covers:
//   1. add()      — append a single element to the end
//   2. addAll()   — append multiple elements at once
//   3. insert()   — insert an element at a specific index
//   4. remove()   — remove the first occurrence of a value
//   5. removeAt() — remove the element at a specific index
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. add() — Append a single value to the END of the list
  //    The value must match the list's type (int in this case).
  //    The list grows by one element.
  //
  //    Think of it like adding a person to the end of a queue.
  // ============================================================
  print('=== 1. add() ===');

  List<int> scores = [80, 83, 85, 90, 95, 100];
  print('  Before: $scores');
  // output: Before: [80, 83, 85, 90, 95, 100]

  scores.add(150);
  print('  After add(150): $scores');
  // output: After add(150): [80, 83, 85, 90, 95, 100, 150]

  scores.add(200);
  print('  After add(200): $scores');
  // output: After add(200): [80, 83, 85, 90, 95, 100, 150, 200]

  print('');

  // ============================================================
  // 2. addAll() — Append MULTIPLE values to the end at once
  //    Takes another list (or any Iterable) as the argument.
  //    All elements from the given list are appended in order.
  //
  //    Think of it like merging two queues — the second queue
  //    joins at the end of the first.
  // ============================================================
  print('=== 2. addAll() ===');

  List<int> moreScores = [80, 83, 85, 90, 95, 100];
  print('  Before: $moreScores');
  // output: Before: [80, 83, 85, 90, 95, 100]

  moreScores.addAll([110, 120]);
  print('  After addAll([110, 120]): $moreScores');
  // output: After addAll([110, 120]): [80, 83, 85, 90, 95, 100, 110, 120]

  moreScores.addAll([130, 140, 150]);
  print('  After addAll([130, 140, 150]): $moreScores');
  // output: After addAll([130, 140, 150]): [80, 83, 85, 90, 95, 100, 110, 120, 130, 140, 150]

  print('');

  // ============================================================
  // 3. insert() — Insert a value at a SPECIFIC index position
  //    Existing elements at that index and beyond are shifted
  //    to the right (their indexes increase by 1).
  //
  //    Think of it like cutting in line — everyone behind you
  //    moves back one spot.
  //
  //    Syntax: list.insert(index, value)
  //      - index: WHERE to insert (0 = beginning, length = end)
  //      - value: WHAT to insert
  // ============================================================
  print('=== 3. insert() ===');

  List<int> insertScores = [80, 83, 85, 90, 95, 100];
  print('  Before: $insertScores');
  print('  Indexes: [0:80, 1:83, 2:85, 3:90, 4:95, 5:100]');
  // output: Before: [80, 83, 85, 90, 95, 100]

  insertScores.insert(2, 84);
  print('  After insert(2, 84): $insertScores');
  print('  Indexes: [0:80, 1:83, 2:84, 3:85, 4:90, 5:95, 6:100]');
  // output: After insert(2, 84): [80, 83, 84, 85, 90, 95, 100]
  // Note: 84 was inserted at index 2, and 85 shifted from index 2 to index 3

  insertScores.insert(0, 75);
  print('  After insert(0, 75): $insertScores');
  // output: After insert(0, 75): [75, 80, 83, 84, 85, 90, 95, 100]
  // Note: 75 was inserted at the beginning, everything shifted right

  print('');

  // ============================================================
  // 4. remove() — Remove the FIRST occurrence of a specific value
  //    Searches the list for the given value and removes it.
  //    Returns true if the value was found and removed.
  //    Returns false if the value was NOT found.
  //
  //    Important: Only removes the FIRST match. If the value
  //    appears multiple times, the rest stay in the list.
  // ============================================================
  print('=== 4. remove() ===');

  List<int> removeScores = [80, 83, 85, 90, 95, 100];
  print('  Before: $removeScores');
  // output: Before: [80, 83, 85, 90, 95, 100]

  bool wasRemoved = removeScores.remove(100);
  print('  remove(100) returned: $wasRemoved');
  print('  After remove(100): $removeScores');
  // output: remove(100) returned: true
  // output: After remove(100): [80, 83, 85, 90, 95]

  bool notFound = removeScores.remove(999);
  print('  remove(999) returned: $notFound');
  print('  After remove(999): $removeScores');
  // output: remove(999) returned: false (999 is not in the list)
  // output: After remove(999): [80, 83, 85, 90, 95] (unchanged)

  // Demonstrating that remove() only removes the FIRST occurrence:
  List<int> duplicates = [10, 20, 30, 20, 40];
  print('  duplicates before: $duplicates');
  duplicates.remove(20);
  print('  After remove(20): $duplicates');
  // output: After remove(20): [10, 30, 20, 40] — only the first 20 was removed

  print('');

  // ============================================================
  // 5. removeAt() — Remove the element at a SPECIFIC index
  //    Returns the VALUE that was removed from the list.
  //    All elements after the removed index shift left by 1.
  //
  //    Think of it like pulling someone out of a line —
  //    everyone behind them moves forward one spot.
  //
  //    Throws a RangeError if the index is out of bounds.
  // ============================================================
  print('=== 5. removeAt() ===');

  List<int> removeAtScores = [80, 83, 85, 90, 95, 100];
  print('  Before: $removeAtScores');
  print('  Indexes: [0:80, 1:83, 2:85, 3:90, 4:95, 5:100]');

  int removedValue = removeAtScores.removeAt(2);
  print('  removeAt(2) returned: $removedValue');
  print('  After removeAt(2): $removeAtScores');
  // output: removeAt(2) returned: 85
  // output: After removeAt(2): [80, 83, 90, 95, 100]

  int removedFirst = removeAtScores.removeAt(0);
  print('  removeAt(0) returned: $removedFirst');
  print('  After removeAt(0): $removeAtScores');
  // output: removeAt(0) returned: 80
  // output: After removeAt(0): [83, 90, 95, 100]

  print('');
}

// =============================================================================
// NOTES: Adding & Removing Elements — Summary
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | METHOD     | WHAT IT DOES                      | RETURNS
//  -----------------------------------------------------------------------
//   1  | add()      | Append one element to end         | void
//   2  | addAll()   | Append multiple elements to end   | void
//   3  | insert()   | Insert at specific index          | void
//   4  | remove()   | Remove first match by value       | bool (found?)
//   5  | removeAt() | Remove element at specific index  | The removed value
//  -----------------------------------------------------------------------
//
//  KEY TAKEAWAYS:
//  - add() and addAll() always add to the END of the list
//  - insert() lets you choose WHERE to add (by index)
//  - remove() searches by VALUE — removes the first match only
//  - removeAt() removes by INDEX — you specify the position
//  - remove() returns bool (was it found?), removeAt() returns the value
//  - All these methods MODIFY the original list (they don't create a new one)
//  - The value must match the list's declared type (type safety)
//
// =============================================================================
