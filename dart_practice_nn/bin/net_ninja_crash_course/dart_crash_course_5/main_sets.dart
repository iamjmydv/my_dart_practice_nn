//------------------------------------------------------------------------------
// S E T S  —  C O M P L E T E  G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 2 samples into one runnable file.
// A Set is an UNORDERED collection of UNIQUE items.
// Unlike Lists (which use []), Sets use curly braces {}.
// The biggest difference: Sets do NOT allow duplicate values.
//
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                    | KEY CONCEPTS                              | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Basic Set Operations     | Set<T>, var, add, remove, contains,       | Core CRUD operations on Sets
//     |                          | length, no duplicates, type safety        |
//  2  | Set Math Operations      | difference, intersection, union,          | Powerful comparisons & combinations
//     |                          | isEmpty, isNotEmpty                       |
// -----------------------------------------------------------------------
//
// TIP: To run just ONE sample, comment out the other in main().
//
// -----------------------------------------------------------------------

void main() {
  // ============================================================
  //  Uncomment/comment any sample to run only what you want.
  //  Each sample is independent — they don't depend on each other.
  // ============================================================

  sample1BasicSetOps();
  sample2SetMathOps();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  BASIC SET OPERATIONS
//
//  Covers creating sets, adding/removing elements, the no-duplicates
//  behavior, type safety, and checking membership with contains().
//
//  Think of a Set like a bag of unique marbles — you can't have
//  two identical marbles in the same bag.
//
// -----------------------------------------------------------------------
//  #  | WHAT IT COVERS                      | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Basic Set (Set<String>)             | Creating a typed set
//  2  | Dynamic Set (var)                   | Mixed types with inference
//  3  | add()                               | Adding elements (ignores dupes)
//  4  | remove()                            | Removing elements
//  5  | No Duplicates                       | Core Set feature
//  6  | Type Safety                         | Compile-time type checking
//  7  | contains()                          | Fast O(1) membership check
//  8  | length                              | Element count property
// -----------------------------------------------------------------------
//
// =============================================================================
// =============================================================================

void sample1BasicSetOps() {
  print('');
  print('##############################################');
  print('# SAMPLE 1: Basic Set Operations             #');
  print('##############################################');
  print('');

  // ============================================================
  // 1. BASIC SET — Creating a set using Set<T> type annotation
  //    Sets use curly braces {} unlike lists which use [].
  //    Set<String> means this set can ONLY hold String values.
  // ============================================================
  print('  === 1. Basic Set ===');

  Set<String> names = {'Mario', 'Luigi', 'Peach'};
  print('    names: $names'); // output: {Mario, Luigi, Peach}

  print('');

  // ============================================================
  // 2. DYNAMIC SET — Using 'var' without a type allows mixed types
  //    Dart infers the type as Set<Object>, so it can hold both
  //    int and String values in the same set.
  // ============================================================
  print('  === 2. Dynamic Set ===');

  var mixedSet = {'Mario', 'Luigi', 1, 2, 3};
  print('    mixedSet: $mixedSet'); // output: {Mario, Luigi, 1, 2, 3}

  print('');

  // ============================================================
  // 3. add() — Adds a new value to the set
  //    If the value already exists, the set remains unchanged.
  // ============================================================
  print('  === 3. add() ===');

  Set<String> heroes = {'Mario', 'Luigi', 'Peach'};
  heroes.add('Bowser');
  print('    After adding Bowser: $heroes');
  // output: {Mario, Luigi, Peach, Bowser}

  heroes.add('Peach'); // Peach already exists — ignored!
  print('    After adding Peach again: $heroes');
  // output: {Mario, Luigi, Peach, Bowser}  (unchanged)

  print('');

  // ============================================================
  // 4. remove() — Removes a specific value from the set
  //    Returns true if the value was found and removed,
  //    false if the value was not in the set.
  // ============================================================
  print('  === 4. remove() ===');

  Set<String> team = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  team.remove('Luigi');
  print('    After removing Luigi: $team');
  // output: {Mario, Peach, Bowser}

  bool wasRemoved = team.remove('Yoshi'); // Yoshi not in set
  print('    Tried removing Yoshi (was removed?): $wasRemoved');
  // output: false

  print('');

  // ============================================================
  // 5. NO DUPLICATES — Sets automatically ignore duplicate values
  //    This is the #1 reason to use a Set instead of a List.
  // ============================================================
  print('  === 5. No Duplicates ===');

  Set<String> dupeNames = {'Mario', 'Luigi', 'Peach'};
  dupeNames.add('Peach'); // duplicate — ignored
  dupeNames.add('Luigi'); // duplicate — ignored
  print('    After trying to add Peach & Luigi again: $dupeNames');
  // output: {Mario, Luigi, Peach}  (duplicates ignored)

  print('');

  // ============================================================
  // 6. TYPE SAFETY — A Set<String> only accepts String values
  //    You cannot add a value of a different type to a typed set.
  //    strictNames.add(100) would cause a compile error.
  // ============================================================
  print('  === 6. Type Safety ===');

  Set<String> strictNames = {'Mario', 'Luigi', 'Peach'};
  // strictNames.add(100); // COMPILE ERROR — int is not String
  print('    Set<String> only accepts Strings.');
  print('    strictNames.add(100) would cause a compile error.');
  print('    Current strictNames: $strictNames');

  print('');

  // ============================================================
  // 7. contains() — Checks if a specific value exists in the set
  //    Returns true if found, false otherwise.
  //    Very fast (O(1) on average) — much faster than List!
  // ============================================================
  print('  === 7. contains() ===');

  Set<String> characters = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  print('    Contains Luigi? ${characters.contains('Luigi')}');
  // output: true
  print('    Contains Yoshi? ${characters.contains('Yoshi')}');
  // output: false

  print('');

  // ============================================================
  // 8. length — Returns the total number of elements in the set
  //    This is a property (not a method), so no parentheses.
  // ============================================================
  print('  === 8. length ===');

  Set<String> roster = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  print('    Number of characters: ${roster.length}');
  // output: 4

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  SET MATH OPERATIONS
//
//  Sets support powerful mathematical operations from Set Theory:
//    - difference()    -> elements in A but NOT in B
//    - intersection()  -> elements in BOTH A and B
//    - union()         -> ALL elements from A and B combined
//
//  Think of two circles in a Venn diagram:
//    - difference   = left circle only (excluding the overlap)
//    - intersection = the overlapping middle part
//    - union        = both circles combined
//
// -----------------------------------------------------------------------
//  #  | WHAT IT COVERS                      | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | difference()                        | Find unique-to-one-set elements
//  2  | intersection()                      | Find common elements
//  3  | union()                             | Merge sets (no duplicates)
//  4  | isEmpty & isNotEmpty                | Check if set has elements
// -----------------------------------------------------------------------
//
// =============================================================================
// =============================================================================

void sample2SetMathOps() {
  print('##############################################');
  print('# SAMPLE 2: Set Math Operations              #');
  print('##############################################');
  print('');

  // ============================================================
  // 1. difference() — Elements in the first set but NOT in the second
  //    Returns a NEW set (does not modify the originals).
  //    Think: "What does set A have that set B doesn't?"
  //    IMPORTANT: Order matters! A.difference(B) != B.difference(A)
  // ============================================================
  print('  === 1. difference() ===');

  Set<String> names = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  Set<String> villains = {'Bowser', 'Wario'};

  Set<String> heroesOnly = names.difference(villains);
  print('    names: $names');
  print('    villains: $villains');
  print('    names.difference(villains): $heroesOnly');
  // output: {Mario, Luigi, Peach}

  // The ORDER matters! villains.difference(names) is different:
  Set<String> villainsOnly = villains.difference(names);
  print('    villains.difference(names): $villainsOnly');
  // output: {Wario}

  print('');

  // ============================================================
  // 2. intersection() — Elements that exist in BOTH sets
  //    Returns a NEW set with only the common elements.
  //    Think: "What do these two sets have in common?"
  //    Commutative: A.intersection(B) == B.intersection(A)
  // ============================================================
  print('  === 2. intersection() ===');

  Set<String> names2 = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  Set<String> villains2 = {'Bowser', 'Wario'};

  Set<String> common = names2.intersection(villains2);
  print('    names2: $names2');
  print('    villains2: $villains2');
  print('    names2.intersection(villains2): $common');
  // output: {Bowser}

  // Commutative — order doesn't matter:
  Set<String> commonReversed = villains2.intersection(names2);
  print('    villains2.intersection(names2): $commonReversed');
  // output: {Bowser}  (same result!)

  print('');

  // ============================================================
  // 3. union() — Combines ALL elements from both sets
  //    Returns a NEW set with every element from both sets.
  //    Duplicates are automatically excluded (it's still a Set!).
  //    Think: "Merge these two sets together."
  // ============================================================
  print('  === 3. union() ===');

  Set<String> names3 = {'Mario', 'Luigi', 'Peach'};
  Set<String> villains3 = {'Bowser', 'Wario'};

  Set<String> everyone = names3.union(villains3);
  print('    names3: $names3');
  print('    villains3: $villains3');
  print('    names3.union(villains3): $everyone');
  // output: {Mario, Luigi, Peach, Bowser, Wario}

  // Union with overlapping elements — duplicates excluded:
  Set<String> names4 = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  Set<String> villains4 = {'Bowser', 'Wario'};

  Set<String> merged = names4.union(villains4);
  print('    names4 (has Bowser): $names4');
  print('    villains4 (also has Bowser): $villains4');
  print('    names4.union(villains4): $merged');
  // output: {Mario, Luigi, Peach, Bowser, Wario}
  // Bowser appears only ONCE even though he's in both sets.

  print('');

  // ============================================================
  // 4. isEmpty & isNotEmpty — Check if a set has elements
  //    isEmpty    -> true if the set has NO elements
  //    isNotEmpty -> true if the set has at LEAST one element
  //    Properties (not methods) — no parentheses needed.
  // ============================================================
  print('  === 4. isEmpty & isNotEmpty ===');

  Set<String> emptySet = {};
  Set<String> filledSet = {'Mario', 'Luigi'};

  print('    emptySet: $emptySet');
  print('    emptySet.isEmpty: ${emptySet.isEmpty}');       // true
  print('    emptySet.isNotEmpty: ${emptySet.isNotEmpty}'); // false

  print('');

  print('    filledSet: $filledSet');
  print('    filledSet.isEmpty: ${filledSet.isEmpty}');       // false
  print('    filledSet.isNotEmpty: ${filledSet.isNotEmpty}'); // true

  print('');

  // Practical example: check before processing
  Set<String> results = names.difference({'Mario', 'Luigi', 'Peach', 'Bowser'});
  if (results.isEmpty) {
    print('    No unique elements found after difference.');
  } else {
    print('    Unique elements: $results');
  }

  print('');
}

// =============================================================================
// =============================================================================
//  NOTES: Sets — Complete Summary of ALL 2 Samples
// =============================================================================
//
// -----------------------------------------------------------------------
//  #  | TOPIC                    | KEY CONCEPTS
// -----------------------------------------------------------------------
//  1  | Basic Set Operations     | Set<T>, var, add(), remove(), contains(),
//     |                          | length, no duplicates, type safety
//  2  | Set Math Operations      | difference(), intersection(), union(),
//     |                          | isEmpty, isNotEmpty
// -----------------------------------------------------------------------
//
// SET METHODS & PROPERTIES COVERED:
// ┌────────────────────────────┬────────────────────────────────────────────┐
// |  Method / Property         |  What it does                             |
// |────────────────────────────|────────────────────────────────────────────|
// |  add()                     |  Add an element (ignored if duplicate)    |
// |  remove()                  |  Remove an element (returns bool)         |
// |  contains()                |  Check if element exists (O(1) fast!)     |
// |  length                    |  Number of elements in the set            |
// |  difference()              |  Elements in A but NOT in B               |
// |  intersection()            |  Elements in BOTH A and B                 |
// |  union()                   |  ALL elements from A and B combined       |
// |  isEmpty                   |  True if set has no elements              |
// |  isNotEmpty                |  True if set has at least one element     |
// └────────────────────────────┴────────────────────────────────────────────┘
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
// VENN DIAGRAM CHEAT SHEET:
//
//        Set A             Set B
//    ┌──────────┐     ┌──────────┐
//    |          |     |          |
//    |    A     |  AB |     B    |
//    |  only    |     |   only   |
//    |          |     |          |
//    └──────────┘     └──────────┘
//
//    A.difference(B)    = A only      (left circle minus overlap)
//    B.difference(A)    = B only      (right circle minus overlap)
//    A.intersection(B)  = AB          (the overlap)
//    A.union(B)         = A + AB + B  (everything)
//
// KEY RULES:
//   - difference() is NOT commutative: A.difference(B) != B.difference(A)
//   - intersection() IS commutative: A.intersection(B) == B.intersection(A)
//   - union() IS commutative: A.union(B) == B.union(A)
//   - All math operations return a NEW set (originals are not modified)
//   - Sets automatically ignore duplicates — this is their #1 feature
//   - contains() on a Set is O(1) — much faster than List's O(n)
//
// WHEN TO USE A SET:
//   - You need unique values only (no duplicates)
//   - You need fast lookups (contains() is O(1))
//   - Order doesn't matter
//   - You want to perform set math (union, intersection, difference)
//
// =============================================================================
