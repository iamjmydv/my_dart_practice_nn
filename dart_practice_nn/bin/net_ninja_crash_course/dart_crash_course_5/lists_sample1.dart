//------------------------------------------------------------------------------
// L I S T S  —  C R E A T I N G  &  A C C E S S I N G
//------------------------------------------------------------------------------
//
// Lists in Dart are ordered collections of items (like arrays in JavaScript).
// They hold multiple values of the same (or mixed) type in a single variable.
// Each element has an index starting from 0.
//
// This sample covers:
//   1. Creating a typed list (List<int>)
//   2. Creating a dynamic list (var — mixed types)
//   3. Accessing elements by index
//   4. Updating values at a specific index
//   5. Type safety — typed lists reject wrong types
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. CREATING A TYPED LIST — List<int>
  //    When you declare a list with a type (e.g., List<int>),
  //    Dart enforces that EVERY element must be that type.
  //    This gives you compile-time safety — errors are caught
  //    BEFORE your code even runs.
  //
  //    Think of it like a box labeled "integers only" — you
  //    can't sneak a String in there.
  // ============================================================
  print('=== 1. Creating a typed list ===');

  List<int> scores = [80, 83, 85, 90, 95, 100];
  print('  scores: $scores');
  // output: scores: [80, 83, 85, 90, 95, 100]

  // You can also create an empty typed list and add items later:
  List<String> names = [];
  names.add('Mario');
  names.add('Luigi');
  print('  names: $names');
  // output: names: [Mario, Luigi]

  print('');

  // ============================================================
  // 2. CREATING A DYNAMIC LIST — var (mixed types)
  //    Using 'var' without a type annotation lets Dart infer
  //    the type as List<Object>, which can hold ANY type.
  //    This is flexible but you lose type safety.
  //
  //    Think of it like a box with no label — anything goes in.
  // ============================================================
  print('=== 2. Creating a dynamic list ===');

  var myList = [1, 2, 3, 4, 5, 'Mario', 'Luigi'];
  print('  myList: $myList');
  // output: myList: [1, 2, 3, 4, 5, Mario, Luigi]

  // Iterating over a dynamic list — each element could be any type
  // so we use .toString() to safely print each one
  print('  Iterating:');
  for (var element in myList) {
    print('    - ${element.toString()}');
  }

  print('');

  // ============================================================
  // 3. ACCESSING ELEMENTS BY INDEX
  //    Use bracket notation with the index to get a value.
  //    List indexes start at 0, so the first element is at
  //    index 0, the second at index 1, and so on.
  //
  //    scores = [80, 83, 85, 90, 95, 100]
  //    index:    0   1   2   3   4    5
  // ============================================================
  print('=== 3. Accessing elements by index ===');

  List<int> testScores = [80, 83, 85, 90, 95, 100];
  print('  testScores[0]: ${testScores[0]}'); // output: 80
  print('  testScores[1]: ${testScores[1]}'); // output: 83
  print('  testScores[5]: ${testScores[5]}'); // output: 100

  print('');

  // ============================================================
  // 4. UPDATING VALUES AT A SPECIFIC INDEX
  //    You can replace a value at a specific index using
  //    bracket notation on the left side of an assignment.
  //    The new value must match the list's type.
  // ============================================================
  print('=== 4. Updating values ===');

  List<int> updateScores = [80, 83, 85, 90, 95, 100];
  print('  Before: $updateScores');
  // output: Before: [80, 83, 85, 90, 95, 100]

  updateScores[0] = 84; // change index 0 from 80 to 84
  print('  After updateScores[0] = 84: $updateScores');
  // output: After updateScores[0] = 84: [84, 83, 85, 90, 95, 100]

  updateScores[5] = 99; // change last element from 100 to 99
  print('  After updateScores[5] = 99: $updateScores');
  // output: After updateScores[5] = 99: [84, 83, 85, 90, 95, 99]

  print('');

  // ============================================================
  // 5. TYPE SAFETY — Typed lists reject wrong types
  //    A List<int> only accepts int values.
  //    Trying to assign a String to it causes a compile-time error.
  //
  //    Example (this would NOT compile):
  //      List<int> scores = [80, 83, 85];
  //      scores[0] = "Mario";
  //      // ERROR: A value of type 'String' can't be assigned
  //      //        to a variable of type 'int'
  //
  //    This is one of Dart's strengths — catching type errors
  //    at compile time instead of at runtime.
  // ============================================================
  print('=== 5. Type safety ===');

  List<int> safeScores = [80, 83, 85, 90, 95, 100];
  print('  safeScores type: List<int>');
  print('  safeScores: $safeScores');

  // This works — assigning an int to a List<int>
  safeScores[0] = 84;
  print('  safeScores[0] = 84 (valid): $safeScores');

  // This would NOT work (uncomment to see the error):
  // safeScores[0] = "Mario";
  // ERROR: A value of type 'String' can't be assigned to a variable of type 'int'

  print('  Trying to assign "Mario" to a List<int> would cause a compile error.');
  print('  Dart catches type mismatches BEFORE your code runs!');

  print('');
}

// =============================================================================
// NOTES: Creating & Accessing Lists — Summary
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | CONCEPT               | EXAMPLE                   | RESULT
//  -----------------------------------------------------------------------
//   1  | Typed list            | List<int> s = [1, 2, 3]   | Only ints allowed
//   2  | Dynamic list          | var l = [1, "hi", true]   | Any type allowed
//   3  | Access by index       | scores[0]                 | First element
//   4  | Update by index       | scores[0] = 84            | Replaces value
//   5  | Type safety           | scores[0] = "Mario"       | Compile error!
//  -----------------------------------------------------------------------
//
//  KEY TAKEAWAYS:
//  - List indexes start at 0 (first element) and go to length - 1 (last)
//  - List<int> enforces that only int values can be stored
//  - var without a type lets you store mixed types (List<Object>)
//  - Accessing an index out of range throws a RangeError at runtime
//  - Type safety catches mistakes at compile time, not runtime
//
// =============================================================================
