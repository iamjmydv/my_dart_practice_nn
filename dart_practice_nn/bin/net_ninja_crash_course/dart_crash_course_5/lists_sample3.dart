//------------------------------------------------------------------------------
// L I S T S  —  S E A R C H I N G  &  I N F O
//------------------------------------------------------------------------------
//
// Dart lists come with built-in methods and properties to search
// for elements and get information about the list itself.
// These are essential for checking data before acting on it.
//
// This sample covers:
//   1. contains()          — check if a value exists in the list
//   2. indexOf()           — find the index of a value
//   3. first / last        — get the first or last element
//   4. isEmpty / isNotEmpty — check if the list has any elements
//   5. length              — get the total number of elements
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. contains() — Check if a specific value EXISTS in the list
  //    Returns true if found, false otherwise.
  //    Uses == (equality) to compare values.
  //
  //    Think of it like asking: "Is this item in the bag?"
  //    You get a simple yes (true) or no (false).
  // ============================================================
  print('=== 1. contains() ===');

  List<int> scores = [80, 83, 85, 90, 95, 100];

  print('  scores: $scores');
  print('  contains(90): ${scores.contains(90)}');
  // output: contains(90): true

  print('  contains(50): ${scores.contains(50)}');
  // output: contains(50): false

  // Practical use: check before acting
  int searchValue = 85;
  if (scores.contains(searchValue)) {
    print('  Found $searchValue in the list!');
  } else {
    print('  $searchValue is not in the list.');
  }

  print('');

  // ============================================================
  // 2. indexOf() — Find the INDEX of a specific value
  //    Searches the list and returns the index of the first
  //    occurrence of the value.
  //    Returns -1 if the value is NOT found.
  //
  //    Think of it like asking: "WHERE is this item in the bag?"
  //    You get the position number, or -1 if it's not there.
  // ============================================================
  print('=== 2. indexOf() ===');

  List<int> indexScores = [80, 83, 85, 90, 95, 100];
  print('  indexScores: $indexScores');
  print('  Indexes:     [0,  1,  2,  3,  4,   5]');

  print('  indexOf(90): ${indexScores.indexOf(90)}');
  // output: indexOf(90): 3

  print('  indexOf(50): ${indexScores.indexOf(50)}');
  // output: indexOf(50): -1 (not found)

  print('  indexOf(80): ${indexScores.indexOf(80)}');
  // output: indexOf(80): 0

  // Practical use: check if found before using the index
  int target = 95;
  int index = indexScores.indexOf(target);
  if (index != -1) {
    print('  $target found at index $index');
  } else {
    print('  $target not found');
  }

  print('');

  // ============================================================
  // 3. first / last — Get the FIRST or LAST element
  //    These are properties (not methods), so no parentheses.
  //    They return the element directly.
  //
  //    WARNING: Throws a StateError if the list is EMPTY!
  //    Always check isEmpty first if you're not sure.
  //
  //    Think of it like peeking at the front or back of a line.
  // ============================================================
  print('=== 3. first / last ===');

  List<int> firstLastScores = [80, 83, 85, 90, 95, 100];
  print('  firstLastScores: $firstLastScores');

  print('  first: ${firstLastScores.first}');
  // output: first: 80

  print('  last: ${firstLastScores.last}');
  // output: last: 100

  // These are the same as accessing by index, but more readable:
  // firstLastScores.first == firstLastScores[0]
  // firstLastScores.last  == firstLastScores[firstLastScores.length - 1]
  print('  first == [0]: ${firstLastScores.first == firstLastScores[0]}');
  print('  last == [length-1]: ${firstLastScores.last == firstLastScores[firstLastScores.length - 1]}');

  print('');

  // ============================================================
  // 4. isEmpty / isNotEmpty — Check if the list has ANY elements
  //    Returns true or false.
  //    These are properties (not methods), so no parentheses.
  //
  //    isEmpty    → true if the list has 0 elements
  //    isNotEmpty → true if the list has 1 or more elements
  //
  //    These are SAFER than checking .length == 0 because they
  //    read more clearly and express your intent directly.
  // ============================================================
  print('=== 4. isEmpty / isNotEmpty ===');

  List<int> fullList = [80, 83, 85, 90, 95, 100];
  List<int> emptyList = [];

  print('  fullList: $fullList');
  print('  fullList.isEmpty: ${fullList.isEmpty}');
  // output: fullList.isEmpty: false
  print('  fullList.isNotEmpty: ${fullList.isNotEmpty}');
  // output: fullList.isNotEmpty: true

  print('');

  print('  emptyList: $emptyList');
  print('  emptyList.isEmpty: ${emptyList.isEmpty}');
  // output: emptyList.isEmpty: true
  print('  emptyList.isNotEmpty: ${emptyList.isNotEmpty}');
  // output: emptyList.isNotEmpty: false

  // Practical use: safe access to first/last
  if (emptyList.isNotEmpty) {
    print('  First element: ${emptyList.first}');
  } else {
    print('  Cannot access first — list is empty!');
  }

  print('');

  // ============================================================
  // 5. length — Get the TOTAL number of elements
  //    Returns an int representing how many elements are in the list.
  //    Note: length counts starting from 1, unlike index which
  //    starts from 0.
  //
  //    So a list with 6 elements has length 6,
  //    but the last index is 5 (length - 1).
  // ============================================================
  print('=== 5. length ===');

  List<int> lengthScores = [80, 83, 85, 90, 95, 100];
  print('  lengthScores: $lengthScores');

  print('  length: ${lengthScores.length}');
  // output: length: 6

  print('  Last valid index: ${lengthScores.length - 1}');
  // output: Last valid index: 5

  List<int> emptyLength = [];
  print('  emptyLength.length: ${emptyLength.length}');
  // output: emptyLength.length: 0

  // Practical use: iterate with a traditional for loop
  print('  Iterating with index:');
  for (int i = 0; i < lengthScores.length; i++) {
    print('    index $i: ${lengthScores[i]}');
  }

  print('');
}

// =============================================================================
// NOTES: Searching & Info — Summary
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | METHOD/PROPERTY  | WHAT IT DOES                     | RETURNS
//  -----------------------------------------------------------------------
//   1  | contains(value)  | Is this value in the list?       | bool
//   2  | indexOf(value)   | What index is this value at?     | int (-1 if not found)
//   3  | first             | Get the first element            | The element
//   4  | last              | Get the last element             | The element
//   5  | isEmpty           | Does the list have 0 elements?   | bool
//   6  | isNotEmpty        | Does the list have 1+ elements?  | bool
//   7  | length            | How many elements total?         | int
//  -----------------------------------------------------------------------
//
//  KEY TAKEAWAYS:
//  - contains() is great for quick "does it exist?" checks
//  - indexOf() returns -1 when not found (not null, not an error)
//  - first/last throw StateError on empty lists — check isEmpty first!
//  - isEmpty/isNotEmpty are cleaner than length == 0 / length > 0
//  - length counts from 1, indexes count from 0 (last index = length - 1)
//  - None of these methods/properties modify the original list
//
// =============================================================================
