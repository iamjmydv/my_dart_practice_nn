//------------------------------------------------------------------------------
// D A R T  B A S I C S
//------------------------------------------------------------------------------
// SAMPLE 2: FINAL — Runtime Constants
//------------------------------------------------------------------------------
//
// `final` means the variable can only be set ONCE, but the value
// does NOT need to be known at compile time — it can be decided
// while the app is running (at RUNTIME).
//
// Think of it like your birthday:
// You don't know today's date until the day actually comes (runtime),
// but once the day arrives, it's set — it won't change.
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | final with DateTime.now()             | Value decided at runtime
//  2  | final with late assignment            | Declare now, assign once later
//  3  | final with String                     | Runtime string that won't change
//  4  | final with expressions                | Computed once at runtime
//  5  | const vs final comparison             | When to use which
// -----------------------------------------------------------------------
//
// COMPILE TIME vs RUNTIME:
//   Compile time → When Dart checks and prepares your code BEFORE the app runs.
//   Runtime      → When your app is actually running and doing things.
//
// RULE: If the value is only known WHILE the app runs → use `final`.
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. FINAL WITH DateTime.now() — Classic runtime example
  //    DateTime.now() returns the current date and time.
  //    This value is only known when the app RUNS, not before.
  //    Once set, it cannot be changed.
  //
  //    This is WHY we use `final` instead of `const`:
  //      const DateTime now = DateTime.now(); // ERROR! Not known at compile time.
  //      final DateTime now = DateTime.now(); // OK! Set once at runtime.
  // ============================================================
  final DateTime currentTime = DateTime.now();
  print('Current time: $currentTime');
  // Example output: Current time: 2024-03-15 14:30:45.123456

  // currentTime = DateTime.now(); // ERROR! Can't reassign a final variable.

  // ============================================================
  // 2. FINAL WITH LATE ASSIGNMENT — Declare now, assign later
  //    You can declare a `final` variable without a value,
  //    then assign it ONCE later. After that, it's locked.
  //
  //    This is useful when you don't have the value yet
  //    but know you'll set it exactly once.
  // ============================================================
  final String name;
  // Some logic could happen here...
  name = 'Mario'; // First assignment — OK!
  print('Name: $name'); // Name: Mario
  // name = 'Luigi'; // ERROR! Already assigned. Can't change a final.

  final int score;
  score = 100;
  print('Score: $score'); // Score: 100
  // score = 200; // ERROR! Already assigned.

  // ============================================================
  // 3. FINAL WITH STRING — Runtime strings
  //    Even though 'Hello' is a simple literal, using `final`
  //    is fine when you don't need compile-time optimization.
  //    In practice, both const and final work here,
  //    but final is more flexible if the value could change
  //    to a runtime source later.
  // ============================================================
  final String city = 'Tokyo';
  print('City: $city'); // City: Tokyo

  final String country = 'Japan';
  print('Country: $country'); // Country: Japan

  // ============================================================
  // 4. FINAL WITH EXPRESSIONS — Computed once at runtime
  //    The value is calculated when the line runs.
  //    Once calculated, it's stored and never recalculated.
  // ============================================================
  final int currentYear = DateTime.now().year;
  print('Current year: $currentYear');

  final int birthYear = 1999;
  final int userAge = currentYear - birthYear;
  print('Birth year: $birthYear');
  print('Calculated age: $userAge');

  // List.generate creates a list at RUNTIME — can't be const
  final List<int> numbers = List.generate(5, (i) => i + 1);
  print('Numbers: $numbers'); // Numbers: [1, 2, 3, 4, 5]

  // ============================================================
  // 5. CONST vs FINAL — When to use which
  //
  //    ┌──────────────────────────────────────────────────────┐
  //    │  Feature          │  const           │  final        │
  //    ├───────────────────┼──────────────────┼───────────────┤
  //    │  When is value    │  Compile time    │  Runtime      │
  //    │  determined?      │  (before app)    │  (during app) │
  //    │                   │                  │               │
  //    │  Can reassign?    │  No              │  No           │
  //    │                   │                  │               │
  //    │  DateTime.now()?  │  ERROR           │  OK           │
  //    │                   │                  │               │
  //    │  Simple literal?  │  OK (preferred)  │  OK           │
  //    │                   │                  │               │
  //    │  Computed value?  │  Only if all     │  OK           │
  //    │                   │  parts are const │               │
  //    └──────────────────────────────────────────────────────┘
  //
  //    Simple decision rule:
  //      "Is the value known BEFORE the app starts?"
  //         YES → use const
  //         NO  → use final
  // ============================================================
  print('');
  print('--- const vs final ---');

  // These could be const (values known at compile time):
  const String constGreeting = 'Hello'; // known before app runs
  print('const: $constGreeting');

  // These MUST be final (values only known at runtime):
  final String finalGreeting = 'Hello at ${DateTime.now()}'; // has runtime part
  print('final: $finalGreeting');
}

// ============================================================
// NOTES: final — Runtime Constants
// ============================================================
//  1. `final` variables can only be assigned ONCE.
//  2. The value does NOT need to be known at compile time.
//  3. Use `final` when the value depends on runtime information:
//     - DateTime.now(), user input, API responses, calculations
//  4. You can declare without a value and assign later (once).
//  5. `final` is less restrictive than `const`:
//     - const: compile-time only, more optimized
//     - final: runtime OK, more flexible
//  6. Common use cases:
//     - Current date/time
//     - User input values
//     - API response data
//     - Calculated values
//     - Object instances created at runtime
// ============================================================
