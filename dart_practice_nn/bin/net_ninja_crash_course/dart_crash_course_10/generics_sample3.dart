//------------------------------------------------------------------------------
// G E N E R I C S
//------------------------------------------------------------------------------
// SAMPLE 3: MULTIPLE TYPE PARAMETERS — When you need more than one type
//------------------------------------------------------------------------------
//
// Some classes need TWO or more type placeholders.
// For example, a Pair holds two values of DIFFERENT types.
//
// Convention: <K, V> for key-value, <A, B> for two items,
// or <T1, T2> when there's no obvious meaning.
//
// This sample shows:
//   1. Pair<A, B> — holds two values of potentially different types
//   2. KeyValue<K, V> — like a single Map entry
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                           | WHY IT MATTERS
// -----------------------------------------------------------------------
//  1  | Pair<String, int> — mixed types        | Two different types together
//  2  | Pair<double, double> — same types      | Both types can be the same
//  3  | KeyValue<K, V> — key-value pair        | Like a Map entry
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. Pair<A, B> — Two values of potentially different types
  //    A is the type of the first value, B is the type of the second.
  //    Here: A = String, B = int → holds a name and an age.
  // ============================================================
  print('--- 1. Pair<String, int> ---');

  var nameAndAge = Pair<String, int>('Alice', 30);
  print(nameAndAge); // Pair(Alice, 30)
  print('Name: ${nameAndAge.first}'); // Name: Alice
  print('Age: ${nameAndAge.second}'); // Age: 30

  print('');

  // ============================================================
  // 2. Pair<double, double> — Both types can be the same
  //    There's no rule that A and B must be different.
  //    Here both are double, perfect for coordinates.
  // ============================================================
  print('--- 2. Pair<double, double> ---');

  var coordinates = Pair<double, double>(42.3, -71.1);
  print(coordinates); // Pair(42.3, -71.1)
  print('Latitude: ${coordinates.first}'); // Latitude: 42.3
  print('Longitude: ${coordinates.second}'); // Longitude: -71.1

  print('');

  // ============================================================
  // 3. KeyValue<K, V> — Like a Map entry
  //    K is the key type, V is the value type.
  //    This is exactly how Dart's Map<K, V> works internally.
  // ============================================================
  print('--- 3. KeyValue<K, V> ---');

  var setting = KeyValue<String, bool>('darkMode', true);
  print(setting); // darkMode: true

  var score = KeyValue<String, int>('Player1', 9500);
  print(score); // Player1: 9500

  var coordinate = KeyValue<String, double>('latitude', 42.3601);
  print(coordinate); // latitude: 42.3601
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// Pair<A, B> — holds two values of potentially different types
// A is the type of "first", B is the type of "second".
// Examples:
//   Pair<String, int>    → name and age
//   Pair<double, double> → x and y coordinates
//   Pair<int, bool>      → index and enabled flag
class Pair<A, B> {
  A first;
  B second;

  Pair(this.first, this.second);

  @override
  String toString() => 'Pair($first, $second)';
}

// KeyValue<K, V> — a key-value pair, like a single Map entry
// K is the key type, V is the value type.
// This is a simplified version of what Map<K, V> uses internally.
class KeyValue<K, V> {
  K key;
  V value;

  KeyValue(this.key, this.value);

  @override
  String toString() => '$key: $value';
}

// ============================================================
// NOTES: Multiple Type Parameters
// ============================================================
//
// SYNTAX:
// -------
//   class ClassName<A, B> { ... }        // two type params
//   class ClassName<A, B, C> { ... }     // three type params (rare)
//
// NAMING CONVENTIONS:
// -------------------
//   <A, B>     → for generic pairs (first, second)
//   <K, V>     → for key-value pairs (like Map)
//   <T, R>     → for input type and return type
//   <T1, T2>   → when there's no obvious meaning
//
// DART'S BUILT-IN EXAMPLES:
// -------------------------
//   Map<String, int>       → Map<K, V> with K=String, V=int
//   MapEntry<String, int>  → similar to our KeyValue<K, V>
//
// WHEN TO USE:
// ------------
// Use multiple type parameters when your class needs to handle
// two or more types that might be different from each other.
// If they're always the same type, just use one <T>.
//
// ============================================================
