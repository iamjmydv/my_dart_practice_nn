//------------------------------------------------------------------------------
// T Y P E  A N N O T A T I O N S
//------------------------------------------------------------------------------
// SAMPLE 1: BASIC TYPE ANNOTATIONS — String, int, bool, double
//------------------------------------------------------------------------------
//
// Type annotations explicitly declare the data type of a variable.
// Format: <Type> variableName = value;
//
// This gives you:
//   - Better code clarity (you know what type a variable holds)
//   - IDE support (autocomplete, error highlighting)
//   - Compile-time error checking (catch bugs before running)
//
// Dart CAN infer types using `var`, but explicit types improve readability.
//
// Think of it like labeling boxes when moving:
// A box labeled "Kitchen — Plates" is clearer than an unmarked box.
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | String — text/character sequences      | Names, messages, any text
//  2  | int — whole numbers                    | Age, count, IDs
//  3  | bool — true or false                   | Flags, conditions, toggles
//  4  | double — decimal numbers               | Prices, ratings, measurements
//  5  | No char type in Dart                   | Single characters are Strings
//  6  | var vs explicit types                  | When to use which
// -----------------------------------------------------------------------
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. STRING — Used for text/character sequences
  //    Can use single quotes ('') or double quotes ("")
  //    Both are identical in Dart — pick one and be consistent.
  //
  //    Format: String variableName = 'text';
  // ============================================================
  print('=== String ===');

  String name = 'Mario';
  print('Name: $name'); // Name: Mario

  String greeting = "Hello, World!";
  print('Greeting: $greeting'); // Hello, World!

  // Strings have useful properties and methods
  print('Length: ${name.length}'); // Length: 5
  print('Uppercase: ${name.toUpperCase()}'); // Uppercase: MARIO
  print('Contains "ar": ${name.contains("ar")}'); // Contains "ar": true

  print('');

  // ============================================================
  // 2. INT — Used for whole numbers (no decimal points)
  //    Range: -2^63 to 2^63 - 1 on 64-bit systems
  //    That's roughly -9.2 quintillion to 9.2 quintillion.
  //
  //    Format: int variableName = number;
  // ============================================================
  print('=== int ===');

  int age = 25;
  print('Age: $age'); // Age: 25

  int score = 1000;
  print('Score: $score'); // Score: 1000

  int negativeNumber = -42;
  print('Negative: $negativeNumber'); // Negative: -42

  // int supports basic math operations
  print('age + 5 = ${age + 5}'); // 30
  print('score * 2 = ${score * 2}'); // 2000
  print('Is age even? ${age.isEven}'); // Is age even? false

  print('');

  // ============================================================
  // 3. BOOL — Boolean type with only two values: true or false
  //    Used for conditional logic, flags, and toggles.
  //    Named after George Boole (mathematician).
  //
  //    Format: bool variableName = true/false;
  // ============================================================
  print('=== bool ===');

  bool isOpen = true;
  print('Is open: $isOpen'); // Is open: true

  bool isLoggedIn = false;
  print('Is logged in: $isLoggedIn'); // Is logged in: false

  // Booleans are used in conditions
  if (isOpen) {
    print('The store is open!');
  }

  // You can negate a bool with !
  print('Is NOT open: ${!isOpen}'); // Is NOT open: false

  print('');

  // ============================================================
  // 4. DOUBLE — Used for floating-point numbers (decimals)
  //    64-bit double-precision floating-point numbers.
  //    Use for prices, ratings, measurements, percentages, etc.
  //
  //    Format: double variableName = number.decimal;
  // ============================================================
  print('=== double ===');

  double averageRating = 8.75;
  print('Rating: $averageRating'); // Rating: 8.75

  double price = 19.99;
  print('Price: \$$price'); // Price: $19.99

  double temperature = -3.5;
  print('Temperature: $temperature°C'); // Temperature: -3.5°C

  // An int value assigned to a double
  double wholeAsDouble = 10.0;
  print('Whole as double: $wholeAsDouble'); // Whole as double: 10.0

  // double has useful methods
  print('Rounded rating: ${averageRating.round()}'); // 9
  print('Price ceiling: ${price.ceil()}'); // 20
  print('Price floor: ${price.floor()}'); // 19

  print('');

  // ============================================================
  // 5. NO CHAR TYPE IN DART
  //    Unlike C, C++, or Java, Dart does NOT have a `char` type.
  //    A single character is just a String of length 1.
  //
  //    In Java:    char letter = 'A';   // char type
  //    In Dart:    String letter = 'A'; // still a String
  // ============================================================
  print('=== No char type ===');

  String bloodType = 'A';
  print('Blood type: $bloodType'); // Blood type: A
  print('Length: ${bloodType.length}'); // Length: 1
  print('Is it a String? Yes! Dart has no char type.');

  String initial = 'M';
  print('Initial: $initial'); // Initial: M

  print('');

  // ============================================================
  // 6. VAR vs EXPLICIT TYPES — When to use which
  //    `var` lets Dart INFER the type from the assigned value.
  //    The type is still fixed — you just don't write it.
  //
  //    var name = 'Mario';     → Dart infers String
  //    String name = 'Mario';  → You explicitly declare String
  //
  //    Both are the SAME — the variable is a String either way.
  //    Explicit types are preferred for readability in most cases.
  // ============================================================
  print('=== var vs explicit types ===');

  var inferredName = 'Luigi'; // Dart infers: String
  var inferredAge = 30; // Dart infers: int
  var inferredHeight = 5.8; // Dart infers: double
  var inferredFlag = true; // Dart infers: bool

  print('var name: $inferredName (${inferredName.runtimeType})');
  print('var age: $inferredAge (${inferredAge.runtimeType})');
  print('var height: $inferredHeight (${inferredHeight.runtimeType})');
  print('var flag: $inferredFlag (${inferredFlag.runtimeType})');

  // inferredName = 42; // ERROR! Type was inferred as String, can't assign int.
  // Once Dart infers the type, it's LOCKED — just like an explicit type.

  print('');
  print('--- Summary ---');
  print('String  → text        (e.g., "Mario")');
  print('int     → whole number (e.g., 25)');
  print('bool    → true/false   (e.g., true)');
  print('double  → decimal      (e.g., 8.75)');
  print('No char → use String   (e.g., "A")');
}

// ============================================================
// NOTES: Basic Type Annotations
// ============================================================
//  1. String  → text, single or double quotes, no char type
//  2. int     → whole numbers, supports math operations
//  3. bool    → true or false, used in conditions
//  4. double  → decimal numbers, 64-bit precision
//  5. var     → type inferred by Dart, still type-safe
//
//  FORMAT: <Type> variableName = value;
//
//  WHY USE EXPLICIT TYPES?
//    - Code is clearer (you know the type at a glance)
//    - IDE gives better autocomplete
//    - Compiler catches type errors before you run the app
//
//  WHEN TO USE `var`?
//    - When the type is obvious from the right side
//    - var name = 'Mario';  → clearly a String
//    - var count = 0;       → clearly an int
// ============================================================
