//------------------------------------------------------------------------------
// D A R T  B A S I C S
//------------------------------------------------------------------------------
// SAMPLE 1: CONST — Compile-Time Constants
//------------------------------------------------------------------------------
//
// `const` means the value is fixed BEFORE the app even starts running.
// The Dart compiler knows the value at COMPILE TIME.
//
// Think of it like a fact printed in a textbook:
// "The speed of light is 299,792,458 m/s" — it was decided before you
// opened the book. It doesn't change.
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Declare const int                     | Number that never changes
//  2  | Declare const bool                    | True/false known at compile time
//  3  | Declare const double                  | Decimal that never changes
//  4  | Declare const String                  | Text that never changes
//  5  | const vs final (why const here?)      | Shows what makes const special
// -----------------------------------------------------------------------
//
// COMPILE TIME vs RUNTIME:
//   Compile time → When Dart checks and prepares your code BEFORE the app runs.
//   Runtime      → When your app is actually running and doing things.
//
// RULE: If the value is known BEFORE the app runs → use `const`.
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. CONST INT — A number that never changes
  //    The value 25 is known before the app starts.
  //    The compiler "bakes" this value into the program.
  // ============================================================
  const int age = 25;
  print('Age: $age'); // Age: 25

  // ============================================================
  // 2. CONST BOOL — A true/false that never changes
  //    true is a literal value — known at compile time.
  // ============================================================
  const bool isAging = true;
  print('Is the user aging? : $isAging'); // Is the user aging? : true

  // ============================================================
  // 3. CONST DOUBLE — A decimal number that never changes
  //    Pi is always 3.14159... — perfect for const.
  // ============================================================
  const double pi = 3.14159;
  print('Pi: $pi'); // Pi: 3.14159

  const double gravity = 9.8;
  print('Gravity: $gravity m/s²'); // Gravity: 9.8 m/s²

  // ============================================================
  // 4. CONST STRING — Text that never changes
  //    The app name is decided before the app runs.
  // ============================================================
  const String appName = 'Dart Basics App';
  print('App: $appName'); // App: Dart Basics App

  const String greeting = 'Hello, Dart!';
  print(greeting); // Hello, Dart!

  // ============================================================
  // 5. WHY CONST AND NOT FINAL?
  //    Both const and final can only be assigned once.
  //    The difference:
  //      const → value MUST be known at compile time (before app runs)
  //      final → value can be set at runtime (while app runs)
  //
  //    These are all valid as const because their values are
  //    simple literals known before the app starts:
  //      25, true, 3.14159, 'Hello' — all known at compile time.
  //
  //    This would NOT work with const:
  //      const DateTime now = DateTime.now(); // ERROR!
  //    Because DateTime.now() is only known at RUNTIME.
  //    (See Sample 2 for how `final` handles this.)
  // ============================================================
  print('');
  print('--- Summary ---');
  print('const int age = $age');
  print('const bool isAging = $isAging');
  print('const double pi = $pi');
  print('const String appName = $appName');
  print('All values above were known BEFORE the app started running.');
}

// ============================================================
// NOTES: const — Compile-Time Constants
// ============================================================
//  1. `const` values are determined at COMPILE TIME (before the app runs).
//  2. The value MUST be a literal or a compile-time expression.
//     - Valid:   const x = 5;  const y = 'hello';  const z = 5 + 3;
//     - Invalid: const t = DateTime.now(); (runtime value!)
//  3. `const` variables are implicitly `final` (can't be reassigned).
//  4. `const` is more restrictive than `final` — if you CAN use const, DO.
//     The compiler can optimize const values better.
//  5. Common use cases:
//     - Math constants (pi, e, gravity)
//     - App configuration that never changes
//     - Color values, padding sizes in Flutter
//     - API endpoints, error messages
// ============================================================
