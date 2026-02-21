//------------------------------------------------------------------------------
// M A P S - I N - D A R T
//------------------------------------------------------------------------------
// SAMPLE 4: NESTED MAPS
//------------------------------------------------------------------------------
//
// Nested maps are maps INSIDE maps — like folders inside folders.
// They let you store structured, grouped data.
//
// This is very common in real-world apps:
//   - JSON responses from APIs are often nested maps
//   - Configuration files with sections and sub-sections
//   - Grouping related data (e.g., planet name -> { type, position, moons })
//
// Think of it like a filing cabinet:
//   - The outer map = the cabinet (drawer labels)
//   - The inner maps = folders inside each drawer (details)
//
// -----------------------------------------------------------------------
//  #  | TOPIC                            | KEYWORDS USED                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
// 20a | Creating nested maps             | Map<String, Map<String, String>>       | Store structured/grouped data
// 20b | Accessing nested values           | map[key]?[innerKey]                    | Drill down into grouped data safely
// 20c | Looping through nested maps       | .forEach() with nested access          | Process all groups and their details
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 20a. CREATING NESTED MAPS - Maps inside maps
  //      The type looks complex but is straightforward:
  //      Map<String, Map<String, String>>
  //        |         |
  //        |         └── inner map: details about each planet
  //        └── outer key: the planet name
  //
  //      Each planet name (outer key) maps to another map
  //      containing that planet's details (inner map).
  // ============================================================
  Map<String, Map<String, String>> solarSystem = {
    'Mercury': {'type': 'Terrestrial', 'position': '1st'},
    'Venus': {'type': 'Terrestrial', 'position': '2nd'},
    'Earth': {'type': 'Terrestrial', 'position': '3rd'},
    'Jupiter': {'type': 'Gas Giant', 'position': '5th'},
  };

  print('Full solar system map:');
  print(solarSystem);
  // {Mercury: {type: Terrestrial, position: 1st}, Venus: {type: Terrestrial, position: 2nd}, ...}

  // ============================================================
  // 20b. ACCESSING NESTED VALUES - Chained bracket notation
  //      Use map[outerKey] to get the inner map,
  //      then [innerKey] to get the specific value.
  //
  //      IMPORTANT: Use the ?. (null-aware) operator or ?[]
  //      because the outer key might not exist.
  //      solarSystem["Earth"]?["type"] means:
  //      "If Earth exists, get its type. Otherwise, return null."
  //
  //      Without "?", you'd get a runtime error if the key is missing.
  // ============================================================
  print('');
  print('--- Accessing nested values ---');

  // Get the entire inner map for Earth
  print(solarSystem['Earth']); // {type: Terrestrial, position: 3rd}

  // Get a specific nested value
  print(solarSystem['Earth']?['type']); // Terrestrial
  print(solarSystem['Jupiter']?['position']); // 5th

  // Accessing a key that doesn't exist — returns null safely
  print(solarSystem['Pluto']?['type']); // null (Pluto doesn't exist)
  print(solarSystem['Earth']?['moons']); // null (key 'moons' doesn't exist)

  // ============================================================
  // 20c. LOOPING THROUGH NESTED MAPS
  //      Use .forEach() on the outer map.
  //      The value of each entry IS the inner map,
  //      so you can access its keys normally.
  // ============================================================
  print('');
  print('--- Looping through nested maps with forEach ---');

  solarSystem.forEach((planet, details) {
    print('$planet -> Type: ${details["type"]}, Position: ${details["position"]}');
  });
  // Output:
  // Mercury -> Type: Terrestrial, Position: 1st
  // Venus -> Type: Terrestrial, Position: 2nd
  // Earth -> Type: Terrestrial, Position: 3rd
  // Jupiter -> Type: Gas Giant, Position: 5th

  // ============================================================
  // BONUS: Looping with for-in and .entries
  //        Same result, but with for-in loop syntax.
  //        Useful when you need break/continue.
  // ============================================================
  print('');
  print('--- Looping with for-in and .entries ---');

  for (var entry in solarSystem.entries) {
    String planet = entry.key;
    Map<String, String> details = entry.value;
    print('$planet: type=${details["type"]}, position=${details["position"]}');
  }

  // ============================================================
  // BONUS: Adding a new planet to the nested map
  //        You add to the outer map just like any other map.
  //        The value you add is itself a map.
  // ============================================================
  print('');
  print('--- Adding a new planet ---');

  solarSystem['Saturn'] = {'type': 'Gas Giant', 'position': '6th'};
  print('After adding Saturn:');
  solarSystem.forEach((planet, details) {
    print('  $planet -> ${details["type"]} (${details["position"]})');
  });

  // ============================================================
  // BONUS: Updating a value inside a nested map
  //        First access the inner map, then update its value.
  // ============================================================
  print('');
  print('--- Updating a nested value ---');

  solarSystem['Earth']?['type'] = 'Terrestrial (Home)';
  print('Earth type updated: ${solarSystem["Earth"]?["type"]}');
  // Earth type updated: Terrestrial (Home)

  // ============================================================
  // BONUS: A more complex nested map example
  //        Maps can hold different value types if you use dynamic.
  //        But for type safety, prefer specific types when possible.
  // ============================================================
  print('');
  print('--- Complex nested map example ---');

  Map<String, Map<String, dynamic>> students = {
    'Alice': {'age': 20, 'grade': 'A', 'active': true},
    'Bob': {'age': 22, 'grade': 'B', 'active': true},
    'Charlie': {'age': 21, 'grade': 'C', 'active': false},
  };

  students.forEach((name, info) {
    String status = info['active'] == true ? 'Active' : 'Inactive';
    print('$name (Age: ${info["age"]}, Grade: ${info["grade"]}, $status)');
  });
  // Output:
  // Alice (Age: 20, Grade: A, Active)
  // Bob (Age: 22, Grade: B, Active)
  // Charlie (Age: 21, Grade: C, Inactive)

  // Filter: find only active students using .entries and where
  print('');
  print('--- Active students only ---');
  var activeStudents = students.entries.where((entry) => entry.value['active'] == true);
  for (var entry in activeStudents) {
    print('  ${entry.key}: Grade ${entry.value["grade"]}');
  }
  // Output:
  //   Alice: Grade A
  //   Bob: Grade B
}

// ============================================================
// NOTES: Nested Maps — Summary
// ============================================================
// 20a. Map<K, Map<K2, V2>>         — maps inside maps for structured data
// 20b. map[outerKey]?[innerKey]     — access nested values safely with ?.
// 20c. .forEach() / for-in         — loop through all groups and their details
//
//  KEY TAKEAWAYS:
//  - Nested maps model structured data (like JSON)
//  - Always use ?[] (null-aware bracket access) for nested lookups
//  - The outer map's VALUE type is itself a Map<K, V>
//  - You can add, update, and remove nested entries just like flat maps
//  - Use Map<String, dynamic> when inner values have mixed types
//  - For complex data, consider creating a class instead of deeply nested maps
//
//  NESTED MAP vs CLASS — When to use what:
//  ┌──────────────────────────┬──────────────────────────────────────────┐
//  |  Use Nested Maps when... |  Use a Class when...                     |
//  |──────────────────────────|──────────────────────────────────────────|
//  |  Data is dynamic/unknown |  Data structure is fixed/known           |
//  |  Parsing JSON quickly    |  You want type safety & methods          |
//  |  Quick prototyping       |  Building production features            |
//  |  Keys come from an API   |  You know all the fields ahead of time  |
//  └──────────────────────────┴──────────────────────────────────────────┘
// ============================================================
