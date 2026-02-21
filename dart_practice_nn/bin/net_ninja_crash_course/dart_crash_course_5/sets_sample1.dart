//------------------------------------------------------------------------------
// S E T S  —  B A S I C  S E T  O P E R A T I O N S
//------------------------------------------------------------------------------
//
// A Set is an UNORDERED collection of UNIQUE items.
// Unlike Lists (which use []), Sets use curly braces {}.
// The biggest difference: Sets do NOT allow duplicate values.
//
// Think of a Set like a bag of unique marbles — you can't have
// two identical marbles in the same bag.
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. BASIC SET — Creating a set using Set<T> type annotation
  //    Sets use curly braces {} unlike lists which use [].
  //    Set<String> means this set can ONLY hold String values.
  // ============================================================
  print('=== 1. Basic Set ===');

  Set<String> names = {'Mario', 'Luigi', 'Peach'};
  print('  names: $names'); // output: {Mario, Luigi, Peach}

  print('');

  // ============================================================
  // 2. DYNAMIC SET — Using 'var' without a type allows mixed types
  //    Dart infers the type as Set<Object>, so it can hold both
  //    int and String values in the same set.
  //    Use this when you need flexibility, but typed sets are
  //    preferred for type safety.
  // ============================================================
  print('=== 2. Dynamic Set ===');

  var mixedSet = {'Mario', 'Luigi', 1, 2, 3};
  print('  mixedSet: $mixedSet'); // output: {Mario, Luigi, 1, 2, 3}

  print('');

  // ============================================================
  // 3. add() — Adds a new value to the set
  //    If the value already exists, the set remains unchanged
  //    (no duplicates allowed). Returns true if the element was
  //    added, false if it was already present.
  // ============================================================
  print('=== 3. add() ===');

  Set<String> heroes = {'Mario', 'Luigi', 'Peach'};
  heroes.add('Bowser');
  print('  After adding Bowser: $heroes');
  // output: {Mario, Luigi, Peach, Bowser}

  heroes.add('Peach'); // Peach already exists — ignored!
  print('  After adding Peach again: $heroes');
  // output: {Mario, Luigi, Peach, Bowser}  (unchanged)

  print('');

  // ============================================================
  // 4. remove() — Removes a specific value from the set
  //    Returns true if the value was found and removed,
  //    false if the value was not in the set.
  // ============================================================
  print('=== 4. remove() ===');

  Set<String> team = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  team.remove('Luigi');
  print('  After removing Luigi: $team');
  // output: {Mario, Peach, Bowser}

  bool wasRemoved = team.remove('Yoshi'); // Yoshi not in set
  print('  Tried removing Yoshi (was removed?): $wasRemoved');
  // output: false

  print('');

  // ============================================================
  // 5. NO DUPLICATES — Sets automatically ignore duplicate values
  //    Even if you declare a set with duplicates, only unique
  //    values are kept. This is the #1 reason to use a Set
  //    instead of a List.
  // ============================================================
  print('=== 5. No Duplicates ===');

  // If you wrote: {'Mario', 'Luigi', 'Peach', 'Peach', 'Luigi'}
  // Dart would keep only unique values: {Mario, Luigi, Peach}
  // Here we demonstrate the same behavior using add():
  Set<String> dupeNames = {'Mario', 'Luigi', 'Peach'};
  dupeNames.add('Peach'); // duplicate — ignored
  dupeNames.add('Luigi'); // duplicate — ignored
  print('  After trying to add Peach & Luigi again: $dupeNames');
  // output: {Mario, Luigi, Peach}  (duplicates ignored automatically)

  print('');

  // ============================================================
  // 6. TYPE SAFETY — A Set<String> only accepts String values
  //    You cannot add a value of a different type to a typed set.
  //    Uncommenting the line below would cause a compile error:
  //    names.add(100);
  //    ERROR: The argument type 'int' can't be assigned to
  //           the parameter type 'String'
  // ============================================================
  print('=== 6. Type Safety ===');

  Set<String> strictNames = {'Mario', 'Luigi', 'Peach'};
  // strictNames.add(100); // COMPILE ERROR — int is not String
  print('  Set<String> only accepts Strings.');
  print('  strictNames.add(100) would cause a compile error.');
  print('  Current strictNames: $strictNames');

  print('');

  // ============================================================
  // 7. contains() — Checks if a specific value exists in the set
  //    Returns true if found, false otherwise.
  //    Very fast operation (O(1) on average) — much faster than
  //    searching through a List!
  // ============================================================
  print('=== 7. contains() ===');

  Set<String> characters = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  print('  Contains Luigi? ${characters.contains('Luigi')}');
  // output: true
  print('  Contains Yoshi? ${characters.contains('Yoshi')}');
  // output: false

  print('');

  // ============================================================
  // 8. length — Returns the total number of elements in the set
  //    This is a property (not a method), so no parentheses needed.
  // ============================================================
  print('=== 8. length ===');

  Set<String> roster = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  print('  Number of characters: ${roster.length}');
  // output: 4

  print('');
}

// =============================================================================
// NOTES: Basic Set Operations — Summary
// =============================================================================
//
// -----------------------------------------------------------------------
//  #  | TOPIC            | KEY CONCEPTS
// -----------------------------------------------------------------------
//  1  | Basic Set        | Set<T> type, curly braces {} syntax
//  2  | Dynamic Set      | var inference, Set<Object>, mixed types
//  3  | add()            | Add element, ignored if duplicate
//  4  | remove()         | Remove element, returns bool
//  5  | No Duplicates    | Automatic deduplication — core Set feature
//  6  | Type Safety      | Typed sets reject wrong types at compile time
//  7  | contains()       | O(1) lookup — fast membership check
//  8  | length           | Property returning element count
// -----------------------------------------------------------------------
//
// WHEN TO USE A SET INSTEAD OF A LIST:
//   - You need unique values only (no duplicates)
//   - You need fast lookups (contains() is O(1) vs O(n) for List)
//   - Order doesn't matter (Sets are unordered by default)
//   - You want to perform math operations (union, intersection, difference)
//
// SET vs LIST — Quick Comparison:
// ┌───────────────┬──────────────────────┬──────────────────────┐
// |  Feature      |  Set                 |  List                |
// |───────────────|──────────────────────|──────────────────────|
// |  Syntax       |  { }                 |  [ ]                 |
// |  Duplicates   |  NOT allowed         |  Allowed             |
// |  Order        |  Unordered           |  Ordered (indexed)   |
// |  contains()   |  O(1) — very fast    |  O(n) — slower       |
// |  Use case     |  Unique items, math  |  Ordered collections |
// └───────────────┴──────────────────────┴──────────────────────┘
//
// =============================================================================
