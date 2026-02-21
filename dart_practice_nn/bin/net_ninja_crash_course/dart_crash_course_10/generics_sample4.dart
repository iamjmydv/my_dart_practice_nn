//------------------------------------------------------------------------------
// G E N E R I C S
//------------------------------------------------------------------------------
// SAMPLE 4: GENERIC METHODS / FUNCTIONS — Generic logic without a class
//------------------------------------------------------------------------------
//
// You don't always need a whole class. Sometimes a single function
// needs to work with multiple types.
//
// Put <T> right after the function name to make it generic.
// Dart can often INFER the type from the argument, so you don't
// always need to write <int> or <String> explicitly.
//
// This sample shows:
//   1. getFirst<T> — returns the first item of any list
//   2. wrapInList<T> — wraps any single value in a list
//   3. swapPair<A, B> — swaps the values in a Pair
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                           | WHY IT MATTERS
// -----------------------------------------------------------------------
//  1  | getFirst<T> with explicit type          | Basic generic function
//  2  | getFirst with type inference            | Dart figures out T
//  3  | wrapInList<T> — single value to list    | Wrapping any value
//  4  | swapPair<A, B> — flips a Pair           | Multiple generic params
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. getFirst<T> — Returns the first element of any typed list
  //    The <T> after the function name tells Dart "this function
  //    works with any type T". The return type is T, and the
  //    parameter type is List<T>.
  // ============================================================
  print('--- 1. getFirst<T> with explicit type ---');

  print(getFirst<int>([10, 20, 30])); // 10
  print(getFirst<String>(['a', 'b', 'c'])); // a

  print('');

  // ============================================================
  // 2. TYPE INFERENCE — Dart figures out T automatically
  //    When you pass [100, 200, 300], Dart sees it's a List<int>
  //    and infers that T = int. No need to write <int> explicitly.
  // ============================================================
  print('--- 2. getFirst with type inference ---');

  print(getFirst([100, 200, 300])); // 100 (Dart infers <int>)
  print(getFirst(['hello', 'world'])); // hello (Dart infers <String>)
  print(getFirst([true, false])); // true (Dart infers <bool>)

  print('');

  // ============================================================
  // 3. wrapInList<T> — Wraps any single value into a List
  //    Takes one value of type T, returns a List<T> containing it.
  //    Dart infers the type from the argument.
  // ============================================================
  print('--- 3. wrapInList<T> ---');

  print(wrapInList(42)); // [42]
  print(wrapInList('hello')); // [hello]
  print(wrapInList(true)); // [true]
  print(wrapInList(3.14)); // [3.14]

  print('');

  // ============================================================
  // 4. swapPair<A, B> — Swaps the values in a Pair
  //    Takes Pair<A, B> and returns Pair<B, A>.
  //    Notice how the types FLIP: String,int becomes int,String.
  //    This shows generic functions with MULTIPLE type parameters.
  // ============================================================
  print('--- 4. swapPair<A, B> ---');

  var original = Pair<String, int>('age', 25);
  var swapped = swapPair(original);
  print('Original: $original'); // Original: Pair(age, 25)
  print('Swapped: $swapped'); // Swapped: Pair(25, age)

  // Works with any two types
  var coords = Pair<double, String>(42.3, 'North');
  var flipped = swapPair(coords);
  print('Original: $coords'); // Original: Pair(42.3, North)
  print('Flipped: $flipped'); // Flipped: Pair(North, 42.3)
}

// ============================================================
//  FUNCTION & CLASS DEFINITIONS
// ============================================================

// Returns the first element of any typed list
// T is inferred from the list's element type.
// Throws an error if the list is empty.
T getFirst<T>(List<T> items) {
  if (items.isEmpty) throw StateError('List is empty');
  return items.first;
}

// Wraps any single value into a List
// Takes one item of type T, returns [item] as List<T>.
List<T> wrapInList<T>(T item) {
  return [item];
}

// Swaps the two values in a Pair — note the return type flips!
// Input:  Pair<A, B>  (e.g., Pair<String, int>)
// Output: Pair<B, A>  (e.g., Pair<int, String>)
Pair<B, A> swapPair<A, B>(Pair<A, B> pair) {
  return Pair<B, A>(pair.second, pair.first);
}

// Pair class (needed for swapPair examples above)
class Pair<A, B> {
  A first;
  B second;

  Pair(this.first, this.second);

  @override
  String toString() => 'Pair($first, $second)';
}

// ============================================================
// NOTES: Generic Methods / Functions
// ============================================================
//
// SYNTAX:
// -------
//   ReturnType functionName<T>(params) { ... }
//   T getFirst<T>(List<T> items) { ... }        // single type param
//   Pair<B,A> swap<A,B>(Pair<A,B> p) { ... }    // multiple type params
//
// TYPE INFERENCE:
// ---------------
// Dart can usually figure out T from the arguments:
//   getFirst<int>([1, 2, 3])   // explicit: you tell Dart T=int
//   getFirst([1, 2, 3])        // inferred: Dart figures out T=int
// Both are valid. Be explicit when it makes the code clearer.
//
// GENERIC FUNCTIONS vs GENERIC CLASSES:
// -------------------------------------
// Generic class:    class Box<T> { T item; }     → type set at creation
// Generic function: T getFirst<T>(List<T> items) → type set at call time
//
// Use a generic CLASS when:
//   - The type is used across multiple methods
//   - You need to store typed data
//
// Use a generic FUNCTION when:
//   - Only ONE function needs to be generic
//   - No state to maintain between calls
//
// ============================================================
