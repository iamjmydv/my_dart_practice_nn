//------------------------------------------------------------------------------
// G E N E R I C S
//------------------------------------------------------------------------------
// SAMPLE 5: BOUNDED GENERICS (extends) — Restrict what types are allowed
//------------------------------------------------------------------------------
//
// Sometimes "any type" is too broad. You might need T to have
// certain methods or properties. Use "extends" to set a limit.
//
//   <T extends num>        → T must be num, int, or double
//   <T extends Comparable> → T must be a type that can be sorted
//   <T extends Animal>     → T must be Animal or any subclass
//
// This gives you type safety AND access to the base class's
// methods inside your generic code.
//
// This sample shows:
//   1. MathBox<T extends num> — only works with numbers
//   2. SortedCollection<T extends Comparable> — items must be sortable
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                           | WHY IT MATTERS
// -----------------------------------------------------------------------
//  1  | MathBox<int> — sum, max, min           | num methods available
//  2  | MathBox<double> — same class, doubles  | Works with any num subtype
//  3  | MathBox<String> — blocked!             | Bounded = restricted types
//  4  | SortedCollection — sortable types only | Comparable bound
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. MathBox<int> — Only works with numbers
  //    Because T extends num, we can use + (addition) and
  //    compareTo() inside the class. Without the bound,
  //    Dart wouldn't know T supports those operations.
  // ============================================================
  print('--- 1. MathBox<int> ---');

  var intMath = MathBox<int>([3, 7, 1, 9, 4]);
  print('Numbers: $intMath'); // Numbers: MathBox([3, 7, 1, 9, 4])
  print('Sum: ${intMath.sum()}'); // Sum: 24
  print('Max: ${intMath.max()}'); // Max: 9
  print('Min: ${intMath.min()}'); // Min: 1

  print('');

  // ============================================================
  // 2. MathBox<double> — Same class, works with doubles too
  //    int and double both extend num, so both are allowed.
  //    The exact same methods work because num supports them all.
  // ============================================================
  print('--- 2. MathBox<double> ---');

  var doubleMath = MathBox<double>([2.5, 8.1, 3.7]);
  print('Numbers: $doubleMath'); // Numbers: MathBox([2.5, 8.1, 3.7])
  print('Sum: ${doubleMath.sum()}'); // Sum: 14.3
  print('Max: ${doubleMath.max()}'); // Max: 8.1
  print('Min: ${doubleMath.min()}'); // Min: 2.5

  print('');

  // ============================================================
  // 3. MathBox<String> — BLOCKED!
  //    String does NOT extend num, so Dart won't allow it.
  //    This is the whole point of bounded generics — restricting
  //    which types can be used.
  // ============================================================
  print('--- 3. Bounded = restricted ---');
  print('MathBox<String> would NOT compile:');
  print('  String does not extend num');
  // var stringMath = MathBox<String>(['a', 'b']);  // Compile error!

  print('');

  // ============================================================
  // 4. SortedCollection<T extends Comparable> — Sortable types
  //    Comparable is an interface that requires a compareTo() method.
  //    int, double, and String all implement Comparable.
  //    This means we can safely call .sort() on the items.
  // ============================================================
  print('--- 4. SortedCollection<T extends Comparable> ---');

  var sortedNumbers = SortedCollection<int>([5, 2, 8, 1, 9, 3]);
  print('Sorted: ${sortedNumbers.sorted()}'); // Sorted: [1, 2, 3, 5, 8, 9]

  var sortedWords = SortedCollection<String>(['banana', 'apple', 'cherry']);
  print('Sorted: ${sortedWords.sorted()}'); // Sorted: [apple, banana, cherry]

  var sortedDoubles = SortedCollection<double>([3.14, 1.41, 2.72]);
  print('Sorted: ${sortedDoubles.sorted()}'); // Sorted: [1.41, 2.72, 3.14]
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// MathBox<T extends num> — only accepts number types (int, double)
// Because T extends num, we can use num methods like + and compareTo.
// Without "extends num", Dart wouldn't let us add numbers or compare them.
class MathBox<T extends num> {
  List<T> numbers;

  MathBox(this.numbers);

  // We can use + because num supports addition
  num sum() {
    num total = 0;
    for (var n in numbers) {
      total += n;
    }
    return total;
  }

  // We can use compareTo because num implements Comparable
  T max() {
    T result = numbers.first;
    for (var n in numbers) {
      if (n.compareTo(result) > 0) result = n;
    }
    return result;
  }

  T min() {
    T result = numbers.first;
    for (var n in numbers) {
      if (n.compareTo(result) < 0) result = n;
    }
    return result;
  }

  @override
  String toString() => 'MathBox($numbers)';
}

// SortedCollection<T extends Comparable> — items must be sortable
// Comparable requires the compareTo() method, which .sort() uses.
// int, double, String, DateTime all implement Comparable.
class SortedCollection<T extends Comparable> {
  List<T> items;

  SortedCollection(this.items);

  // Returns a new sorted list (doesn't modify the original)
  List<T> sorted() {
    var copy = List<T>.from(items);
    copy.sort();
    return copy;
  }
}

// ============================================================
// NOTES: Bounded Generics
// ============================================================
//
// SYNTAX:
// -------
//   class ClassName<T extends SomeType> { ... }
//
// WHAT "extends" DOES:
// --------------------
// It sets an UPPER BOUND on what T can be:
//   <T extends num>         → T can be num, int, or double
//   <T extends Comparable>  → T can be anything that is Comparable
//   <T extends Animal>      → T can be Animal, Dog, Cat, etc.
//
// WHY USE BOUNDS?
// ---------------
// Without a bound, T could be ANYTHING — and you can't call any
// methods on it (because Dart doesn't know what methods it has).
//
// With <T extends num>:
//   T value;
//   value + 1;        // OK! Dart knows T is a num, nums support +
//   value.compareTo;  // OK! num implements Comparable
//
// Without the bound (just <T>):
//   T value;
//   value + 1;        // ERROR! Dart doesn't know T supports +
//
// DEFAULT BOUND:
// --------------
// <T> is the same as <T extends Object?>
// This means T can be any type, including null.
//
// COMMON BOUNDS IN DART:
// ┌──────────────────────────┬────────────────────────────────┐
// │  Bound                   │  What it allows                │
// ├──────────────────────────┼────────────────────────────────┤
// │  <T extends num>         │  int, double                   │
// │  <T extends Comparable>  │  int, double, String, DateTime │
// │  <T extends Object>      │  Any non-nullable type         │
// │  <T extends Object?>     │  Any type (default, nullable)  │
// └──────────────────────────┴────────────────────────────────┘
//
// ============================================================
