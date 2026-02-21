//------------------------------------------------------------------------------
// S E T S  —  S E T  M A T H  O P E R A T I O N S
//------------------------------------------------------------------------------
//
// Sets support powerful mathematical operations that make it easy
// to compare and combine collections of unique items.
//
// These operations come from Set Theory in mathematics:
//   - difference()    → elements in A but NOT in B
//   - intersection()  → elements in BOTH A and B
//   - union()         → ALL elements from A and B combined
//
// Think of two circles in a Venn diagram:
//   - difference   = left circle only (excluding the overlap)
//   - intersection = the overlapping middle part
//   - union        = both circles combined
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. difference() — Elements in the first set but NOT in the second
  //    Returns a NEW set (does not modify the originals).
  //    Think: "What does set A have that set B doesn't?"
  //
  //    names:    {Mario, Luigi, Peach, Bowser}
  //    villains: {Bowser, Wario}
  //    difference: everything in names that's NOT in villains
  // ============================================================
  print('=== 1. difference() ===');

  Set<String> names = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  Set<String> villains = {'Bowser', 'Wario'};

  Set<String> heroesOnly = names.difference(villains);
  print('  names: $names');
  print('  villains: $villains');
  print('  names.difference(villains): $heroesOnly');
  // output: {Mario, Luigi, Peach}
  // Bowser was removed because he's in villains.
  // Wario is NOT in the result because he wasn't in names.

  print('');

  // The ORDER matters! villains.difference(names) is different:
  Set<String> villainsOnly = villains.difference(names);
  print('  villains.difference(names): $villainsOnly');
  // output: {Wario}
  // Wario is the only villain NOT in names.

  print('');

  // ============================================================
  // 2. intersection() — Elements that exist in BOTH sets
  //    Returns a NEW set with only the common elements.
  //    Think: "What do these two sets have in common?"
  //
  //    names:    {Mario, Luigi, Peach, Bowser}
  //    villains: {Bowser, Wario}
  //    intersection: only elements in BOTH sets
  // ============================================================
  print('=== 2. intersection() ===');

  Set<String> names2 = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  Set<String> villains2 = {'Bowser', 'Wario'};

  Set<String> common = names2.intersection(villains2);
  print('  names2: $names2');
  print('  villains2: $villains2');
  print('  names2.intersection(villains2): $common');
  // output: {Bowser}
  // Only Bowser appears in BOTH sets.

  print('');

  // intersection() is commutative — order doesn't matter:
  Set<String> commonReversed = villains2.intersection(names2);
  print('  villains2.intersection(names2): $commonReversed');
  // output: {Bowser}  (same result!)

  print('');

  // ============================================================
  // 3. union() — Combines ALL elements from both sets
  //    Returns a NEW set with every element from both sets.
  //    Duplicates are automatically excluded (it's still a Set!).
  //    Think: "Merge these two sets together."
  //
  //    names:    {Mario, Luigi, Peach}
  //    villains: {Bowser, Wario}
  //    union: all elements from both sets
  // ============================================================
  print('=== 3. union() ===');

  Set<String> names3 = {'Mario', 'Luigi', 'Peach'};
  Set<String> villains3 = {'Bowser', 'Wario'};

  Set<String> everyone = names3.union(villains3);
  print('  names3: $names3');
  print('  villains3: $villains3');
  print('  names3.union(villains3): $everyone');
  // output: {Mario, Luigi, Peach, Bowser, Wario}

  print('');

  // Union with overlapping elements — duplicates are excluded:
  Set<String> names4 = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  Set<String> villains4 = {'Bowser', 'Wario'};

  Set<String> merged = names4.union(villains4);
  print('  names4 (has Bowser): $names4');
  print('  villains4 (also has Bowser): $villains4');
  print('  names4.union(villains4): $merged');
  // output: {Mario, Luigi, Peach, Bowser, Wario}
  // Bowser appears only ONCE even though he's in both sets.

  print('');

  // ============================================================
  // 4. isEmpty & isNotEmpty — Check if a set has elements
  //    isEmpty    → true if the set has NO elements
  //    isNotEmpty → true if the set has at LEAST one element
  //
  //    These are properties (not methods), so no parentheses.
  //    Useful for validation before performing operations.
  // ============================================================
  print('=== 4. isEmpty & isNotEmpty ===');

  Set<String> emptySet = {};
  Set<String> filledSet = {'Mario', 'Luigi'};

  print('  emptySet: $emptySet');
  print('  emptySet.isEmpty: ${emptySet.isEmpty}');       // true
  print('  emptySet.isNotEmpty: ${emptySet.isNotEmpty}'); // false

  print('');

  print('  filledSet: $filledSet');
  print('  filledSet.isEmpty: ${filledSet.isEmpty}');       // false
  print('  filledSet.isNotEmpty: ${filledSet.isNotEmpty}'); // true

  print('');

  // Practical example: check before processing
  Set<String> results = names.difference({'Mario', 'Luigi', 'Peach', 'Bowser'});
  if (results.isEmpty) {
    print('  No unique elements found after difference.');
  } else {
    print('  Unique elements: $results');
  }

  print('');
}

// =============================================================================
// NOTES: Set Math Operations — Summary
// =============================================================================
//
// -----------------------------------------------------------------------
//  #  | TOPIC            | KEY CONCEPTS
// -----------------------------------------------------------------------
//  1  | difference()     | Elements in A but NOT in B (order matters!)
//  2  | intersection()   | Elements in BOTH A and B (commutative)
//  3  | union()          | ALL elements from A and B (no duplicates)
//  4  | isEmpty/isNotEmpty | Check if a set has elements (properties)
// -----------------------------------------------------------------------
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
// IMPORTANT NOTES:
//   - difference() is NOT commutative: A.difference(B) != B.difference(A)
//   - intersection() IS commutative: A.intersection(B) == B.intersection(A)
//   - union() IS commutative: A.union(B) == B.union(A)
//   - All three operations return a NEW set (originals are not modified)
//   - isEmpty and isNotEmpty are properties, not methods (no parentheses)
//
// =============================================================================
