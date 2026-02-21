//------------------------------------------------------------------------------
// F U N C T I O N S  —  D Y N A M I C  ( N O  T Y P E  A N N O T A T I O N S )
//------------------------------------------------------------------------------
//
// When you don't specify types, Dart uses 'dynamic' type by default.
// This means the function can accept ANY type of data and return anything.
//
// Think of it like a mystery box:
// You can put ANYTHING in it — a string, a number, a boolean, a list...
// But when you open it, you don't know what you'll get!
// That's dangerous because you might try to use it the wrong way.
//
// -----------------------------------------------------------------------
//  #  | WHAT'S COVERED                          | KEY CONCEPT
// -----------------------------------------------------------------------
//  1  | Function with no type annotations       | dynamic params & return
//  2  | Passing any type (strings, ints, bools) | No compile-time checks
//  3  | Why this is dangerous                    | Runtime errors, no safety
//  4  | Comparing typed vs untyped functions     | Safety vs flexibility
//  5  | When dynamic IS appropriate              | Rare but valid use cases
// -----------------------------------------------------------------------
//
// IMPORTANT: Avoid this in production code! Always prefer typed functions.
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. FUNCTION WITH NO TYPE ANNOTATIONS
  //    When you omit the return type and parameter types, Dart
  //    treats everything as 'dynamic'. The function accepts ANY
  //    type and can return ANYTHING.
  //
  //    No return type = dynamic return (can return anything)
  //    No param type  = dynamic param (can accept anything)
  // ============================================================
  print('=== No type annotations (everything is dynamic) ===');

  // This works — passing String and int (the "intended" use)
  var result1 = greet('Luigi', 25);
  print(result1);
  // Output: Hi my name is Luigi and I am 25 years old

  print('');

  // ============================================================
  // 2. PASSING ANY TYPE — No compile-time checking!
  //    Because there are no type annotations, Dart allows you to
  //    pass absolutely ANYTHING. An int where a name should be?
  //    A boolean where an age should be? No problem — until runtime!
  // ============================================================
  print('=== Passing unexpected types ===');

  // Passing int and bool instead of String and int — NO ERROR!
  var result2 = greet(10, true);
  print(result2);
  // Output: Hi my name is 10 and I am true years old
  // Works because string interpolation calls .toString() on everything

  // Passing two strings
  var result3 = greet('Hello', 'World');
  print(result3);
  // Output: Hi my name is Hello and I am World years old

  // Passing a list and a map — still no error!
  var result4 = greet([1, 2, 3], {'key': 'value'});
  print(result4);
  // Output: Hi my name is [1, 2, 3] and I am {key: value} years old

  print('');

  // ============================================================
  // 3. WHY THIS IS DANGEROUS — Runtime errors
  //    String interpolation ($variable) just calls .toString(),
  //    so it works with anything. But what if you try to DO
  //    something with the values? Then you'll get runtime errors.
  // ============================================================
  print('=== Why dynamic is dangerous ===');

  // This function tries to do math — it expects numbers!
  var sum1 = addUnsafe(10, 20);
  print('addUnsafe(10, 20) = $sum1'); // Works: 30

  // But if we pass strings... RUNTIME ERROR (uncomment to see):
  // var sum2 = addUnsafe('hello', 'world');
  // The + operator on strings concatenates, so this returns 'helloworld'
  // That's a BUG, not an error — even sneakier!
  var sum2 = addUnsafe('hello', 'world');
  print('addUnsafe("hello", "world") = $sum2'); // "helloworld" — not a number!
  print('  ^ This is a bug! We wanted addition, got string concatenation.');

  print('');

  // ============================================================
  // 4. COMPARING TYPED VS UNTYPED FUNCTIONS
  //    Let's see the same function written both ways.
  //    The typed version catches mistakes at COMPILE TIME.
  //    The untyped version only fails at RUNTIME (or silently bugs).
  // ============================================================
  print('=== Typed vs untyped comparison ===');

  // TYPED version — safe and clear
  int typedResult = addSafe(10, 20);
  print('addSafe(10, 20) = $typedResult'); // 30

  // This would NOT compile:
  // int badResult = addSafe('hello', 'world'); // COMPILE ERROR!
  // Dart catches the mistake BEFORE you even run the code.

  // UNTYPED version — no safety net
  var untypedResult = addUnsafe(10, 20);
  print('addUnsafe(10, 20) = $untypedResult'); // 30 — same result, but no safety

  print('');

  // ============================================================
  // 5. WHEN DYNAMIC IS APPROPRIATE
  //    There are rare cases where dynamic is useful:
  //    - Working with JSON data from an API (before parsing)
  //    - Writing generic utility functions
  //    - Interoperating with JavaScript (in web apps)
  //    - Quick prototyping (but add types before shipping!)
  // ============================================================
  print('=== Legitimate use of dynamic ===');

  // Example: a function that prints any value with its type
  printInfo('Hello');
  printInfo(42);
  printInfo(3.14);
  printInfo(true);
  printInfo([1, 2, 3]);

  print('');

  // Example: a function that safely converts anything to String
  String s1 = safeToString(42);
  String s2 = safeToString(null);
  String s3 = safeToString('already a string');
  print('safeToString(42) = "$s1"');
  print('safeToString(null) = "$s2"');
  print('safeToString("already a string") = "$s3"');

  print('');
}

// --- Helper functions ---

// NO type annotations = everything is dynamic
// No return type → returns 'dynamic' (could be anything)
// No param types → accepts 'dynamic' (could be anything)
greet(name, age) {
  return 'Hi my name is $name and I am $age years old';
}

// DANGEROUS: No types means + could be addition OR concatenation
addUnsafe(a, b) {
  return a + b; // int + int = addition, String + String = concatenation!
}

// SAFE: Types enforce that only ints are accepted
int addSafe(int a, int b) {
  return a + b; // Always integer addition — guaranteed!
}

// LEGITIMATE USE: A utility that needs to accept any type
// Using 'dynamic' explicitly (same as omitting the type, but more intentional)
void printInfo(dynamic value) {
  print('  Value: $value (Type: ${value.runtimeType})');
}

// LEGITIMATE USE: Safe conversion from anything to String
String safeToString(dynamic value) {
  if (value == null) return '(null)';
  return value.toString();
}

//------------------------------------------------------------------------------
// NOTES:
//------------------------------------------------------------------------------
//
//  1. Omitting types = dynamic (accepts anything, returns anything)
//  2. Dart won't catch type mistakes at compile time with dynamic
//  3. Errors only appear at RUNTIME — much harder to debug
//  4. String interpolation ($var) hides the problem because it calls .toString()
//  5. The + operator behaves differently for different types:
//     - int + int = addition (10 + 20 = 30)
//     - String + String = concatenation ('hello' + 'world' = 'helloworld')
//     - int + String = RUNTIME ERROR!
//
//  WHY AVOID DYNAMIC:
//  ┌──────────────────────────────────┬──────────────────────────────────┐
//  │  Typed Functions                 │  Dynamic Functions              │
//  ├──────────────────────────────────┼──────────────────────────────────┤
//  │  Errors caught at compile time  │  Errors only at runtime         │
//  │  IDE gives autocomplete         │  No autocomplete or help        │
//  │  Code is self-documenting       │  Can't tell what types expected │
//  │  Refactoring is safe            │  Refactoring is risky           │
//  │  int add(int a, int b)          │  add(a, b)                      │
//  └──────────────────────────────────┴──────────────────────────────────┘
//
//  WHEN DYNAMIC IS OK:
//  - Parsing JSON before you know the structure
//  - Writing truly generic utilities (printInfo, safeToString)
//  - Quick prototyping (add types before shipping!)
//  - Interop with dynamically-typed languages (JavaScript)
//
//  RULE: "If you know the type, WRITE the type."
//
//------------------------------------------------------------------------------
