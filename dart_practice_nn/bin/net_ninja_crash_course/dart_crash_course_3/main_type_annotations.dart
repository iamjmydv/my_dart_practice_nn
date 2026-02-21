//------------------------------------------------------------------------------
// T Y P E  A N N O T A T I O N S  —  C O M P L E T E  G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 3 samples into one runnable file.
// Type annotations explicitly declare the data type of a variable.
// This provides better code clarity, IDE support, and compile-time checking.
//
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                    | KEY CONCEPTS                              | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Basic type annotations   | String, int, bool, double, var            | Declare what type a variable holds
//  2  | const & final with types | const <Type>, final <Type>, late assign   | Immutable typed variables
//  3  | Nullable vs non-nullable | Type?, ??, ?., ??=, null checks           | Handle missing/optional values safely
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

  sample1BasicTypes();
  sample2ConstAndFinal();
  sample3NullableTypes();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  BASIC TYPE ANNOTATIONS — String, int, bool, double
//
//  Type annotations explicitly declare the data type of a variable.
//  Format: <Type> variableName = value;
//
//  Think of it like labeling boxes when moving:
//  A box labeled "Kitchen — Plates" is clearer than an unmarked box.
//
//  Dart CAN infer types using `var`, but explicit types improve readability.
//
// =============================================================================
// =============================================================================

void sample1BasicTypes() {
  print('');
  print('##############################################');
  print('# SAMPLE 1: Basic Type Annotations            #');
  print('##############################################');

  // ============================================================
  // 1. STRING — text/character sequences
  //    Can use single ('') or double ("") quotes — both identical.
  // ============================================================
  print('  === String ===');

  String name = 'Mario';
  print('  Name: $name');

  String greeting = "Hello, World!";
  print('  Greeting: $greeting');
  print('  Length: ${name.length}');
  print('  Uppercase: ${name.toUpperCase()}');

  // ============================================================
  // 2. INT — whole numbers (no decimal points)
  //    Range: -2^63 to 2^63 - 1 on 64-bit systems
  // ============================================================
  print('  === int ===');

  int age = 25;
  print('  Age: $age');

  int score = 1000;
  print('  Score: $score');
  print('  Is age even? ${age.isEven}');

  // ============================================================
  // 3. BOOL — true or false
  //    Used for conditional logic and flags.
  // ============================================================
  print('  === bool ===');

  bool isOpen = true;
  print('  Is open: $isOpen');

  bool isLoggedIn = false;
  print('  Is logged in: $isLoggedIn');

  // ============================================================
  // 4. DOUBLE — floating-point numbers (decimals)
  //    64-bit double-precision.
  // ============================================================
  print('  === double ===');

  double averageRating = 8.75;
  print('  Rating: $averageRating');

  double price = 19.99;
  print('  Price: \$$price');
  print('  Rounded: ${averageRating.round()}');

  // ============================================================
  // 5. NO CHAR TYPE — Single characters are just Strings
  //    Unlike C/C++/Java, Dart has no `char` type.
  // ============================================================
  print('  === No char type ===');

  String bloodType = 'A';
  print('  Blood type: $bloodType (length: ${bloodType.length})');

  // ============================================================
  // 6. VAR — Type inferred by Dart
  //    var name = 'Mario'; → Dart infers String
  //    Once inferred, the type is LOCKED.
  // ============================================================
  print('  === var (inferred types) ===');

  var inferredName = 'Luigi';
  var inferredAge = 30;
  print('  var name: $inferredName (${inferredName.runtimeType})');
  print('  var age: $inferredAge (${inferredAge.runtimeType})');

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  CONST & FINAL WITH TYPE ANNOTATIONS
//
//  When using `const` and `final`, include the type annotation for clarity.
//
//  Format:
//    const <Type> variableName = value;    → compile-time constant
//    final <Type> variableName = value;    → runtime constant
//
//  Think of it like a locked, labeled box:
//    - The label (type) tells you what's inside
//    - The lock (const/final) prevents anyone from changing it
//
// =============================================================================
// =============================================================================

void sample2ConstAndFinal() {
  print('##############################################');
  print('# SAMPLE 2: const & final with Types          #');
  print('##############################################');

  // ============================================================
  // 1. CONST WITH TYPE ANNOTATIONS — Typed compile-time constants
  //    const <Type> name = value;
  // ============================================================
  print('  === const with types ===');

  const int newAge = 27;
  print('  const int: $newAge');

  const String newName = 'Luigi';
  print('  const String: $newName');

  const double pi = 3.14159;
  print('  const double: $pi');

  const bool isActive = true;
  print('  const bool: $isActive');

  // const values MUST be known at compile time
  // const DateTime now = DateTime.now(); // ERROR! Runtime value.

  // ============================================================
  // 2. FINAL WITH TYPE ANNOTATIONS — Typed runtime constants
  //    final <Type> name = value;
  // ============================================================
  print('  === final with types ===');

  final String friendName = 'Princess';
  print('  final String: $friendName');

  final DateTime currentTime = DateTime.now();
  print('  final DateTime: $currentTime');

  final int currentYear = DateTime.now().year;
  print('  final int (year): $currentYear');

  // ============================================================
  // 3. FINAL WITH LATE ASSIGNMENT — Declare type now, assign later
  // ============================================================
  print('  === final with late assignment ===');

  final String heroName;
  heroName = 'Princess';
  print('  Hero: $heroName');
  // heroName = 'Bowser'; // ERROR! Already assigned.

  final int playerScore;
  playerScore = 9999;
  print('  Score: $playerScore');

  // ============================================================
  // 4. CONST vs FINAL vs VAR — Quick comparison
  //
  //    ┌────────────────────────────────────────────────────────┐
  //    │  Keyword │  Reassign? │  When decided? │  Type needed? │
  //    ├──────────┼────────────┼────────────────┼───────────────┤
  //    │  const   │  No        │  Compile time  │  Optional     │
  //    │  final   │  No        │  Runtime       │  Optional     │
  //    │  var     │  Yes       │  Runtime       │  Inferred     │
  //    │  <Type>  │  Yes       │  Runtime       │  Explicit     │
  //    └────────────────────────────────────────────────────────┘
  // ============================================================
  print('  === const vs final vs var ===');

  const String constVal = 'I am const';
  final String finalVal = 'I am final at ${DateTime.now()}';
  String mutableVal = 'I am mutable';

  print('  $constVal');
  print('  $finalVal');
  print('  $mutableVal');

  mutableVal = 'I changed!';
  print('  $mutableVal');

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  3:  NULLABLE vs NON-NULLABLE TYPES (Null Safety)
//
//  Dart has SOUND NULL SAFETY — by default, variables CANNOT be null.
//  To allow null, add '?' after the type.
//
//  Think of it like a reservation at a restaurant:
//    Non-nullable (String):  "You MUST have a reservation"
//    Nullable (String?):     "Reservation optional"
//
// =============================================================================
// =============================================================================

void sample3NullableTypes() {
  print('##############################################');
  print('# SAMPLE 3: Nullable vs Non-Nullable          #');
  print('##############################################');

  // ============================================================
  // 1. NON-NULLABLE (Default) — Variables MUST have a value
  // ============================================================
  print('  === Non-nullable types ===');

  String name = 'Mario';
  int age = 25;
  print('  Name: $name, Age: $age');
  // name = null; // ERROR! Can't assign null to String.

  // ============================================================
  // 2. NULLABLE (Type?) — Variables CAN be null
  //    Nullable variables default to null if not initialized.
  // ============================================================
  print('  === Nullable types ===');

  int? points;
  print('  Points: $points'); // null

  String? nickname;
  print('  Nickname: $nickname'); // null

  points = 100;
  print('  Points (assigned): $points'); // 100

  points = null;
  print('  Points (back to null): $points'); // null

  // ============================================================
  // 3. NULL CHECK — Safely access nullable values
  //    "Type promotion" — inside an if-check, Dart promotes
  //    int? to int, so you can use it safely.
  // ============================================================
  print('  === Null check ===');

  int? playerScore = s3GetScore(50);
  if (playerScore != null) {
    int doubled = playerScore * 2;
    print('  Doubled score: $doubled'); // 100
  }

  int? bonus = s3GetScore(null);
  if (bonus != null) {
    print('  Bonus: $bonus');
  } else {
    print('  No bonus available');
  }

  // ============================================================
  // 4. DEFAULT VALUE WITH ?? — Fallback for null
  //    value ?? default → use value if not null, else use default
  // ============================================================
  print('  === Default value with ?? ===');

  String? userNickname = s3GetNickname(null);
  String displayName = userNickname ?? 'Guest';
  print('  Display (null input): $displayName'); // Guest

  userNickname = s3GetNickname('SuperMario');
  displayName = userNickname ?? 'Guest';
  print('  Display (value input): $displayName'); // SuperMario

  // ??= assigns ONLY if currently null
  String? theme;
  theme ??= 'Light Mode'; // null → assigns
  print('  Theme: $theme'); // Light Mode

  // ============================================================
  // 5. NULL-AWARE ACCESS WITH ?. — Safe property/method access
  //    object?.property → returns null instead of crashing
  // ============================================================
  print('  === Null-aware ?. ===');

  String? city = s3GetNickname('Tokyo');
  print('  City length: ${city?.length}'); // 5
  print('  City upper: ${city?.toUpperCase()}'); // TOKYO

  String? country = s3GetNickname(null);
  print('  Country length: ${country?.length}'); // null
  print('  Country upper: ${country?.toUpperCase()}'); // null

  // Combine ?. with ?? for safe access with a default
  int nameLength = country?.length ?? 0;
  print('  Country name length (default 0): $nameLength'); // 0

  print('');
}

// --- Sample 3: Helper functions ---
// These return nullable types so the analyzer can't determine
// the null state at compile time — making null-safety demos valid.

int? s3GetScore(int? value) => value;

String? s3GetNickname(String? value) => value;

// =============================================================================
// =============================================================================
//  NOTES: Type Annotations — Complete Summary of ALL 3 Samples
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | TOPIC                    | KEY CONCEPTS
//  -----------------------------------------------------------------------
//   1  | Basic type annotations   | String, int, bool, double, no char, var
//   2  | const & final with types | const <Type>, final <Type>, late assign
//   3  | Nullable vs non-nullable | Type?, ??, ?., ??=, null checks
//  -----------------------------------------------------------------------
//
//  TYPE ANNOTATIONS FORMAT:
//  ┌────────────────────────────────────────────────────────────────────┐
//  │  <Type> name = value;          → mutable, typed                   │
//  │  var name = value;             → mutable, type inferred           │
//  │  const <Type> name = value;    → immutable, compile-time          │
//  │  final <Type> name = value;    → immutable, runtime               │
//  │  <Type>? name;                 → nullable (can be null)           │
//  └────────────────────────────────────────────────────────────────────┘
//
//  NULL-SAFETY OPERATORS:
//  ┌──────────────┬──────────────────────────────────────────────┐
//  │  Operator    │  What it does                                │
//  ├──────────────┼──────────────────────────────────────────────┤
//  │  Type?       │  Makes the type nullable                     │
//  │  ??          │  Default value if null                       │
//  │  ?.          │  Safe access (null if object is null)        │
//  │  ??=         │  Assign only if currently null               │
//  │  !           │  Assert non-null (use with caution!)         │
//  └──────────────┴──────────────────────────────────────────────┘
//
//  DECISION FLOW:
//  ┌────────────────────────────────────────────────────────────────────┐
//  │  1. Will it NEVER change?                                         │
//  │     → Known at compile time? → const <Type>                       │
//  │     → Known at runtime?      → final <Type>                       │
//  │  2. Will it change later?    → <Type> or var                      │
//  │  3. Can it be null?          → <Type>?                            │
//  └────────────────────────────────────────────────────────────────────┘
//
// =============================================================================
