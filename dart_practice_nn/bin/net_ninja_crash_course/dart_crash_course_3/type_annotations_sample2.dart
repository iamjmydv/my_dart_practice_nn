//------------------------------------------------------------------------------
// T Y P E  A N N O T A T I O N S
//------------------------------------------------------------------------------
// SAMPLE 2: CONST & FINAL WITH TYPE ANNOTATIONS
//------------------------------------------------------------------------------
//
// When using `const` and `final`, you can (and should) include
// the type annotation for clarity.
//
// Format:
//   const <Type> variableName = value;    → compile-time constant
//   final <Type> variableName = value;    → runtime constant
//
// This combines type safety with immutability — the best of both worlds.
//
// Think of it like a locked, labeled box:
//   - The label (type) tells you what's inside
//   - The lock (const/final) prevents anyone from changing it
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | const with type annotations           | Typed compile-time constants
//  2  | final with type annotations           | Typed runtime constants
//  3  | Type annotation with late assignment   | Declare type now, assign later
//  4  | const vs final vs var — comparison     | Choose the right keyword
// -----------------------------------------------------------------------
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. CONST WITH TYPE ANNOTATIONS
  //    const <Type> name = value;
  //    The type annotation makes it explicit what kind of constant it is.
  //
  //    Without type: const age = 27;       → works, type inferred
  //    With type:    const int age = 27;   → clearer, preferred
  // ============================================================
  print('=== const with type annotations ===');

  const int newAge = 27;
  print('const int: $newAge'); // 27

  const String newName = 'Luigi';
  print('const String: $newName'); // Luigi

  const double pi = 3.14159;
  print('const double: $pi'); // 3.14159

  const bool isActive = true;
  print('const bool: $isActive'); // true

  // Multiple const values — all known at compile time
  const String appVersion = '1.0.0';
  const int maxRetries = 3;
  const double taxRate = 0.08;

  print('App: $appVersion, Max retries: $maxRetries, Tax: $taxRate');

  // const values MUST be known at compile time
  // const DateTime now = DateTime.now(); // ERROR! Runtime value.
  // const int random = Random().nextInt(10); // ERROR! Runtime value.

  print('');

  // ============================================================
  // 2. FINAL WITH TYPE ANNOTATIONS
  //    final <Type> name = value;
  //    Use when the value is determined at RUNTIME but won't change.
  //
  //    Without type: final time = DateTime.now();       → works
  //    With type:    final DateTime time = DateTime.now(); → clearer
  // ============================================================
  print('=== final with type annotations ===');

  final String friendName = 'Princess';
  print('final String: $friendName'); // Princess

  final DateTime currentTime = DateTime.now();
  print('final DateTime: $currentTime');

  final int currentYear = DateTime.now().year;
  print('final int (current year): $currentYear');

  // final values can use runtime expressions
  final double halfPi = pi / 2;
  print('final double (pi/2): $halfPi');

  final String uppercaseName = newName.toUpperCase();
  print('final String (uppercase): $uppercaseName'); // LUIGI

  print('');

  // ============================================================
  // 3. TYPE ANNOTATION WITH LATE ASSIGNMENT
  //    You can declare a final variable with a type but without
  //    a value, then assign it ONCE later. The type annotation
  //    ensures you assign the correct type.
  //
  //    Format: final <Type> name;
  //            name = value;  // assigned once later
  // ============================================================
  print('=== final with late assignment ===');

  final String heroName;
  // Some logic could happen here (e.g., reading from a config)...
  heroName = 'Princess'; // First assignment — OK!
  print('Hero: $heroName'); // Hero: Princess
  // heroName = 'Bowser'; // ERROR! Already assigned.

  final int playerScore;
  playerScore = 9999;
  print('Score: $playerScore'); // Score: 9999
  // playerScore = 0; // ERROR! Already assigned.

  // The type annotation helps catch mistakes:
  // final int wrongType;
  // wrongType = 'hello'; // ERROR! Can't assign String to int.

  print('');

  // ============================================================
  // 4. CONST vs FINAL vs VAR — When to use which
  //
  //    ┌────────────────────────────────────────────────────────┐
  //    │  Keyword │  Reassign? │  When decided? │  Type needed? │
  //    ├──────────┼────────────┼────────────────┼───────────────┤
  //    │  const   │  No        │  Compile time  │  Optional     │
  //    │  final   │  No        │  Runtime       │  Optional     │
  //    │  var     │  Yes       │  Runtime       │  Inferred     │
  //    │  <Type>  │  Yes       │  Runtime       │  Explicit     │
  //    └────────────────────────────────────────────────────────┘
  //
  //    Decision flow:
  //    1. Will the value NEVER change?
  //       → Is it known at compile time? → const
  //       → Is it only known at runtime? → final
  //    2. Will the value change later?
  //       → Use var or explicit type (String, int, etc.)
  // ============================================================
  print('=== const vs final vs var ===');

  const String constVal = 'I am const'; // never changes, compile time
  final String finalVal = 'I am final at ${DateTime.now()}'; // never changes, runtime
  String mutableVal = 'I am mutable'; // can change

  print(constVal);
  print(finalVal);
  print(mutableVal);

  // Only mutable variables can be reassigned
  mutableVal = 'I changed!';
  print(mutableVal); // I changed!

  // constVal = 'new value'; // ERROR! const can't be reassigned.
  // finalVal = 'new value'; // ERROR! final can't be reassigned.

  print('');
  print('--- Decision Rule ---');
  print('Value never changes + known at compile time → const');
  print('Value never changes + known at runtime      → final');
  print('Value might change later                    → var or <Type>');
}

// ============================================================
// NOTES: const & final with Type Annotations
// ============================================================
//  1. const <Type> name = value;  → typed compile-time constant
//  2. final <Type> name = value;  → typed runtime constant
//  3. final <Type> name;          → declare now, assign once later
//  4. Type annotations are optional but recommended for clarity
//
//  KEY DIFFERENCES:
//    const → value MUST be known before the app runs
//    final → value can be determined while the app runs
//    Both  → can only be assigned ONCE (immutable after that)
//
//  BEST PRACTICE:
//    - Always use const when possible (most optimized)
//    - Use final when the value is runtime-dependent
//    - Add type annotations for better readability
//    - Use var only when the type is obvious from context
// ============================================================
