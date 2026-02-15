//--------------------------------
// M A P S - I N - D A R T
//--------------------------------
//
// This file covers all major Map operations in Dart.
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
void main() {
  // ============================================================
  // 1. BASIC MAP WITH var (int key) - Dart infers the types
  //    When key is an int, Dart creates a Map<int, String>.
  //    Good for quick experiments or small scripts.
  // ============================================================
  var planets1 = {
    1: "Mercury",
  };
  print(planets1); // {1: Mercury}

  // ============================================================
  // 2. BASIC MAP WITH var (String key) - Most common form
  //    Dart infers Map<String, String> automatically.
  //    Keys and values are both Strings.
  // ============================================================
  var planets2 = {
    "First": "Mercury",
  };
  print(planets2); // {First: Mercury}

  // ============================================================
  // 3. TYPED MAP WITH Map<K,V> - Explicit key and value types
  //    Recommended for production code because the compiler
  //    catches type mistakes at compile time.
  // ============================================================
  Map<String, String> planets3 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
    "Fourth": "Mars",
    "Fifth": "Jupiter",
  };
  print(planets3); // {First: Mercury, Second: Venus, Third: Earth, Fourth: Mars, Fifth: Jupiter}

  // ============================================================
  // 4. ACCESS A VALUE BY KEY - Use map[key] to get a value
  //    Returns null if the key doesn't exist (won't crash).
  // ============================================================
  Map<String, String> planets4 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
    "Fourth": "Mars",
    "Fifth": "Jupiter",
  };
  print(planets4["Fifth"]); // Jupiter
  print(planets4["Tenth"]); // null (key doesn't exist)

  // ============================================================
  // 5. UPDATE A VALUE BY KEY - Assign a new value to an existing key
  //    The old value is replaced. The key stays the same.
  // ============================================================
  Map<String, String> planets5 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
    "Fourth": "Mars",
    "Fifth": "Jupiter",
  };
  planets5["Fifth"] = "Saturn";
  print('Updated Value: ${planets5["Fifth"]}'); // Saturn

  // ============================================================
  // 6. ADD A NEW KEY-VALUE PAIR - Same syntax as updating
  //    If the key doesn't exist yet, it creates a new entry.
  // ============================================================
  Map<String, String> planets6 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
    "Fourth": "Mars",
    "Fifth": "Jupiter",
  };
  planets6["Sixth"] = "Saturn";
  planets6["Seventh"] = "Uranus";
  print('Current Planets: $planets6'); // Current Planets: {First: Mercury, Second: Venus, Third: Earth, Fourth: Mars, Fifth: Jupiter, Sixth: Saturn, Seventh: Uranus}

  // ============================================================
  // 7. CHECK IF A KEY EXISTS - .containsKey() returns true/false
  //    Use before accessing a key to avoid unexpected nulls.
  // ============================================================
  Map<String, String> planets7 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
    "Fourth": "Mars",
    "Fifth": "Jupiter",
  };
  print(planets7.containsKey("First")); // true
  print(planets7.containsKey("Tenth")); // false

  // ============================================================
  // 8. CHECK IF A VALUE EXISTS - .containsValue() returns true/false
  //    Useful when you know the value but not the key.
  // ============================================================
  Map<String, String> planets8 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
    "Fourth": "Mars",
    "Fifth": "Jupiter",
  };
  print(planets8.containsValue("Mercury")); // true
  print(planets8.containsValue("Pluto")); // false

  // ============================================================
  // 9. REMOVE AN ENTRY BY KEY - .remove() deletes and returns the value
  //    Returns the removed value, or null if the key wasn't found.
  // ============================================================
  Map<String, String> planets9 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
    "Fourth": "Mars",
    "Fifth": "Jupiter",
  };
  print(planets9.remove("First")); // Mercury (the removed value)
  print(planets9); // {Second: Venus, Third: Earth, Fourth: Mars, Fifth: Jupiter}

  // ============================================================
  // 10. GET ALL KEYS - .keys returns an Iterable of all keys
  //     Useful for looping through keys or converting to a List.
  // ============================================================
  Map<String, String> planets10 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
  };
  print(planets10.keys); // (First, Second, Third)
  print(planets10.keys.toList()); // [First, Second, Third]

  // ============================================================
  // 11. GET ALL VALUES - .values returns an Iterable of all values
  //     Same as .keys but for the value side of each entry.
  // ============================================================
  Map<String, String> planets11 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
  };
  print(planets11.values); // (Mercury, Venus, Earth)
  print(planets11.values.toList()); // [Mercury, Venus, Earth]

  // ============================================================
  // 12. GET MAP LENGTH - .length returns the number of entries
  //     Handy for conditions or displaying counts.
  // ============================================================
  Map<String, String> planets12 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
    "Fourth": "Mars",
    "Fifth": "Jupiter",
  };
  print('Total planets: ${planets12.length}'); // 5

  // ============================================================
  // 13. CHECK IF MAP IS EMPTY - .isEmpty / .isNotEmpty
  //     Always check before accessing data to avoid errors.
  // ============================================================
  Map<String, String> emptyMap = {};
  Map<String, String> planets13 = {"First": "Mercury"};

  print(emptyMap.isEmpty); // true
  print(emptyMap.isNotEmpty); // false
  print(planets13.isEmpty); // false
  print(planets13.isNotEmpty); // true

  // ============================================================
  // 14. ADD MULTIPLE ENTRIES AT ONCE - .addAll() merges maps
  //     If a key already exists, its value gets overwritten.
  // ============================================================
  Map<String, String> planets14 = {
    "First": "Mercury",
    "Second": "Venus",
  };
  planets14.addAll({
    "Third": "Earth",
    "Fourth": "Mars",
    "Fifth": "Jupiter",
  });
  print(planets14); // {First: Mercury, Second: Venus, Third: Earth, Fourth: Mars, Fifth: Jupiter}

  // ============================================================
  // 15. ADD ONLY IF KEY IS ABSENT - .putIfAbsent()
  //     Adds the key-value pair ONLY if the key doesn't exist yet.
  //     Prevents accidentally overwriting existing data.
  // ============================================================
  Map<String, String> planets15 = {
    "First": "Mercury",
    "Second": "Venus",
  };
  planets15.putIfAbsent("Third", () => "Earth"); // added
  planets15.putIfAbsent("First", () => "Pluto"); // ignored (key exists)
  print(planets15); // {First: Mercury, Second: Venus, Third: Earth}

  // ============================================================
  // 16. LOOP THROUGH A MAP WITH forEach - Process every entry
  //     The callback receives the key and value as parameters.
  // ============================================================
  Map<String, String> planets16 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
    "Fourth": "Mars",
    "Fifth": "Jupiter",
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
  // ============================================================
  Map<String, String> planets17 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
  };
  for (var entry in planets17.entries) {
    print('Key: ${entry.key}, Value: ${entry.value}');
  }
  // Output:
  // Key: First, Value: Mercury
  // Key: Second, Value: Venus
  // Key: Third, Value: Earth

  // ============================================================
  // 18. TRANSFORM VALUES WITH .map() - Create a new map
  //     Returns a NEW map with transformed keys and/or values.
  //     The original map stays unchanged.
  // ============================================================
  Map<String, String> planets18 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
  };
  var uppercasedPlanets = planets18.map((key, value) {
    return MapEntry(key, value.toUpperCase());
  });
  print(uppercasedPlanets); // {First: MERCURY, Second: VENUS, Third: EARTH}
  print(planets18); // {First: Mercury, Second: Venus, Third: Earth} (original is unchanged)

  // ============================================================
  // 19. CLEAR ALL ENTRIES - .clear() removes everything
  //     The map becomes empty but still exists.
  //     Use when you want to reset a map without creating a new one.
  // ============================================================
  Map<String, String> planets19 = {
    "First": "Mercury",
    "Second": "Venus",
    "Third": "Earth",
  };
  print('Before clear: $planets19'); // Before clear: {First: Mercury, Second: Venus, Third: Earth}
  planets19.clear();
  print('After clear: $planets19'); // After clear: {}

  // ============================================================
  // 20. NESTED MAPS - Maps inside maps for structured data
  //     Common for grouping related data (like JSON structures).
  //     Access nested values with chained bracket notation.
  // ============================================================
  Map<String, Map<String, String>> solarSystem = {
    "Mercury": {"type": "Terrestrial", "position": "1st"},
    "Venus": {"type": "Terrestrial", "position": "2nd"},
    "Earth": {"type": "Terrestrial", "position": "3rd"},
    "Jupiter": {"type": "Gas Giant", "position": "5th"},
  };
  print(solarSystem["Earth"]); // {type: Terrestrial, position: 3rd}
  print(solarSystem["Earth"]?["type"]); // Terrestrial
  print(solarSystem["Jupiter"]?["position"]); // 5th

  solarSystem.forEach((planet, details) {
    print('$planet -> Type: ${details["type"]}, Position: ${details["position"]}');
  });
  // Output:
  // Mercury -> Type: Terrestrial, Position: 1st
  // Venus -> Type: Terrestrial, Position: 2nd
  // Earth -> Type: Terrestrial, Position: 3rd
  // Jupiter -> Type: Gas Giant, Position: 5th

  // ============================================================
  // NOTES: Map<K,V> Methods & Properties Used in This File
  // ============================================================
  //  1. var map                — quick map creation with type inference (int key)
  //  2. var map                — quick map creation with type inference (String key)
  //  3. Map<String, String>    — explicit typed map for safety and clarity
  //  4. map[key]               — access a value by its key (returns null if missing)
  //  5. map[key] = newValue    — update an existing value by key
  //  6. map[newKey] = value    — add a new key-value pair
  //  7. .containsKey()         — check if a key exists (returns true/false)
  //  8. .containsValue()       — check if a value exists (returns true/false)
  //  9. .remove()              — remove an entry by key (returns the removed value)
  // 10. .keys                  — get all keys as an Iterable
  // 11. .values                — get all values as an Iterable
  // 12. .length                — get the total number of entries
  // 13. .isEmpty / .isNotEmpty — check if the map has no entries or has entries
  // 14. .addAll()              — merge another map into the current map
  // 15. .putIfAbsent()         — add a key-value pair only if the key doesn't exist
  // 16. .forEach()             — loop through every key-value pair with a callback
  // 17. .entries               — get MapEntry objects for use with for-in loops
  // 18. .map()                 — transform keys/values and return a new map
  // 19. .clear()               — remove all entries from the map
  // 20. Nested Maps            — maps inside maps for structured/grouped data
  // ============================================================
}
