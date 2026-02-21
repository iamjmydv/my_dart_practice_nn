//------------------------------------------------------------------------------
// L I S T S  —  C O M P L E T E  G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 4 samples into one runnable file.
// Lists in Dart are ordered collections of items (like arrays in JavaScript).
// They hold multiple values in a single variable, accessed by index (starting at 0).
//
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                         | KEY CONCEPTS                              | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Creating & Accessing Lists    | List<int>, var, index, update, type safety | Foundation — how lists work
//  2  | Adding & Removing Elements    | add(), addAll(), insert(), remove(),       | Grow and shrink lists dynamically
//     |                               | removeAt()                                |
//  3  | Searching & Info              | contains(), indexOf(), first, last,        | Find data and check list state
//     |                               | isEmpty, isNotEmpty, length               |
//  4  | Transforming & Iterating      | join(), where(), map(), forEach(), sort(), | Process, filter, and rearrange data
//     |                               | reversed, sublist(), shuffle()            |
// -----------------------------------------------------------------------
//
// TIP: To run just ONE sample, comment out the others in main().
//
// -----------------------------------------------------------------------

void main() {
  // ============================================================
  //  Uncomment/comment any sample to run only what you want.
  //  Each sample is independent — they don't depend on each other.
  // ============================================================

  sample1CreatingAndAccessing();
  sample2AddingAndRemoving();
  sample3SearchingAndInfo();
  sample4TransformingAndIterating();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  CREATING & ACCESSING LISTS
//
//  Lists are the most common collection type in Dart.
//  You can create typed lists (List<int>) for safety,
//  or dynamic lists (var) for flexibility.
//
//  Elements are accessed by index (starting at 0).
//  You can read, update, and check types.
//
//  Think of a list like a numbered shelf — each slot has
//  a position (index) and holds one item.
//
// =============================================================================
// =============================================================================

void sample1CreatingAndAccessing() {
  print('');
  print('##############################################');
  print('# SAMPLE 1: Creating & Accessing Lists       #');
  print('##############################################');

  // ============================================================
  // 1. CREATING A TYPED LIST — List<int>
  //    When you declare a list with a type (e.g., List<int>),
  //    Dart enforces that EVERY element must be that type.
  //    This gives you compile-time safety — errors are caught
  //    BEFORE your code even runs.
  // ============================================================
  print('  === Creating a typed list ===');

  List<int> scores = [80, 83, 85, 90, 95, 100];
  print('  scores: $scores');

  List<String> names = [];
  names.add('Mario');
  names.add('Luigi');
  print('  names: $names');

  // ============================================================
  // 2. CREATING A DYNAMIC LIST — var (mixed types)
  //    Using 'var' without a type annotation lets Dart infer
  //    the type as List<Object>, which can hold ANY type.
  // ============================================================
  print('  === Creating a dynamic list ===');

  var myList = [1, 2, 3, 4, 5, 'Mario', 'Luigi'];
  print('  myList: $myList');

  print('  Iterating:');
  for (var element in myList) {
    print('    - ${element.toString()}');
  }

  // ============================================================
  // 3. ACCESSING ELEMENTS BY INDEX
  //    Use bracket notation with the index to get a value.
  //    Index starts at 0.
  // ============================================================
  print('  === Accessing elements ===');

  print('  scores[0]: ${scores[0]}');
  print('  scores[1]: ${scores[1]}');
  print('  scores[5]: ${scores[5]}');

  // ============================================================
  // 4. UPDATING VALUES AT A SPECIFIC INDEX
  //    Replace a value using bracket notation on the left side.
  // ============================================================
  print('  === Updating values ===');

  List<int> updateScores = [80, 83, 85, 90, 95, 100];
  print('  Before: $updateScores');

  updateScores[0] = 84;
  print('  After updateScores[0] = 84: $updateScores');

  updateScores[5] = 99;
  print('  After updateScores[5] = 99: $updateScores');

  // ============================================================
  // 5. TYPE SAFETY — Typed lists reject wrong types
  //    A List<int> only accepts int values.
  //    Trying to assign a String causes a compile-time error.
  //
  //    Example (would NOT compile):
  //      scores[0] = "Mario";
  //      // ERROR: A value of type 'String' can't be assigned
  //      //        to a variable of type 'int'
  // ============================================================
  print('  === Type safety ===');

  List<int> safeScores = [80, 83, 85, 90, 95, 100];
  print('  safeScores type: List<int>');
  safeScores[0] = 84;
  print('  safeScores[0] = 84 (valid): $safeScores');
  print('  Assigning "Mario" to List<int> would cause a compile error.');

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  ADDING & REMOVING ELEMENTS
//
//  Once you have a list, you'll often need to grow it (add items)
//  or shrink it (remove items). Dart provides several methods:
//
//  Adding:   add(), addAll(), insert()
//  Removing: remove(), removeAt()
//
//  All of these methods MODIFY the original list in place.
//
// =============================================================================
// =============================================================================

void sample2AddingAndRemoving() {
  print('##############################################');
  print('# SAMPLE 2: Adding & Removing Elements       #');
  print('##############################################');

  // ============================================================
  // 1. add() — Append a single value to the END of the list
  // ============================================================
  print('  === add() ===');

  List<int> scores = [80, 83, 85, 90, 95, 100];
  print('  Before: $scores');
  scores.add(150);
  print('  After add(150): $scores');
  scores.add(200);
  print('  After add(200): $scores');

  // ============================================================
  // 2. addAll() — Append MULTIPLE values to the end at once
  //    Takes another list (or any Iterable) as the argument.
  // ============================================================
  print('  === addAll() ===');

  List<int> moreScores = [80, 83, 85, 90, 95, 100];
  print('  Before: $moreScores');
  moreScores.addAll([110, 120]);
  print('  After addAll([110, 120]): $moreScores');

  // ============================================================
  // 3. insert() — Insert a value at a SPECIFIC index position
  //    Existing elements shift to the right.
  // ============================================================
  print('  === insert() ===');

  List<int> insertScores = [80, 83, 85, 90, 95, 100];
  print('  Before: $insertScores');
  insertScores.insert(2, 84);
  print('  After insert(2, 84): $insertScores');
  insertScores.insert(0, 75);
  print('  After insert(0, 75): $insertScores');

  // ============================================================
  // 4. remove() — Remove the FIRST occurrence of a specific value
  //    Returns true if found and removed, false otherwise.
  //    Only removes the FIRST match.
  // ============================================================
  print('  === remove() ===');

  List<int> removeScores = [80, 83, 85, 90, 95, 100];
  print('  Before: $removeScores');

  bool wasRemoved = removeScores.remove(100);
  print('  remove(100) returned: $wasRemoved');
  print('  After remove(100): $removeScores');

  bool notFound = removeScores.remove(999);
  print('  remove(999) returned: $notFound');
  print('  After remove(999): $removeScores');

  // Only the first occurrence is removed
  List<int> duplicates = [10, 20, 30, 20, 40];
  print('  duplicates before: $duplicates');
  duplicates.remove(20);
  print('  After remove(20): $duplicates');

  // ============================================================
  // 5. removeAt() — Remove the element at a SPECIFIC index
  //    Returns the VALUE that was removed.
  //    Elements after the removed index shift left by 1.
  // ============================================================
  print('  === removeAt() ===');

  List<int> removeAtScores = [80, 83, 85, 90, 95, 100];
  print('  Before: $removeAtScores');

  int removedValue = removeAtScores.removeAt(2);
  print('  removeAt(2) returned: $removedValue');
  print('  After removeAt(2): $removeAtScores');

  int removedFirst = removeAtScores.removeAt(0);
  print('  removeAt(0) returned: $removedFirst');
  print('  After removeAt(0): $removeAtScores');

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  3:  SEARCHING & INFO
//
//  Dart lists come with built-in methods and properties to search
//  for elements and get information about the list itself.
//
//  Searching: contains(), indexOf()
//  Info:      first, last, isEmpty, isNotEmpty, length
//
//  None of these modify the original list.
//
// =============================================================================
// =============================================================================

void sample3SearchingAndInfo() {
  print('##############################################');
  print('# SAMPLE 3: Searching & Info                 #');
  print('##############################################');

  // ============================================================
  // 1. contains() — Check if a specific value EXISTS in the list
  //    Returns true if found, false otherwise.
  // ============================================================
  print('  === contains() ===');

  List<int> scores = [80, 83, 85, 90, 95, 100];
  print('  scores: $scores');
  print('  contains(90): ${scores.contains(90)}');
  print('  contains(50): ${scores.contains(50)}');

  int searchValue = 85;
  if (scores.contains(searchValue)) {
    print('  Found $searchValue in the list!');
  } else {
    print('  $searchValue is not in the list.');
  }

  // ============================================================
  // 2. indexOf() — Find the INDEX of a specific value
  //    Returns the index, or -1 if not found.
  // ============================================================
  print('  === indexOf() ===');

  print('  indexOf(90): ${scores.indexOf(90)}');
  print('  indexOf(50): ${scores.indexOf(50)}');
  print('  indexOf(80): ${scores.indexOf(80)}');

  int target = 95;
  int index = scores.indexOf(target);
  if (index != -1) {
    print('  $target found at index $index');
  } else {
    print('  $target not found');
  }

  // ============================================================
  // 3. first / last — Get the FIRST or LAST element
  //    Properties (no parentheses).
  //    WARNING: Throws StateError on empty lists!
  // ============================================================
  print('  === first / last ===');

  print('  first: ${scores.first}');
  print('  last: ${scores.last}');
  print('  first == [0]: ${scores.first == scores[0]}');
  print('  last == [length-1]: ${scores.last == scores[scores.length - 1]}');

  // ============================================================
  // 4. isEmpty / isNotEmpty — Check if the list has ANY elements
  //    Properties (no parentheses).
  // ============================================================
  print('  === isEmpty / isNotEmpty ===');

  List<int> fullList = [80, 83, 85, 90, 95, 100];
  List<int> emptyList = [];

  print('  fullList.isEmpty: ${fullList.isEmpty}');
  print('  fullList.isNotEmpty: ${fullList.isNotEmpty}');
  print('  emptyList.isEmpty: ${emptyList.isEmpty}');
  print('  emptyList.isNotEmpty: ${emptyList.isNotEmpty}');

  if (emptyList.isNotEmpty) {
    print('  First element: ${emptyList.first}');
  } else {
    print('  Cannot access first — list is empty!');
  }

  // ============================================================
  // 5. length — Get the TOTAL number of elements
  //    Note: length counts from 1, index counts from 0.
  //    So last valid index = length - 1.
  // ============================================================
  print('  === length ===');

  print('  scores.length: ${scores.length}');
  print('  Last valid index: ${scores.length - 1}');
  print('  emptyList.length: ${emptyList.length}');

  print('  Iterating with index:');
  for (int i = 0; i < scores.length; i++) {
    print('    index $i: ${scores[i]}');
  }

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  4:  TRANSFORMING & ITERATING
//
//  Dart lists have powerful methods for transforming data,
//  iterating over elements, and rearranging content.
//
//  Non-modifying: join(), where(), map(), forEach(), reversed, sublist()
//  Modifying:     sort(), shuffle()
//
//  where() and map() return Iterables — use .toList() to convert.
//
// =============================================================================
// =============================================================================

void sample4TransformingAndIterating() {
  print('##############################################');
  print('# SAMPLE 4: Transforming & Iterating         #');
  print('##############################################');

  // ============================================================
  // 1. join() — Combine ALL elements into a single String
  //    Each element is separated by the given separator.
  // ============================================================
  print('  === join() ===');

  List<int> scores = [80, 83, 85, 90, 95, 100];
  print('  scores: $scores');
  print('  join(", "): ${scores.join(', ')}');
  print('  join(" | "): ${scores.join(' | ')}');

  List<String> words = ['Dart', 'is', 'awesome'];
  print('  words.join(" "): ${words.join(' ')}');

  // ============================================================
  // 2. where() — Filter elements based on a CONDITION
  //    Returns an Iterable. Use .toList() to get a List.
  //    The original list is NOT modified.
  // ============================================================
  print('  === where() ===');

  var highScores = scores.where((score) => score >= 90);
  print('  where(score >= 90): ${highScores.toList()}');

  var lowScores = scores.where((score) => score < 85);
  print('  where(score < 85): ${lowScores.toList()}');

  var evenScores = scores.where((score) => score % 2 == 0);
  print('  where(even): ${evenScores.toList()}');
  print('  Original unchanged: $scores');

  // ============================================================
  // 3. map() — Transform EACH element into something new
  //    Returns an Iterable. The original list is NOT modified.
  // ============================================================
  print('  === map() ===');

  var doubled = scores.map((score) => score * 2);
  print('  map(score * 2): ${doubled.toList()}');

  var asStrings = scores.map((score) => 'Score: $score');
  print('  map to strings: ${asStrings.toList()}');

  var bonusScores = scores.map((score) => score + 5);
  print('  map(score + 5): ${bonusScores.toList()}');
  print('  Original unchanged: $scores');

  // ============================================================
  // 4. forEach() — Execute a function on EACH element
  //    Similar to a for-in loop. Returns void (side effects only).
  // ============================================================
  print('  === forEach() ===');

  print('  forEach output:');
  for (var score in scores) {
    print('    Score: $score');
  }

  print('  forEach with grade labels:');
  for (var score in scores) {
    String grade = score >= 90 ? 'A' : 'B';
    print('    $score -> Grade $grade');
  }

  // ============================================================
  // 5. sort() — Sort the list IN PLACE
  //    Modifies the original list. Default: ascending order.
  //    Use a comparator for descending or custom sorting.
  // ============================================================
  print('  === sort() ===');

  List<int> unsorted = [95, 80, 100, 83, 90, 85];
  print('  Before sort: $unsorted');

  unsorted.sort();
  print('  After sort() (ascending): $unsorted');

  unsorted.sort((a, b) => b.compareTo(a));
  print('  After sort descending: $unsorted');

  List<String> names = ['Charlie', 'Alice', 'Bob', 'Diana'];
  names.sort();
  print('  Sorted names: $names');

  // ============================================================
  // 6. reversed — Get elements in REVERSE order
  //    Property (no parentheses). Does NOT modify the original.
  //    Use .toList() to convert back to a List.
  // ============================================================
  print('  === reversed ===');

  List<int> revScores = [80, 83, 85, 90, 95, 100];
  print('  revScores: $revScores');
  print('  reversed: ${revScores.reversed.toList()}');
  print('  Original unchanged: $revScores');

  // ============================================================
  // 7. sublist() — Extract a PORTION of the list
  //    sublist(start, [end]) — start is inclusive, end is exclusive.
  //    If end is omitted, goes to the end of the list.
  // ============================================================
  print('  === sublist() ===');

  List<int> subScores = [80, 83, 85, 90, 95, 100];
  print('  subScores: $subScores');
  print('  sublist(1, 4): ${subScores.sublist(1, 4)}');
  print('  sublist(3): ${subScores.sublist(3)}');
  print('  sublist(0, 2): ${subScores.sublist(0, 2)}');

  // ============================================================
  // 8. shuffle() — Randomly rearrange elements IN PLACE
  //    Modifies the original list. Different order every time.
  // ============================================================
  print('  === shuffle() ===');

  List<int> shuffleScores = [80, 83, 85, 90, 95, 100];
  print('  Before shuffle: $shuffleScores');
  shuffleScores.shuffle();
  print('  After shuffle:  $shuffleScores');
  shuffleScores.shuffle();
  print('  Shuffle again:  $shuffleScores');

  print('');
}

// =============================================================================
// =============================================================================
//  NOTES: Lists — Complete Summary of ALL 4 Samples
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | TOPIC                    | KEY CONCEPTS
//  -----------------------------------------------------------------------
//   1  | Creating & Accessing     | List<int>, var, index access, update, type safety
//   2  | Adding & Removing        | add(), addAll(), insert(), remove(), removeAt()
//   3  | Searching & Info         | contains(), indexOf(), first, last, isEmpty,
//      |                          | isNotEmpty, length
//   4  | Transforming & Iterating | join(), where(), map(), forEach(), sort(),
//      |                          | reversed, sublist(), shuffle()
//  -----------------------------------------------------------------------
//
//  ALL LIST METHODS & PROPERTIES COVERED:
//  ┌────────────────────────────┬────────────────────────────────────────────┐
//  │  Method / Property         │  What it does                             │
//  ├────────────────────────────┼────────────────────────────────────────────┤
//  │  List<T>                   │  Create a typed list (Sample 1)           │
//  │  var list = [...]          │  Create a dynamic list (Sample 1)         │
//  │  list[index]               │  Access element by index (Sample 1)      │
//  │  list[index] = value       │  Update element by index (Sample 1)      │
//  │  add()                     │  Append one element to end (Sample 2)    │
//  │  addAll()                  │  Append multiple elements (Sample 2)     │
//  │  insert()                  │  Insert at specific index (Sample 2)     │
//  │  remove()                  │  Remove first match by value (Sample 2)  │
//  │  removeAt()                │  Remove by index position (Sample 2)     │
//  │  contains()                │  Check if value exists (Sample 3)        │
//  │  indexOf()                 │  Get index of value (Sample 3)           │
//  │  first                     │  Get first element (Sample 3)            │
//  │  last                      │  Get last element (Sample 3)             │
//  │  isEmpty                   │  Check if list is empty (Sample 3)       │
//  │  isNotEmpty                │  Check if list has elements (Sample 3)   │
//  │  length                    │  Get total element count (Sample 3)      │
//  │  join()                    │  Combine into String (Sample 4)          │
//  │  where()                   │  Filter by condition (Sample 4)          │
//  │  map()                     │  Transform each element (Sample 4)       │
//  │  forEach()                 │  Run function on each (Sample 4)         │
//  │  sort()                    │  Sort in place (Sample 4)                │
//  │  reversed                  │  Get reversed view (Sample 4)            │
//  │  sublist()                 │  Extract range of elements (Sample 4)    │
//  │  shuffle()                 │  Randomly rearrange (Sample 4)           │
//  └────────────────────────────┴────────────────────────────────────────────┘
//
//  MODIFIES vs DOES NOT MODIFY:
//  ┌───────────────────────────┬───────────────────────────┐
//  │  Modifies original list   │  Does NOT modify          │
//  ├───────────────────────────┼───────────────────────────┤
//  │  add(), addAll()          │  contains(), indexOf()    │
//  │  insert()                 │  first, last              │
//  │  remove(), removeAt()     │  isEmpty, isNotEmpty      │
//  │  sort(), shuffle()        │  length                   │
//  │  list[i] = value          │  join(), where(), map()   │
//  │                           │  forEach(), reversed      │
//  │                           │  sublist()                │
//  └───────────────────────────┴───────────────────────────┘
//
//  QUICK REFERENCE:
//  - Typed list:    List<int> scores = [1, 2, 3];  (only ints)
//  - Dynamic list:  var stuff = [1, "hi", true];    (anything)
//  - Index starts at 0, length counts from 1
//  - Last valid index = length - 1
//  - where() and map() return Iterables — use .toList()
//  - remove() finds by VALUE, removeAt() finds by INDEX
//  - first/last throw on empty lists — check isEmpty first!
//
// =============================================================================
