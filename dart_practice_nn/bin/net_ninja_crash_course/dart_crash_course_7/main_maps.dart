//------------------------------------------------------------------------------
// M A P S  I N  D A R T  —  C O M P L E T E  G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 4 samples into one runnable file.
// Maps are key-value pairs — like a dictionary or a phone book.
// You look up a KEY and get back its VALUE.
//
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                            | KEYWORDS USED                  | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Basic Map with var (int key)     | var, Map                       | Quick map creation with type inference
//  2  | Basic Map with var (String key)  | var, Map                       | Most common key type in real apps
//  3  | Typed Map with Map<K,V>          | Map<String, String>            | Explicit types for safety and clarity
//  4  | Access a value by key            | map[key]                       | Retrieve data from a map
//  5  | Update a value by key            | map[key] = newValue            | Modify existing entries
//  6  | Add a new key-value pair         | map[newKey] = value            | Expand a map with new data
//  7  | Check if a key exists            | .containsKey()                 | Avoid errors before accessing
//  8  | Check if a value exists          | .containsValue()               | Search for data without knowing the key
//  9  | Remove an entry by key           | .remove()                      | Delete data you no longer need
// 10  | Get all keys                     | .keys                          | List or loop through all keys
// 11  | Get all values                   | .values                        | List or loop through all values
// 12  | Get map length                   | .length                        | Know how many entries exist
// 13  | Check if map is empty            | .isEmpty, .isNotEmpty          | Guard against empty maps
// 14  | Add multiple entries at once     | .addAll()                      | Merge another map into yours
// 15  | Add only if key is absent        | .putIfAbsent()                 | Prevent overwriting existing data
// 16  | Loop through a map with forEach  | .forEach()                     | Process every key-value pair
// 17  | Loop through map entries         | .entries, for-in               | Access key and value together in a loop
// 18  | Transform values with .map()     | .map()                         | Create a new map with modified entries
// 19  | Clear all entries                | .clear()                       | Reset a map to empty
// 20  | Nested maps                      | Map<String, Map<String, String>> | Store structured/grouped data
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

  sample1Creating();
  sample2Checking();
  sample3Advanced();
  sample4Nested();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  CREATING & ACCESSING MAPS
//
//  Covers the basics of maps: creating with var or explicit types,
//  reading values by key, updating existing entries, and adding new ones.
//
//  Sections: 1-6
//
// =============================================================================
// =============================================================================

void sample1Creating() {
  print('');
  print('##############################################');
  print('# SAMPLE 1: Creating & Accessing Maps         #');
  print('##############################################');

  // ============================================================
  // 1. BASIC MAP WITH var (int key) - Dart infers the types
  //    When the key is an int, Dart creates a Map<int, String>.
  //    Good for quick experiments or small scripts.
  // ============================================================
  var planets1 = {
    1: 'Mercury',
  };
  print('  1. var with int key: $planets1'); // {1: Mercury}

  // ============================================================
  // 2. BASIC MAP WITH var (String key) - Most common form
  //    Dart infers Map<String, String> automatically.
  //    Keys and values are both Strings.
  // ============================================================
  var planets2 = {
    'First': 'Mercury',
  };
  print('  2. var with String key: $planets2'); // {First: Mercury}

  // ============================================================
  // 3. TYPED MAP WITH Map<K,V> - Explicit key and value types
  //    Recommended for production code because the compiler
  //    catches type mistakes at compile time.
  // ============================================================
  Map<String, String> planets3 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print('  3. Typed Map<String, String>: $planets3');

  // ============================================================
  // 4. ACCESS A VALUE BY KEY - Use map[key] to get a value
  //    Returns null if the key doesn't exist (won't crash).
  // ============================================================
  Map<String, String> planets4 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print('  4. Access ["Fifth"]: ${planets4["Fifth"]}'); // Jupiter
  print('     Access ["Tenth"]: ${planets4["Tenth"]}'); // null

  // ============================================================
  // 5. UPDATE A VALUE BY KEY - Assign a new value to an existing key
  //    The old value is replaced. The key stays the same.
  // ============================================================
  Map<String, String> planets5 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  planets5['Fifth'] = 'Saturn';
  print('  5. Updated ["Fifth"]: ${planets5["Fifth"]}'); // Saturn

  // ============================================================
  // 6. ADD A NEW KEY-VALUE PAIR - Same syntax as updating
  //    If the key doesn't exist yet, it creates a new entry.
  // ============================================================
  Map<String, String> planets6 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  planets6['Sixth'] = 'Saturn';
  planets6['Seventh'] = 'Uranus';
  print('  6. After adding: $planets6');

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  CHECKING & QUERYING MAPS
//
//  All the "question-asking" methods: does a key/value exist?
//  How many entries? Is the map empty? Plus removing entries.
//
//  Sections: 7-13
//
// =============================================================================
// =============================================================================

void sample2Checking() {
  print('##############################################');
  print('# SAMPLE 2: Checking & Querying               #');
  print('##############################################');

  // ============================================================
  // 7. CHECK IF A KEY EXISTS - .containsKey() returns true/false
  //    Use before accessing a key to avoid unexpected nulls.
  // ============================================================
  Map<String, String> planets7 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print('  7. containsKey("First"): ${planets7.containsKey("First")}'); // true
  print('     containsKey("Tenth"): ${planets7.containsKey("Tenth")}'); // false

  // ============================================================
  // 8. CHECK IF A VALUE EXISTS - .containsValue() returns true/false
  //    Useful when you know the value but not the key.
  // ============================================================
  Map<String, String> planets8 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print('  8. containsValue("Mercury"): ${planets8.containsValue("Mercury")}'); // true
  print('     containsValue("Pluto"): ${planets8.containsValue("Pluto")}'); // false

  // ============================================================
  // 9. REMOVE AN ENTRY BY KEY - .remove() deletes and returns the value
  //    Returns the removed value, or null if the key wasn't found.
  // ============================================================
  Map<String, String> planets9 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print('  9. Removed: ${planets9.remove("First")}'); // Mercury
  print('     After remove: $planets9');

  // ============================================================
  // 10. GET ALL KEYS - .keys returns an Iterable of all keys
  //     Useful for looping through keys or converting to a List.
  // ============================================================
  Map<String, String> planets10 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
  };
  print('  10. Keys: ${planets10.keys}'); // (First, Second, Third)
  print('      Keys as List: ${planets10.keys.toList()}');

  // ============================================================
  // 11. GET ALL VALUES - .values returns an Iterable of all values
  //     Same as .keys but for the value side of each entry.
  // ============================================================
  Map<String, String> planets11 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
  };
  print('  11. Values: ${planets11.values}'); // (Mercury, Venus, Earth)
  print('      Values as List: ${planets11.values.toList()}');

  // ============================================================
  // 12. GET MAP LENGTH - .length returns the number of entries
  //     Handy for conditions or displaying counts.
  // ============================================================
  Map<String, String> planets12 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print('  12. Total planets: ${planets12.length}'); // 5

  // ============================================================
  // 13. CHECK IF MAP IS EMPTY - .isEmpty / .isNotEmpty
  //     Always check before accessing data to avoid errors.
  // ============================================================
  Map<String, String> emptyMap = {};
  Map<String, String> planets13 = {'First': 'Mercury'};

  print('  13. emptyMap.isEmpty: ${emptyMap.isEmpty}'); // true
  print('      emptyMap.isNotEmpty: ${emptyMap.isNotEmpty}'); // false
  print('      planets13.isEmpty: ${planets13.isEmpty}'); // false
  print('      planets13.isNotEmpty: ${planets13.isNotEmpty}'); // true

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  3:  ADVANCED MAP OPERATIONS
//
//  Power tools for maps: merging, safe insertion, looping,
//  transforming, and clearing.
//
//  Sections: 14-19
//
// =============================================================================
// =============================================================================

void sample3Advanced() {
  print('##############################################');
  print('# SAMPLE 3: Advanced Operations               #');
  print('##############################################');

  // ============================================================
  // 14. ADD MULTIPLE ENTRIES AT ONCE - .addAll() merges maps
  //     If a key already exists, its value gets overwritten.
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
  print('  14. After addAll: $planets14');

  // ============================================================
  // 15. ADD ONLY IF KEY IS ABSENT - .putIfAbsent()
  //     Adds the key-value pair ONLY if the key doesn't exist yet.
  //     Prevents accidentally overwriting existing data.
  // ============================================================
  Map<String, String> planets15 = {
    'First': 'Mercury',
    'Second': 'Venus',
  };
  planets15.putIfAbsent('Third', () => 'Earth'); // added
  planets15.putIfAbsent('First', () => 'Pluto'); // ignored (key exists)
  print('  15. After putIfAbsent: $planets15');
  // First is still Mercury, NOT Pluto

  // ============================================================
  // 16. LOOP THROUGH A MAP WITH forEach - Process every entry
  //     The callback receives the key and value as parameters.
  // ============================================================
  Map<String, String> planets16 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print('  16. forEach loop:');
  planets16.forEach((key, value) {
    print('      $key planet is $value');
  });

  // ============================================================
  // 17. LOOP THROUGH MAP ENTRIES - .entries gives MapEntry objects
  //     Each entry has a .key and .value property.
  //     Works great with for-in loops.
  // ============================================================
  Map<String, String> planets17 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
  };
  print('  17. for-in with .entries:');
  for (var entry in planets17.entries) {
    print('      Key: ${entry.key}, Value: ${entry.value}');
  }

  // ============================================================
  // 18. TRANSFORM VALUES WITH .map() - Create a new map
  //     Returns a NEW map with transformed keys and/or values.
  //     The original map stays unchanged.
  // ============================================================
  Map<String, String> planets18 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
  };
  var uppercasedPlanets = planets18.map((key, value) {
    return MapEntry(key, value.toUpperCase());
  });
  print('  18. Transformed: $uppercasedPlanets');
  print('      Original:    $planets18');

  // ============================================================
  // 19. CLEAR ALL ENTRIES - .clear() removes everything
  //     The map becomes empty but still exists.
  //     Use when you want to reset a map without creating a new one.
  // ============================================================
  Map<String, String> planets19 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
  };
  print('  19. Before clear: $planets19');
  planets19.clear();
  print('      After clear:  $planets19'); // {}

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  4:  NESTED MAPS
//
//  Maps inside maps for structured, grouped data.
//  Common for JSON-like structures and configuration.
//
//  Section: 20
//
// =============================================================================
// =============================================================================

void sample4Nested() {
  print('##############################################');
  print('# SAMPLE 4: Nested Maps                       #');
  print('##############################################');

  // ============================================================
  // 20. NESTED MAPS - Maps inside maps for structured data
  //     Common for grouping related data (like JSON structures).
  //     Access nested values with chained bracket notation.
  // ============================================================
  Map<String, Map<String, String>> solarSystem = {
    'Mercury': {'type': 'Terrestrial', 'position': '1st'},
    'Venus': {'type': 'Terrestrial', 'position': '2nd'},
    'Earth': {'type': 'Terrestrial', 'position': '3rd'},
    'Jupiter': {'type': 'Gas Giant', 'position': '5th'},
  };

  // Access the entire inner map
  print('  20. Earth details: ${solarSystem["Earth"]}');
  // {type: Terrestrial, position: 3rd}

  // Access a specific nested value (use ?[] for null safety)
  print('      Earth type: ${solarSystem["Earth"]?["type"]}');
  // Terrestrial
  print('      Jupiter position: ${solarSystem["Jupiter"]?["position"]}');
  // 5th

  // Loop through nested maps
  print('');
  print('  All planets:');
  solarSystem.forEach((planet, details) {
    print('      $planet -> Type: ${details["type"]}, Position: ${details["position"]}');
  });
  // Output:
  // Mercury -> Type: Terrestrial, Position: 1st
  // Venus -> Type: Terrestrial, Position: 2nd
  // Earth -> Type: Terrestrial, Position: 3rd
  // Jupiter -> Type: Gas Giant, Position: 5th

  print('');
}

// =============================================================================
// =============================================================================
//  NOTES: Maps in Dart — Complete Summary of ALL 4 Samples
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | TOPIC                            | KEY CONCEPTS
//  -----------------------------------------------------------------------
//   1  | Basic Map with var (int key)     | var, type inference
//   2  | Basic Map with var (String key)  | var, most common form
//   3  | Typed Map with Map<K,V>          | Map<String, String>, compile-time safety
//   4  | Access a value by key            | map[key], returns null if missing
//   5  | Update a value by key            | map[key] = newValue
//   6  | Add a new key-value pair         | map[newKey] = value
//   7  | Check if a key exists            | .containsKey()
//   8  | Check if a value exists          | .containsValue()
//   9  | Remove an entry by key           | .remove(), returns removed value
//  10  | Get all keys                     | .keys, Iterable
//  11  | Get all values                   | .values, Iterable
//  12  | Get map length                   | .length
//  13  | Check if map is empty            | .isEmpty, .isNotEmpty
//  14  | Add multiple entries at once     | .addAll(), merges maps
//  15  | Add only if key is absent        | .putIfAbsent(), safe insertion
//  16  | Loop through a map with forEach  | .forEach((k, v) {...})
//  17  | Loop through map entries         | .entries, for-in loop
//  18  | Transform values with .map()     | .map(), returns new map
//  19  | Clear all entries                | .clear(), empties the map
//  20  | Nested maps                      | Map<K, Map<K2, V2>>, ?[] access
//  -----------------------------------------------------------------------
//
//  ALL MAP METHODS & PROPERTIES COVERED:
//  ┌────────────────────────────┬────────────────────────────────────────────┐
//  |  Method / Property         |  What it does                             |
//  |────────────────────────────|────────────────────────────────────────────|
//  |  map[key]                  |  Access value by key (Sample 1)           |
//  |  map[key] = value          |  Set/update value (Sample 1)              |
//  |  .containsKey()            |  Check if key exists (Sample 2)           |
//  |  .containsValue()          |  Check if value exists (Sample 2)         |
//  |  .remove()                 |  Remove entry by key (Sample 2)           |
//  |  .keys                     |  Get all keys as Iterable (Sample 2)      |
//  |  .values                   |  Get all values as Iterable (Sample 2)    |
//  |  .length                   |  Number of entries (Sample 2)             |
//  |  .isEmpty / .isNotEmpty    |  Check if map has entries (Sample 2)      |
//  |  .addAll()                 |  Merge another map (Sample 3)             |
//  |  .putIfAbsent()            |  Add only if key missing (Sample 3)       |
//  |  .forEach()                |  Loop with callback (Sample 3)            |
//  |  .entries                  |  Get MapEntry objects (Sample 3)          |
//  |  .map()                    |  Transform to new map (Sample 3)          |
//  |  .clear()                  |  Remove all entries (Sample 3)            |
//  |  Nested access ?[]         |  Null-safe nested lookup (Sample 4)       |
//  └────────────────────────────┴────────────────────────────────────────────┘
//
//  QUICK REFERENCE — Creating Maps:
//  ┌──────────────────────────────────────────────────────────────────────┐
//  |  var map = {1: "a"}              — type inference (quick)           |
//  |  var map = {"key": "val"}        — most common form                |
//  |  Map<String, String> map = {}    — explicit types (recommended)    |
//  |  Map<K, Map<K2, V2>> nested = {} — nested maps (structured data)  |
//  └──────────────────────────────────────────────────────────────────────┘
//
//  QUICK REFERENCE — Reading vs Writing:
//  ┌──────────────────────────┬──────────────────────────────────────────┐
//  |  Reading (non-destructive)|  Writing (modifies the map)             |
//  |──────────────────────────|──────────────────────────────────────────|
//  |  map[key]                |  map[key] = value                       |
//  |  .containsKey()          |  .addAll()                              |
//  |  .containsValue()        |  .putIfAbsent()                         |
//  |  .keys / .values         |  .remove()                              |
//  |  .length                 |  .clear()                               |
//  |  .isEmpty / .isNotEmpty  |                                         |
//  |  .entries                |                                         |
//  |  .forEach() / .map()     |                                         |
//  └──────────────────────────┴──────────────────────────────────────────┘
//
//  This is the pattern you'll use in Flutter apps, server apps,
//  and anywhere else you work with key-value data in Dart.
// =============================================================================
