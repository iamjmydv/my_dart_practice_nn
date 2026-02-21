//------------------------------------------------------------------------------
// M A P S - I N - D A R T
//------------------------------------------------------------------------------
// SAMPLE 3: ADVANCED MAP OPERATIONS
//------------------------------------------------------------------------------
//
// Now that you know how to create, access, and query maps,
// it's time for the POWER TOOLS — methods that let you
// modify, merge, loop, and transform maps efficiently.
//
// These operations are used constantly in real apps:
//   - Merging API responses together (.addAll)
//   - Setting default values safely (.putIfAbsent)
//   - Processing every entry (.forEach, .entries)
//   - Transforming data for display (.map)
//   - Resetting state (.clear)
//
// -----------------------------------------------------------------------
//  #  | TOPIC                            | KEYWORDS USED                  | WHY IT'S USEFUL
// -----------------------------------------------------------------------
// 14  | Add multiple entries at once     | .addAll()                      | Merge another map into yours
// 15  | Add only if key is absent        | .putIfAbsent()                 | Prevent overwriting existing data
// 16  | Loop through a map with forEach  | .forEach()                     | Process every key-value pair
// 17  | Loop through map entries         | .entries, for-in               | Access key and value together in a loop
// 18  | Transform values with .map()     | .map()                         | Create a new map with modified entries
// 19  | Clear all entries                | .clear()                       | Reset a map to empty
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 14. ADD MULTIPLE ENTRIES AT ONCE - .addAll() merges maps
  //     If a key already exists, its value gets overwritten.
  //
  //     Think of it like pouring one jar of marbles into another.
  //     If both jars have a marble labeled "red", the new one
  //     replaces the old one.
  //
  //     Syntax: map.addAll({ key1: val1, key2: val2 });
  // ============================================================
  Map<String, String> planets14 = {
    'First': 'Mercury',
    'Second': 'Venus',
  };
  planets14.addAll({
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  });
  print(planets14);
  // {First: Mercury, Second: Venus, Third: Earth, Fourth: Mars, Fifth: Jupiter}

  // Demonstration: addAll overwrites existing keys
  Map<String, String> original = {'a': 'apple', 'b': 'banana'};
  original.addAll({'b': 'blueberry', 'c': 'cherry'});
  print(original); // {a: apple, b: blueberry, c: cherry}
  // Notice: 'b' changed from 'banana' to 'blueberry'

  // ============================================================
  // 15. ADD ONLY IF KEY IS ABSENT - .putIfAbsent()
  //     Adds the key-value pair ONLY if the key doesn't exist yet.
  //     Prevents accidentally overwriting existing data.
  //
  //     Syntax: map.putIfAbsent(key, () => value);
  //     The second argument is a FUNCTION that returns the value.
  //     This function only runs if the key is actually absent.
  //
  //     Think of it like: "Put this here, but ONLY if the spot is empty."
  // ============================================================
  Map<String, String> planets15 = {
    'First': 'Mercury',
    'Second': 'Venus',
  };
  planets15.putIfAbsent('Third', () => 'Earth'); // added (key was absent)
  planets15.putIfAbsent('First', () => 'Pluto'); // ignored (key already exists)
  print(planets15); // {First: Mercury, Second: Venus, Third: Earth}
  // "First" is still Mercury, NOT Pluto — putIfAbsent protected it!

  // ============================================================
  // 16. LOOP THROUGH A MAP WITH forEach - Process every entry
  //     The callback receives the key and value as parameters.
  //
  //     Syntax: map.forEach((key, value) { ... });
  //     This runs the function once for EACH entry in the map.
  //     Great for printing, logging, or processing all entries.
  // ============================================================
  Map<String, String> planets16 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  planets16.forEach((key, value) {
    print('$key planet is $value');
  });
  // Output:
  // First planet is Mercury
  // Second planet is Venus
  // Third planet is Earth
  // Fourth planet is Mars
  // Fifth planet is Jupiter

  // ============================================================
  // 17. LOOP THROUGH MAP ENTRIES - .entries gives MapEntry objects
  //     Each entry has a .key and .value property.
  //     Works great with for-in loops.
  //
  //     .entries returns an Iterable<MapEntry<K,V>>.
  //     Each MapEntry is like a small box holding one key and one value.
  //
  //     Difference from forEach:
  //     - forEach: callback style (no break/continue)
  //     - for-in with .entries: loop style (supports break/continue)
  // ============================================================
  Map<String, String> planets17 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
  };
  for (var entry in planets17.entries) {
    print('Key: ${entry.key}, Value: ${entry.value}');
  }
  // Output:
  // Key: First, Value: Mercury
  // Key: Second, Value: Venus
  // Key: Third, Value: Earth

  // Bonus: you can use break/continue with for-in (not with forEach)
  print('--- Finding Earth with for-in + break ---');
  for (var entry in planets17.entries) {
    if (entry.value == 'Earth') {
      print('Found Earth at key: ${entry.key}');
      break; // stop searching after finding it
    }
  }

  // ============================================================
  // 18. TRANSFORM VALUES WITH .map() - Create a new map
  //     Returns a NEW map with transformed keys and/or values.
  //     The original map stays unchanged.
  //
  //     Syntax: map.map((key, value) => MapEntry(newKey, newValue));
  //     You return a MapEntry for each entry in the map.
  //     This is like applying a filter or transformation to every entry.
  //
  //     NOTE: This is the MAP method (not to be confused with the
  //     Map data type). The method name is .map() with a lowercase 'm'.
  // ============================================================
  Map<String, String> planets18 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
  };
  var uppercasedPlanets = planets18.map((key, value) {
    return MapEntry(key, value.toUpperCase());
  });
  print(uppercasedPlanets); // {First: MERCURY, Second: VENUS, Third: EARTH}
  print(planets18); // {First: Mercury, Second: Venus, Third: Earth} (original is unchanged)

  // Another example: transform both keys and values
  var numberedPlanets = planets18.map((key, value) {
    return MapEntry(key.toLowerCase(), '*** $value ***');
  });
  print(numberedPlanets); // {first: *** Mercury ***, second: *** Venus ***, third: *** Earth ***}

  // ============================================================
  // 19. CLEAR ALL ENTRIES - .clear() removes everything
  //     The map becomes empty but still exists.
  //     Use when you want to reset a map without creating a new one.
  //
  //     After .clear(), the map has 0 entries but the variable
  //     still points to the same Map object.
  //     This is useful for resetting state in apps.
  // ============================================================
  Map<String, String> planets19 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
  };
  print('Before clear: $planets19');
  // Before clear: {First: Mercury, Second: Venus, Third: Earth}
  planets19.clear();
  print('After clear: $planets19'); // After clear: {}
  print('Is empty? ${planets19.isEmpty}'); // Is empty? true
}

// ============================================================
// NOTES: Advanced Map Operations — Summary
// ============================================================
// 14.  .addAll({...})              — merge another map (overwrites existing keys)
// 15.  .putIfAbsent(key, () => v)  — add ONLY if the key doesn't exist
// 16.  .forEach((k, v) {...})      — loop with callback (no break/continue)
// 17.  .entries + for-in           — loop with MapEntry (supports break/continue)
// 18.  .map((k, v) => MapEntry())  — transform and return a NEW map
// 19.  .clear()                    — remove all entries (map still exists)
//
//  KEY TAKEAWAYS:
//  - .addAll() is great for merging data, but watch out for key collisions
//  - .putIfAbsent() is safer than direct assignment when you want to keep existing data
//  - Use .forEach() for simple iteration, .entries for-in when you need break/continue
//  - .map() creates a NEW map — the original is never modified
//  - .clear() empties the map but doesn't delete the variable itself
//
//  WHEN TO USE WHAT:
//  ┌──────────────────────────┬──────────────────────────────────────────┐
//  |  Need to...              |  Use this                                |
//  |──────────────────────────|──────────────────────────────────────────|
//  |  Add many entries        |  .addAll()                               |
//  |  Add without overwriting |  .putIfAbsent()                          |
//  |  Process all entries     |  .forEach() or for-in with .entries      |
//  |  Transform all entries   |  .map()                                  |
//  |  Reset/empty the map     |  .clear()                                |
//  └──────────────────────────┴──────────────────────────────────────────┘
// ============================================================
