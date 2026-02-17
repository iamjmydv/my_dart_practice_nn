//---------------------------------------------
// G E N E R I C S
//---------------------------------------------
//
// Generics let you write code that works with ANY type, while still
// keeping type safety. Instead of hardcoding a specific type like
// String or int, you use a placeholder (like T) that gets filled in
// when you actually use the class, method, or function.
//
// Think of it like a TEMPLATE: "I don't know what type you'll give me,
// but whatever it is, I'll handle it correctly."
//
// WITHOUT generics:  List data = [1, 'hello', true];  // anything goes, no safety
// WITH generics:     List<int> data = [1, 2, 3];      // only ints allowed, safe!
//
// -----------------------------------------------------------------------
//  #  | TOPIC                                  | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | The problem without generics           | Why dynamic is risky
//  2  | Basic generic class                    | Type-safe reusable containers
//  3  | Multiple type parameters               | When you need more than one type
//  4  | Generic methods / functions            | Generic logic without a class
//  5  | Bounded generics (extends)             | Restrict what types are allowed
//  6  | Generics with inheritance              | Combine generics + class hierarchies
//  7  | Real-world example: Menu collection    | Putting it all together
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. THE PROBLEM WITHOUT GENERICS - Why dynamic is risky
  //    Without generics, you'd use "dynamic" or "Object" to accept
  //    any type. But then Dart can't help you catch mistakes.
  //
  //    Imagine a box that holds items. Without generics, you can
  //    accidentally put a String where you expected an int.
  //    With generics, Dart catches the mistake BEFORE you run.
  // ============================================================
  print('--- 1. The Problem Without Generics ---');

  // WITHOUT generics — uses dynamic, no type safety
  var unsafeBox = UnsafeBox('Hello');
  print(unsafeBox.item); // Hello
  print(unsafeBox.item.runtimeType); // String

  // This compiles fine, but could crash at runtime if you
  // tried to use .item as an int when it's actually a String:
  var anotherUnsafeBox = UnsafeBox(42);
  print(anotherUnsafeBox.item); // 42
  // unsafeBox.item + anotherUnsafeBox.item;  // Runtime crash! Can't add String + int

  // WITH generics — Dart knows the exact type
  var safeStringBox = SafeBox<String>('Hello');
  var safeIntBox = SafeBox<int>(42);
  print(safeStringBox.item); // Hello
  print(safeIntBox.item); // 42

  // This would cause a COMPILE-TIME error (caught before running!):
  // var badBox = SafeBox<int>('Hello');  // Error! String is not int

  // ============================================================
  // 2. BASIC GENERIC CLASS - Type-safe reusable containers
  //    A generic class uses <T> as a type placeholder.
  //    When you create an instance, you specify the actual type.
  //
  //    T is just a convention. You could use any letter:
  //      <T> = Type, <E> = Element, <K> = Key, <V> = Value
  //    But T is the most common for single-type generics.
  // ============================================================
  print('\n--- 2. Basic Generic Class ---');

  // Stack<T> — a last-in-first-out data structure
  var numberStack = Stack<int>();
  numberStack.push(10);
  numberStack.push(20);
  numberStack.push(30);
  print(numberStack); // Stack: [10, 20, 30]
  print('Popped: ${numberStack.pop()}'); // Popped: 30
  print('Peek: ${numberStack.peek()}'); // Peek: 20
  print(numberStack); // Stack: [10, 20]

  // The SAME Stack class works with Strings — no rewriting needed!
  var wordStack = Stack<String>();
  wordStack.push('apple');
  wordStack.push('banana');
  wordStack.push('cherry');
  print(wordStack); // Stack: [apple, banana, cherry]
  print('Popped: ${wordStack.pop()}'); // Popped: cherry

  // Type safety: this would be a compile error:
  // numberStack.push('hello');  // Error! Can't push String into Stack<int>

  // ============================================================
  // 3. MULTIPLE TYPE PARAMETERS - When you need more than one type
  //    Some classes need TWO or more type placeholders.
  //    For example, a Pair holds two values of DIFFERENT types.
  //
  //    Convention: <K, V> for key-value, <A, B> for two items,
  //    or <T1, T2> when there's no obvious meaning.
  // ============================================================
  print('\n--- 3. Multiple Type Parameters ---');

  // Pair<A, B> — holds two values of potentially different types
  var nameAndAge = Pair<String, int>('Alice', 30);
  print(nameAndAge); // Pair(Alice, 30)
  print('Name: ${nameAndAge.first}'); // Name: Alice
  print('Age: ${nameAndAge.second}'); // Age: 30

  // Both types can be the same too
  var coordinates = Pair<double, double>(42.3, -71.1);
  print(coordinates); // Pair(42.3, -71.1)

  // KeyValue<K, V> — like a Map entry
  var setting = KeyValue<String, bool>('darkMode', true);
  print(setting); // darkMode: true

  var score = KeyValue<String, int>('Player1', 9500);
  print(score); // Player1: 9500

  // ============================================================
  // 4. GENERIC METHODS / FUNCTIONS - Generic logic without a class
  //    You don't always need a whole class. Sometimes a single
  //    function needs to work with multiple types.
  //
  //    Put <T> right after the function name to make it generic.
  //    Dart can often INFER the type from the argument, so you
  //    don't always need to write <int> or <String> explicitly.
  // ============================================================
  print('\n--- 4. Generic Methods / Functions ---');

  // Generic function: getFirst<T> — returns the first item of any list
  print(getFirst<int>([10, 20, 30])); // 10
  print(getFirst<String>(['a', 'b', 'c'])); // a

  // Dart can INFER the type — you don't need to write <int>
  print(getFirst([100, 200, 300])); // 100  (Dart infers <int>)

  // Generic function: wrapInList<T> — wraps any single value in a list
  print(wrapInList(42)); // [42]
  print(wrapInList('hello')); // [hello]
  print(wrapInList(true)); // [true]

  // Generic function: swapPair<A, B> — swaps the values in a Pair
  var original = Pair<String, int>('age', 25);
  var swapped = swapPair(original);
  print('Original: $original'); // Original: Pair(age, 25)
  print('Swapped: $swapped'); // Swapped: Pair(25, age)

  // ============================================================
  // 5. BOUNDED GENERICS (extends) - Restrict what types are allowed
  //    Sometimes "any type" is too broad. You might need T to have
  //    certain methods or properties. Use "extends" to set a limit.
  //
  //    <T extends num>   → T must be num, int, or double
  //    <T extends Animal> → T must be Animal or any subclass
  //
  //    This gives you type safety AND access to the base class's
  //    methods inside your generic code.
  // ============================================================
  print('\n--- 5. Bounded Generics ---');

  // MathBox<T extends num> — only works with numbers (int, double)
  var intMath = MathBox<int>([3, 7, 1, 9, 4]);
  print('Numbers: $intMath'); // Numbers: MathBox([3, 7, 1, 9, 4])
  print('Sum: ${intMath.sum()}'); // Sum: 24
  print('Max: ${intMath.max()}'); // Max: 9
  print('Min: ${intMath.min()}'); // Min: 1

  var doubleMath = MathBox<double>([2.5, 8.1, 3.7]);
  print('Sum: ${doubleMath.sum()}'); // Sum: 14.3

  // This would NOT compile — String doesn't extend num:
  // var stringMath = MathBox<String>(['a', 'b']);  // Error!

  // SortedCollection<T extends Comparable> — items must be sortable
  var sortedNumbers = SortedCollection<int>([5, 2, 8, 1, 9, 3]);
  print('Sorted: ${sortedNumbers.sorted()}'); // Sorted: [1, 2, 3, 5, 8, 9]

  var sortedWords = SortedCollection<String>(['banana', 'apple', 'cherry']);
  print('Sorted: ${sortedWords.sorted()}'); // Sorted: [apple, banana, cherry]

  // ============================================================
  // 6. GENERICS WITH INHERITANCE - Combine generics + class hierarchies
  //    Generic classes can extend other generic classes.
  //    This lets you build specialized versions of generic containers.
  //
  //    Base:       Repository<T>         — basic CRUD operations
  //    Child:      LoggedRepository<T>   — adds logging to every operation
  // ============================================================
  print('\n--- 6. Generics with Inheritance ---');

  var userRepo = LoggedRepository<String>('UserRepo');
  userRepo.add('Alice');
  userRepo.add('Bob');
  userRepo.add('Carol');
  // Prints:
  //   [UserRepo] Added: Alice
  //   [UserRepo] Added: Bob
  //   [UserRepo] Added: Carol

  print('All users: ${userRepo.getAll()}'); // All users: [Alice, Bob, Carol]
  print('First: ${userRepo.getById(0)}'); // First: Alice

  userRepo.remove('Bob');
  // Prints: [UserRepo] Removed: Bob
  print('After remove: ${userRepo.getAll()}'); // After remove: [Alice, Carol]

  // Same LoggedRepository works with any type
  var numberRepo = LoggedRepository<int>('NumberRepo');
  numberRepo.add(100);
  numberRepo.add(200);
  // Prints:
  //   [NumberRepo] Added: 100
  //   [NumberRepo] Added: 200
  print('Numbers: ${numberRepo.getAll()}'); // Numbers: [100, 200]

  // ============================================================
  // 7. REAL-WORLD EXAMPLE: Menu Collection
  //    This combines multiple concepts:
  //    - Generic class: Collection<T> works with any type
  //    - Inheritance: Pizza and Burger extend MenuItem
  //    - toString() override: each item prints differently
  //    - Polymorphism: Collection<MenuItem> holds all subtypes
  //
  //    The Collection class doesn't care whether it holds
  //    MenuItems, Strings, or ints — it works the same way.
  // ============================================================
  print('\n--- 7. Real-World Example: Menu Collection ---');

  var noodle = MenuItem('Veg Noodles', 9.99);
  var pizza = Pizza(['pepperoni', 'mushrooms'], 'Veg Pizza', 15.99);
  var roast = MenuItem('Veggie Roast Dinner', 12.49);
  var kebab = MenuItem('Plant Kebab', 7.49);

  print(noodle); // Veg Noodles --> $9.99
  print(pizza);
  // PIZZA: Veg Pizza
  //  PRICE: $15.99
  //  TOPPINGS: pepperoni, mushrooms

  // Create a typed collection — only MenuItems allowed
  var menu = Collection<MenuItem>('Food Menu', [noodle, pizza, roast, kebab]);
  print('\nCollection name: ${menu.name}');
  print('Total items: ${menu.length}');
  print('Random pick: ${menu.randomItem()}');

  // Collection works with simple types too
  var luckyNumbers = Collection<int>('Lucky Numbers', [7, 13, 21, 42]);
  print('\n${luckyNumbers.name}: ${luckyNumbers.data}');
  print('Random lucky number: ${luckyNumbers.randomItem()}');

  var greetings = Collection<String>(
    'Greetings',
    ['Hello', 'Hi', 'Hey', 'Howdy'],
  );
  print('Random greeting: ${greetings.randomItem()}');

  // Print the full menu
  print('\n--- Full Menu ---');
  for (var item in menu.data) {
    print(item);
    print('---');
  }
}

// ============================================================
//  CLASS & FUNCTION DEFINITIONS
// ============================================================

// ---- Section 1: The problem without generics ----

// WITHOUT generics — accepts anything, no type checking
class UnsafeBox {
  dynamic item; // could be anything — int, String, bool...

  UnsafeBox(this.item);
}

// WITH generics — T is a placeholder for the actual type
class SafeBox<T> {
  T item;

  SafeBox(this.item);
}

// ---- Section 2: Basic generic class ----

// Stack<T> — a last-in-first-out (LIFO) data structure
// Works with any type: Stack<int>, Stack<String>, Stack<MyClass>, etc.
class Stack<T> {
  final List<T> _items = [];

  // Push an item onto the top of the stack
  void push(T item) {
    _items.add(item);
  }

  // Remove and return the top item
  T pop() {
    if (_items.isEmpty) throw StateError('Stack is empty');
    return _items.removeLast();
  }

  // Look at the top item without removing it
  T peek() {
    if (_items.isEmpty) throw StateError('Stack is empty');
    return _items.last;
  }

  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;

  @override
  String toString() => 'Stack: $_items';
}

// ---- Section 3: Multiple type parameters ----

// Pair<A, B> — holds two values of potentially different types
class Pair<A, B> {
  A first;
  B second;

  Pair(this.first, this.second);

  @override
  String toString() => 'Pair($first, $second)';
}

// KeyValue<K, V> — a key-value pair, like a single Map entry
class KeyValue<K, V> {
  K key;
  V value;

  KeyValue(this.key, this.value);

  @override
  String toString() => '$key: $value';
}

// ---- Section 4: Generic methods / functions ----

// Returns the first element of any typed list
T getFirst<T>(List<T> items) {
  if (items.isEmpty) throw StateError('List is empty');
  return items.first;
}

// Wraps any single value into a List
List<T> wrapInList<T>(T item) {
  return [item];
}

// Swaps the two values in a Pair — note the return type flips from <A,B> to <B,A>
Pair<B, A> swapPair<A, B>(Pair<A, B> pair) {
  return Pair<B, A>(pair.second, pair.first);
}

// ---- Section 5: Bounded generics ----

// MathBox<T extends num> — only accepts number types (int, double)
// Because T extends num, we can use num methods like + and compareTo
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

// ---- Section 6: Generics with inheritance ----

// Base generic class — simple in-memory repository
class Repository<T> {
  final List<T> _items = [];

  void add(T item) {
    _items.add(item);
  }

  void remove(T item) {
    _items.remove(item);
  }

  T getById(int index) {
    return _items[index];
  }

  List<T> getAll() {
    return List.unmodifiable(_items);
  }

  int get length => _items.length;
}

// Child generic class — adds logging to every operation
class LoggedRepository<T> extends Repository<T> {
  String repoName;

  LoggedRepository(this.repoName);

  @override
  void add(T item) {
    print('[$repoName] Added: $item');
    super.add(item);
  }

  @override
  void remove(T item) {
    print('[$repoName] Removed: $item');
    super.remove(item);
  }
}

// ---- Section 7: Real-world menu example ----

class MenuItem {
  String title;
  double price;

  MenuItem(this.title, this.price);

  String format() {
    return '$title --> \$$price';
  }

  @override
  String toString() {
    return format();
  }
}

class Pizza extends MenuItem {
  List<String> toppings;

  Pizza(this.toppings, super.title, super.price);

  @override
  String format() {
    var formattedToppings = toppings.join(', ');
    return 'PIZZA: $title\n PRICE: \$$price\n TOPPINGS: $formattedToppings';
  }
}

// Collection<T> — a generic wrapper around a list of any type
// This is the KEY generics example: the SAME class works for
// Collection<MenuItem>, Collection<int>, Collection<String>, etc.
class Collection<T> {
  String name;
  List<T> data;

  Collection(this.name, this.data);

  // Returns a random item — the return type is T, not dynamic!
  // This means Dart knows the exact type of what comes back.
  T randomItem() {
    data.shuffle();
    return data[0];
  }

  int get length => data.length;
}

// =============================================================================
//  NOTES: Generics — Complete Summary
// =============================================================================
//
//  WHAT ARE GENERICS?
//  ------------------
//  Generics let you write classes, methods, and functions that work with
//  ANY type while still keeping type safety. You use a placeholder letter
//  (like T) that gets replaced with a real type when you use it.
//
//  WHY USE GENERICS?
//  -----------------
//  Without generics, you have two bad options:
//    1. Write separate classes for each type (IntBox, StringBox, BoolBox...)
//       → too much duplicate code!
//    2. Use "dynamic" to accept anything
//       → no type safety, bugs hide until runtime!
//
//  Generics give you the BEST of both worlds:
//    → Write the code ONCE (like using dynamic)
//    → But keep full type safety (like using specific types)
//
//  SYNTAX QUICK REFERENCE:
//  -----------------------
//  Generic class:     class Box<T> { T item; }
//  Using it:          var b = Box<int>();
//  Multiple params:   class Pair<A, B> { A first; B second; }
//  Generic function:  T getFirst<T>(List<T> items) { ... }
//  Bounded generic:   class NumBox<T extends num> { ... }
//
//  COMMON TYPE PARAMETER NAMES:
//  ----------------------------
//  T  → Type          (the most common, general-purpose)
//  E  → Element       (used in collections: List<E>, Set<E>)
//  K  → Key           (used in maps: Map<K, V>)
//  V  → Value         (used in maps: Map<K, V>)
//  R  → Return type   (used in functions)
//  S  → Second type   (when T is already taken)
//
//  BOUNDED GENERICS:
//  -----------------
//  Use "extends" to restrict what types are allowed:
//    <T extends num>         → only int, double (number types)
//    <T extends Comparable>  → only types that can be sorted
//    <T extends Animal>      → only Animal and its subclasses
//
//  Without a bound, <T> is the same as <T extends Object?> (allows anything).
//
//  TYPE INFERENCE:
//  ---------------
//  Dart is often smart enough to figure out the type automatically:
//    var box = SafeBox<int>(42);    // explicit: you tell Dart it's int
//    var box = SafeBox(42);         // inferred: Dart figures out it's int
//  Both are valid. Be explicit when it makes the code clearer.
//
//  GENERICS IN DART'S BUILT-IN TYPES:
//  -----------------------------------
//  You've been using generics all along!
//    List<int>              → a list that only holds ints
//    Map<String, dynamic>   → a map with String keys, any values
//    Set<String>            → a set of unique strings
//    Future<int>            → a future that resolves to an int
//    Stream<String>         → a stream that emits strings
//
//  GENERICS vs DYNAMIC vs OBJECT:
//  ------------------------------
//  dynamic:   No type checking at all. Errors at RUNTIME.
//               dynamic x = 'hi'; x.foo(); // compiles but crashes
//  Object:    Type-safe but you lose the specific type info.
//               Object x = 'hi'; x.length; // Error! Object has no .length
//  Generics:  Type-safe AND you keep the specific type info.
//               T x = 'hi'; x.length; // Works! Dart knows T is String
//
//  KEY CONCEPTS TABLE:
//  -------------------
//  #  | TOPIC                          | WHAT IT TEACHES
// ----|--------------------------------|-------------------------------------------
//  1  | Problem without generics       | dynamic is risky, no compile-time checks
//  2  | Basic generic class            | Stack<T> works with any type safely
//  3  | Multiple type parameters       | Pair<A, B> and KeyValue<K, V>
//  4  | Generic methods / functions    | getFirst<T>(), wrapInList<T>(), swapPair()
//  5  | Bounded generics               | MathBox<T extends num> restricts types
//  6  | Generics with inheritance      | LoggedRepository<T> extends Repository<T>
//  7  | Real-world menu example        | Collection<MenuItem> ties everything together
// ----|--------------------------------|-------------------------------------------
//
//  REMEMBER:
//  - Generics are resolved at COMPILE time — no runtime cost
//  - <T> is a placeholder, not a real type — it gets replaced when you use it
//  - You can use generics on classes, methods, functions, and type aliases
//  - Bounded generics (<T extends X>) let you call methods from X on T
//  - Dart's type inference often makes the <T> explicit annotation optional
//  - Generics are one of the most important features for writing reusable code
//
// =============================================================================
