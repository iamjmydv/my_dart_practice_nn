//------------------------------------------------------------------------------
// M A P S - I N - D A R T
//------------------------------------------------------------------------------
// SAMPLE 1: CREATING & ACCESSING MAPS
//------------------------------------------------------------------------------
//
// Maps are key-value pairs — like a dictionary or a phone book.
// You look up a KEY and get back its VALUE.
//
// Dart maps are similar to:
//   - JavaScript objects / Map
//   - Python dictionaries
//   - Java HashMap
//
// This sample covers the basics: creating maps, reading values,
// updating values, and adding new entries.
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
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. BASIC MAP WITH var (int key) - Dart infers the types
  //    When the key is an int, Dart creates a Map<int, String>.
  //    Good for quick experiments or small scripts.
  //
  //    Syntax: var name = { key: value };
  //    Dart automatically figures out the types (type inference).
  // ============================================================
  var planets1 = {
    1: 'Mercury',
  };
  print(planets1); // {1: Mercury}
  print(planets1.runtimeType); // _Map<int, String>

  // ============================================================
  // 2. BASIC MAP WITH var (String key) - Most common form
  //    Dart infers Map<String, String> automatically.
  //    Keys and values are both Strings.
  //
  //    String keys are the most common in real apps because
  //    they're descriptive (e.g., "name", "email", "city").
  // ============================================================
  var planets2 = {
    'First': 'Mercury',
  };
  print(planets2); // {First: Mercury}
  print(planets2.runtimeType); // _Map<String, String>

  // ============================================================
  // 3. TYPED MAP WITH Map<K,V> - Explicit key and value types
  //    Recommended for production code because the compiler
  //    catches type mistakes at compile time.
  //
  //    Format: Map<KeyType, ValueType> name = { ... };
  //    If you try to add a wrong type, Dart shows an error
  //    BEFORE you even run the code.
  // ============================================================
  Map<String, String> planets3 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print(planets3);
  // {First: Mercury, Second: Venus, Third: Earth, Fourth: Mars, Fifth: Jupiter}

  // ============================================================
  // 4. ACCESS A VALUE BY KEY - Use map[key] to get a value
  //    Returns null if the key doesn't exist (won't crash).
  //
  //    This is the most basic operation — you give the key,
  //    the map gives you back the value.
  //    Always consider that the result might be null!
  // ============================================================
  Map<String, String> planets4 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  print(planets4['Fifth']); // Jupiter
  print(planets4['Tenth']); // null (key doesn't exist)

  // ============================================================
  // 5. UPDATE A VALUE BY KEY - Assign a new value to an existing key
  //    The old value is replaced. The key stays the same.
  //
  //    Syntax: map[existingKey] = newValue;
  //    This overwrites whatever was there before.
  //    The syntax is the same as adding — Dart checks if the key
  //    already exists. If it does, it updates; if not, it adds.
  // ============================================================
  Map<String, String> planets5 = {
    'First': 'Mercury',
    'Second': 'Venus',
    'Third': 'Earth',
    'Fourth': 'Mars',
    'Fifth': 'Jupiter',
  };
  planets5['Fifth'] = 'Saturn';
  print('Updated Value: ${planets5["Fifth"]}'); // Saturn

  // ============================================================
  // 6. ADD A NEW KEY-VALUE PAIR - Same syntax as updating
  //    If the key doesn't exist yet, it creates a new entry.
  //
  //    Syntax: map[newKey] = value;
  //    Maps grow dynamically — you can keep adding entries.
  //    New entries are added at the end (insertion order is preserved).
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
  print('Current Planets: $planets6');
  // Current Planets: {First: Mercury, Second: Venus, Third: Earth, Fourth: Mars, Fifth: Jupiter, Sixth: Saturn, Seventh: Uranus}
}

// ============================================================
// NOTES: Creating & Accessing Maps — Summary
// ============================================================
//  1. var map = { key: value }     — type inference (quick & easy)
//  2. Map<K, V> map = { ... }     — explicit types (safe & clear)
//  3. map[key]                     — access a value (returns null if missing)
//  4. map[key] = newValue          — update an existing entry
//  5. map[newKey] = value          — add a new entry
//
//  KEY TAKEAWAYS:
//  - Use "var" for quick scripts, Map<K,V> for production code
//  - Accessing a missing key returns null (no crash)
//  - Updating and adding use the SAME syntax: map[key] = value
//  - Dart preserves insertion order in maps
//  - Keys must be unique — duplicate keys overwrite the old value
// ============================================================
