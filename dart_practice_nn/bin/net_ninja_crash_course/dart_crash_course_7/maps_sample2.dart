//------------------------------------------------------------------------------
// M A P S - I N - D A R T
//------------------------------------------------------------------------------
// SAMPLE 2: CHECKING & QUERYING MAPS
//------------------------------------------------------------------------------
//
// Before you access, modify, or display data from a map, you often need
// to CHECK things first:
//   - Does this key exist?
//   - Does this value exist anywhere?
//   - How many entries are in the map?
//   - Is the map empty?
//
// This sample covers all the "question-asking" methods of maps.
// These are essential for writing safe, bug-free code.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                            | KEYWORDS USED                  | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  7  | Check if a key exists            | .containsKey()                 | Avoid errors before accessing
//  8  | Check if a value exists          | .containsValue()               | Search for data without knowing the key
//  9  | Remove an entry by key           | .remove()                      | Delete data you no longer need
// 10  | Get all keys                     | .keys                          | List or loop through all keys
// 11  | Get all values                   | .values                        | List or loop through all values
// 12  | Get map length                   | .length                        | Know how many entries exist
// 13  | Check if map is empty            | .isEmpty, .isNotEmpty          | Guard against empty maps
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 7. CHECK IF A KEY EXISTS - .containsKey() returns true/false
  //    Use before accessing a key to avoid unexpected nulls.
  //
  //    This is a safety check — like looking in your wallet
  //    before trying to pay. You want to KNOW if the key is
  //    there before you try to use its value.
  // ============================================================
  Map<String, String> planets7 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print(planets7.containsKey('First')); // true
  print(planets7.containsKey('Tenth')); // false

  // Practical use: check before accessing
  String keyToFind = 'Third';
  if (planets7.containsKey(keyToFind)) {
    print('Found: ${planets7[keyToFind]}'); // Found: Earth
  } else {
    print('Key "$keyToFind" not found!');
  }

  // ============================================================
  // 8. CHECK IF A VALUE EXISTS - .containsValue() returns true/false
  //    Useful when you know the value but not the key.
  //
  //    This searches through ALL values in the map.
  //    Think of it like: "Is 'Mercury' stored somewhere in this map?"
  //    You don't need to know which key it belongs to.
  // ============================================================
  Map<String, String> planets8 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print(planets8.containsValue('Mercury')); // true
  print(planets8.containsValue('Pluto')); // false

  // ============================================================
  // 9. REMOVE AN ENTRY BY KEY - .remove() deletes and returns the value
  //    Returns the removed value, or null if the key wasn't found.
  //
  //    This is a destructive operation — the entry is gone.
  //    The return value is handy: you can see WHAT was removed,
  //    or check if anything was removed at all (null = nothing removed).
  // ============================================================
  Map<String, String> planets9 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print(planets9.remove('First')); // Mercury (the removed value)
  print(planets9); // {Second: Venus, Third: Earth, Fourth: Mars, Fifth: Jupiter}

  // Removing a key that doesn't exist returns null
  print(planets9.remove('Tenth')); // null

  // ============================================================
  // 10. GET ALL KEYS - .keys returns an Iterable of all keys
  //     Useful for looping through keys or converting to a List.
  //
  //     .keys returns an Iterable (not a List), so you might
  //     want to call .toList() if you need list features
  //     like indexing (keys[0]) or .length on the list itself.
  // ============================================================
  Map<String, String> planets10 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
  };
  print(planets10.keys); // (First, Second, Third)
  print(planets10.keys.toList()); // [First, Second, Third]

  // You can loop through keys
  for (String key in planets10.keys) {
    print('  Key: $key -> Value: ${planets10[key]}');
  }

  // ============================================================
  // 11. GET ALL VALUES - .values returns an Iterable of all values
  //     Same as .keys but for the value side of each entry.
  //
  //     Like .keys, this returns an Iterable.
  //     Values can contain duplicates (unlike keys which are unique).
  // ============================================================
  Map<String, String> planets11 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
  };
  print(planets11.values); // (Mercury, Venus, Earth)
  print(planets11.values.toList()); // [Mercury, Venus, Earth]

  // ============================================================
  // 12. GET MAP LENGTH - .length returns the number of entries
  //     Handy for conditions or displaying counts.
  //
  //     Each key-value pair counts as ONE entry.
  //     An empty map has a length of 0.
  // ============================================================
  Map<String, String> planets12 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print('Total planets: ${planets12.length}'); // 5

  // ============================================================
  // 13. CHECK IF MAP IS EMPTY - .isEmpty / .isNotEmpty
  //     Always check before accessing data to avoid errors.
  //
  //     .isEmpty   returns true if the map has ZERO entries
  //     .isNotEmpty returns true if the map has ONE OR MORE entries
  //
  //     These are cleaner than checking .length == 0.
  //     Use them as guards before looping or accessing data.
  // ============================================================
  Map<String, String> emptyMap = {};
  Map<String, String> planets13 = {'First': 'Mercury'};

  print(emptyMap.isEmpty); // true
  print(emptyMap.isNotEmpty); // false
  print(planets13.isEmpty); // false
  print(planets13.isNotEmpty); // true

  // Practical use: guard before processing
  if (emptyMap.isEmpty) {
    print('No data to display.');
  }
  if (planets13.isNotEmpty) {
    print('Map has ${planets13.length} entry/entries.');
  }
}

// ============================================================
// NOTES: Checking & Querying Maps — Summary
// ============================================================
//  7.  .containsKey(key)      — does this key exist? (true/false)
//  8.  .containsValue(value)  — does this value exist? (true/false)
//  9.  .remove(key)           — delete entry, returns the removed value (or null)
// 10.  .keys                  — get all keys as an Iterable
// 11.  .values                — get all values as an Iterable
// 12.  .length                — number of key-value pairs
// 13.  .isEmpty / .isNotEmpty — is the map empty or not?
//
//  KEY TAKEAWAYS:
//  - Always check .containsKey() before accessing to avoid null surprises
//  - .containsValue() searches ALL values (slower for big maps)
//  - .remove() returns what was removed — useful for logging or undo
//  - .keys and .values return Iterables — use .toList() if you need a List
//  - Prefer .isEmpty/.isNotEmpty over .length == 0 for readability
// ============================================================
