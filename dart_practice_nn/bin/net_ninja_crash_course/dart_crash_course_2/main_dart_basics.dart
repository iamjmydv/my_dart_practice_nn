//------------------------------------------------------------------------------
// D A R T  B A S I C S  —  C O M P L E T E  G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 3 samples into one runnable file.
// Dart Basics covers the fundamental building blocks:
//   - const (compile-time constants)
//   - final (runtime constants)
//   - String interpolation
//
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                    | KEY CONCEPTS                              | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | const (compile-time)     | const keyword, literal values             | Values known before the app runs
//  2  | final (runtime)          | final keyword, DateTime.now()             | Values set once while the app runs
//  3  | String interpolation     | $variable, ${expression}, concatenation   | Building dynamic text from variables
// -----------------------------------------------------------------------
//
// TIP: To run just ONE sample, comment out the others in main().
//
// -----------------------------------------------------------------------

void main() {
  // ============================================================
  //  Uncomment/comment any sample to run only what you want.
  //  Each sample is independent — they don't depend on each other.
  // ============================================================

  sample1Const();
  sample2Final();
  sample3StringInterpolation();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  CONST — Compile-Time Constants
//
//  `const` means the value is fixed BEFORE the app even starts running.
//  The Dart compiler knows the value at COMPILE TIME.
//
//  Think of it like a fact printed in a textbook:
//  "The speed of light is 299,792,458 m/s" — it was decided before you
//  opened the book. It doesn't change.
//
//  RULE: If the value is known BEFORE the app runs → use `const`.
//
// =============================================================================
// =============================================================================

void sample1Const() {
  print('');
  print('##############################################');
  print('# SAMPLE 1: const — Compile-Time Constants   #');
  print('##############################################');

  // ============================================================
  // 1. CONST INT — A number that never changes
  //    The value 25 is known before the app starts.
  // ============================================================
  const int age = 25;
  print('  Age: $age');

  // ============================================================
  // 2. CONST BOOL — A true/false that never changes
  // ============================================================
  const bool isAging = true;
  print('  Is the user aging? : $isAging');

  // ============================================================
  // 3. CONST DOUBLE — A decimal number that never changes
  //    Pi is always 3.14159... — perfect for const.
  // ============================================================
  const double pi = 3.14159;
  print('  Pi: $pi');

  const double gravity = 9.8;
  print('  Gravity: $gravity m/s²');

  // ============================================================
  // 4. CONST STRING — Text that never changes
  // ============================================================
  const String appName = 'Dart Basics App';
  print('  App: $appName');

  const String greeting = 'Hello, Dart!';
  print('  $greeting');

  // ============================================================
  // 5. WHY CONST AND NOT FINAL?
  //    Both can only be assigned once. The difference:
  //      const → value MUST be known at compile time
  //      final → value can be set at runtime
  //
  //    This would NOT work:
  //      const DateTime now = DateTime.now(); // ERROR!
  //    Because DateTime.now() is only known at RUNTIME.
  // ============================================================
  print('');
  print('  All values above were known BEFORE the app started running.');
  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  FINAL — Runtime Constants
//
//  `final` means the variable can only be set ONCE, but the value
//  does NOT need to be known at compile time — it can be decided
//  while the app is running (at RUNTIME).
//
//  Think of it like your birthday:
//  You don't know today's date until the day actually comes (runtime),
//  but once the day arrives, it's set — it won't change.
//
//  RULE: If the value is only known WHILE the app runs → use `final`.
//
// =============================================================================
// =============================================================================

void sample2Final() {
  print('##############################################');
  print('# SAMPLE 2: final — Runtime Constants         #');
  print('##############################################');

  // ============================================================
  // 1. FINAL WITH DateTime.now() — Classic runtime example
  //    DateTime.now() returns the current date and time.
  //    This value is only known when the app RUNS, not before.
  //
  //    const DateTime now = DateTime.now(); // ERROR!
  //    final DateTime now = DateTime.now(); // OK!
  // ============================================================
  final DateTime currentTime = DateTime.now();
  print('  Current time: $currentTime');

  // ============================================================
  // 2. FINAL WITH LATE ASSIGNMENT — Declare now, assign later
  //    Declare a `final` without a value, assign it ONCE later.
  // ============================================================
  final String name;
  name = 'Mario';
  print('  Name: $name');
  // name = 'Luigi'; // ERROR! Already assigned.

  final int score;
  score = 100;
  print('  Score: $score');

  // ============================================================
  // 3. FINAL WITH EXPRESSIONS — Computed once at runtime
  // ============================================================
  final int currentYear = DateTime.now().year;
  final int birthYear = 1999;
  final int userAge = currentYear - birthYear;
  print('  Birth year: $birthYear');
  print('  Current year: $currentYear');
  print('  Calculated age: $userAge');

  // List.generate creates a list at RUNTIME — can't be const
  final List<int> numbers = List.generate(5, (i) => i + 1);
  print('  Numbers: $numbers');

  // ============================================================
  // 4. CONST vs FINAL — Quick comparison
  //
  //    ┌──────────────────────────────────────────────────────┐
  //    │  Feature          │  const           │  final        │
  //    ├───────────────────┼──────────────────┼───────────────┤
  //    │  When determined? │  Compile time    │  Runtime      │
  //    │  Can reassign?    │  No              │  No           │
  //    │  DateTime.now()?  │  ERROR           │  OK           │
  //    │  Simple literal?  │  OK (preferred)  │  OK           │
  //    └──────────────────────────────────────────────────────┘
  //
  //    "Is the value known BEFORE the app starts?"
  //       YES → use const    NO → use final
  // ============================================================
  print('');
  const String constGreeting = 'Hello'; // compile time
  final String finalGreeting = 'Hello at ${DateTime.now()}'; // runtime
  print('  const: $constGreeting');
  print('  final: $finalGreeting');
  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  3:  STRING INTERPOLATION — Putting Variables Inside Strings
//
//  Interpolation means inserting a variable or expression into a string
//  using the $ symbol. It's how Dart builds dynamic text.
//
//  Think of it like a fill-in-the-blank sentence:
//  "Hello, ____!" → "Hello, $name!" → "Hello, Mario!"
//
//  QUICK RULE:
//    $variable         → simple variable (no braces needed)
//    ${expression}     → calculation, property access, or logic
//
// =============================================================================
// =============================================================================

void sample3StringInterpolation() {
  print('##############################################');
  print('# SAMPLE 3: String Interpolation              #');
  print('##############################################');

  // ============================================================
  // 1. $variable — Simple Variable Interpolation
  //    Use $ followed by the variable name.
  //    No braces {} needed for simple variables.
  // ============================================================
  print('  === Simple \$variable ===');

  String name = 'John';
  int age = 25;
  double height = 5.9;
  bool isDeveloper = true;

  print('  Name: $name');
  print('  Age: $age');
  print('  Height: $height ft');
  print('  Is developer: $isDeveloper');
  print('  $name is $age years old and $height ft tall.');

  print('');

  // ============================================================
  // 2. ${expression} — Expression Interpolation
  //    Use ${} when you need to:
  //      - Do a calculation
  //      - Call a method
  //      - Write any expression
  // ============================================================
  print('  === \${expression} ===');

  print('  Next year, $name will be ${age + 1} years old.');
  print('  Name in uppercase: ${name.toUpperCase()}');
  print('  Name length: ${name.length} characters');

  int width = 10;
  int length = 5;
  print('  Area: ${width * length} sq units');

  print('');

  // ============================================================
  // 3. ${object.property} — Accessing Object Properties
  //    You MUST use ${} for object properties.
  //    $person.name → WRONG (prints object + ".name")
  //    ${person.name} → CORRECT (prints the name field)
  // ============================================================
  print('  === \${object.property} ===');

  S3Person person = S3Person('Alice', 30);

  print('  Name: ${person.name}');
  print('  Age: ${person.age}');
  print('  ${person.name} is ${person.age} years old.');
  print('  Info: ${person.getInfo()}');

  print('');

  // ============================================================
  // 4. CONCATENATION vs INTERPOLATION
  //    Concatenation uses + to join strings.
  //    Interpolation uses $ to embed values.
  //    Interpolation is shorter, cleaner, and easier to read.
  // ============================================================
  print('  === Concatenation vs Interpolation ===');

  String firstName = 'Mario';
  String lastName = 'Bros';
  int playerScore = 1000;

  // CONCATENATION — old style (harder to read)
  // ignore: prefer_interpolation_to_compose_strings
  String msg1 = 'Player: ' + firstName + ' ' + lastName + ' | Score: ' + playerScore.toString();
  print('  $msg1');

  // INTERPOLATION — modern, cleaner
  String msg2 = 'Player: $firstName $lastName | Score: $playerScore';
  print('  $msg2');

  print('');
  print('  Summary:');
  print('  \$variable          → simple variable');
  print('  \${expression}      → calculation or method');
  print('  \${object.property} → object field');
  print('');
}

// --- Sample 3: Helper class ---

class S3Person {
  String name;
  int age;

  S3Person(this.name, this.age);

  String getInfo() {
    return '$name (age $age)';
  }
}

// =============================================================================
// =============================================================================
//  NOTES: Dart Basics — Complete Summary of ALL 3 Samples
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | TOPIC                    | KEY CONCEPTS
//  -----------------------------------------------------------------------
//   1  | const (compile-time)     | const keyword, values known before app runs
//   2  | final (runtime)          | final keyword, values set once during app run
//   3  | String interpolation     | $variable, ${expression}, ${object.property}
//  -----------------------------------------------------------------------
//
//  CONST vs FINAL — Quick Decision:
//  ┌────────────────────────────────────────────────────────────────────┐
//  │  "Is the value known BEFORE the app starts?"                      │
//  │     YES → use const    (e.g., pi = 3.14, appName = 'MyApp')      │
//  │     NO  → use final    (e.g., now = DateTime.now(), user input)   │
//  └────────────────────────────────────────────────────────────────────┘
//
//  STRING INTERPOLATION — Quick Rule:
//  ┌────────────────────────────────────────────────────────────────────┐
//  │  $variable          → simple variable         (e.g., $name)       │
//  │  ${expression}      → calculation or method   (e.g., ${age + 1})  │
//  │  ${object.property} → object field            (e.g., ${p.name})   │
//  │                                                                    │
//  │  TIP: When in doubt, use ${} — it always works.                   │
//  └────────────────────────────────────────────────────────────────────┘
//
// =============================================================================
