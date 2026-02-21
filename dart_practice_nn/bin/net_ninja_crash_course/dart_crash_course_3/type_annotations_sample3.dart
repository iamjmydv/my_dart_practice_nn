//------------------------------------------------------------------------------
// T Y P E  A N N O T A T I O N S
//------------------------------------------------------------------------------
// SAMPLE 3: NULLABLE vs NON-NULLABLE TYPES (Null Safety)
//------------------------------------------------------------------------------
//
// Dart has SOUND NULL SAFETY — by default, variables CANNOT be null.
// This prevents one of the most common bugs in programming:
// the "null reference error" (trying to use something that is null).
//
// To allow null, add a '?' after the type.
//
// Think of it like a reservation at a restaurant:
//   - Non-nullable (String):  "You MUST have a reservation" — always has a value
//   - Nullable (String?):     "Reservation optional" — might have one, might not
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Non-nullable types (default)          | Variables MUST have a value
//  2  | Nullable types (Type?)                | Variables CAN be null
//  3  | Null check before using               | Safely access nullable values
//  4  | Default value with ??                 | Provide fallback for null
//  5  | Null-aware access with ?.             | Safe property access on nullable
// -----------------------------------------------------------------------
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. NON-NULLABLE TYPES (Default) — Variables MUST have a value
  //    By default, every variable in Dart must be initialized
  //    with a non-null value. This prevents null-related crashes.
  //
  //    int score;       // ERROR! Must be initialized.
  //    int score = 0;   // OK! Has a value.
  // ============================================================
  print('=== Non-nullable types (default) ===');

  String name = 'Mario'; // MUST have a value — cannot be null
  int age = 25; // MUST have a value
  bool isActive = true; // MUST have a value
  double rating = 4.5; // MUST have a value

  print('Name: $name');
  print('Age: $age');
  print('Active: $isActive');
  print('Rating: $rating');

  // These would all be ERRORS:
  // String name;        // ERROR! Non-nullable must be initialized.
  // name = null;        // ERROR! Can't assign null to String.
  // int age = null;     // ERROR! Can't assign null to int.

  print('');

  // ============================================================
  // 2. NULLABLE TYPES (Type?) — Variables CAN be null
  //    Adding '?' after the type means: "this can be a value OR null."
  //
  //    int  → must have an int value (never null)
  //    int? → can have an int value OR be null
  //
  //    Nullable variables default to null if not initialized.
  // ============================================================
  print('=== Nullable types (Type?) ===');

  int? points; // Not initialized → defaults to null
  print('Points: $points'); // Points: null

  String? nickname; // Not initialized → defaults to null
  print('Nickname: $nickname'); // Nickname: null

  double? discount; // Not initialized → defaults to null
  print('Discount: $discount'); // Discount: null

  // You CAN assign a value later
  points = 100;
  print('Points (after assignment): $points'); // Points (after assignment): 100

  // You can also set it BACK to null
  points = null;
  print('Points (set to null): $points'); // Points (set to null): null

  // Assigning a value at declaration
  String? middleName = 'James';
  print('Middle name: $middleName'); // Middle name: James

  print('');

  // ============================================================
  // 3. NULL CHECK BEFORE USING — Safely access nullable values
  //    You can't use a nullable value directly where a non-nullable
  //    is expected. You must check for null first.
  //
  //    int? points = null;
  //    int total = points + 10; // ERROR! points could be null.
  //    if (points != null) { total = points + 10; } // OK!
  // ============================================================
  print('=== Null check before using ===');

  // getScore() returns int? — could be a value or null.
  // The analyzer doesn't know which, so we MUST check.
  int? playerScore = getScore(50);

  // Method 1: if-check
  if (playerScore != null) {
    // Inside this block, Dart KNOWS playerScore is not null.
    // This is called "type promotion" — Dart promotes int? to int.
    int doubled = playerScore * 2;
    print('Doubled score: $doubled'); // Doubled score: 100
  }

  // Method 2: check with else for null case
  int? bonus = getScore(null);
  if (bonus != null) {
    print('Bonus: $bonus');
  } else {
    print('No bonus available'); // No bonus available
  }

  print('');

  // ============================================================
  // 4. DEFAULT VALUE WITH ?? — Provide a fallback for null
  //    The ?? operator says: "Use the left value if it's not null,
  //    otherwise use the right value (the default)."
  //
  //    Think of it like: "Give me the value, or if there's nothing,
  //    give me this default instead."
  //
  //    value ?? default
  //      → if value is NOT null → use value
  //      → if value IS null     → use default
  // ============================================================
  print('=== Default value with ?? ===');

  // getNickname(null) returns null, so ?? kicks in
  String? userNickname = getNickname(null);
  String displayName = userNickname ?? 'Guest';
  print('Display name: $displayName'); // Display name: Guest

  // getNickname('SuperMario') returns 'SuperMario', so ?? is skipped
  userNickname = getNickname('SuperMario');
  displayName = userNickname ?? 'Guest';
  print('Display name: $displayName'); // Display name: SuperMario

  // Same pattern with int
  int? savedScore = getScore(null);
  int currentScore = savedScore ?? 0;
  print('Current score: $currentScore'); // Current score: 0

  savedScore = getScore(750);
  currentScore = savedScore ?? 0;
  print('Current score: $currentScore'); // Current score: 750

  // ??= assigns a value ONLY if the variable is currently null
  String? theme;
  print('Theme before ??=: $theme'); // null
  theme ??= 'Light Mode'; // theme is null, so assign 'Light Mode'
  print('Theme after ??=: $theme'); // Light Mode

  print('');

  // ============================================================
  // 5. NULL-AWARE ACCESS WITH ?. — Safe property/method access
  //    The ?. operator says: "If the object is not null, access
  //    its property/method. If it IS null, return null instead
  //    of crashing."
  //
  //    name?.length
  //      → if name is NOT null → returns name.length
  //      → if name IS null     → returns null (no crash!)
  // ============================================================
  print('=== Null-aware access with ?. ===');

  // getNickname returns String? — the analyzer doesn't know if it's null
  String? city = getNickname('Tokyo');
  print('City length: ${city?.length}'); // City length: 5
  print('City uppercase: ${city?.toUpperCase()}'); // City uppercase: TOKYO

  String? country = getNickname(null);
  print('Country length: ${country?.length}'); // Country length: null
  print('Country uppercase: ${country?.toUpperCase()}'); // Country uppercase: null
  // Without ?. this would crash: country.length → ERROR!

  // Combine ?. with ?? for a complete safe access with default
  int nameLength = country?.length ?? 0;
  print('Country name length (with default): $nameLength'); // 0

  print('');
  print('--- Summary ---');
  print('String   → must have a value (non-nullable)');
  print('String?  → can be null (nullable)');
  print('??       → provide a default if null');
  print('?.       → safe access (returns null if object is null)');
  print('??=      → assign only if currently null');
}

// --- Sample 3: Helper functions ---
// These return nullable types so the analyzer can't determine
// the null state at compile time — making null-safety demos valid.

/// Returns the value as-is (could be null or a value).
/// The analyzer sees the return type as int? and can't optimize it away.
int? getScore(int? value) => value;

/// Returns the value as-is (could be null or a value).
/// The analyzer sees the return type as String? and can't optimize it away.
String? getNickname(String? value) => value;

// ============================================================
// NOTES: Nullable vs Non-Nullable Types
// ============================================================
//  1. By default, Dart variables are NON-NULLABLE (must have a value).
//  2. Add ? to make a type nullable: int?, String?, bool?, double?
//  3. Nullable variables default to null if not initialized.
//  4. You must check for null before using nullable values.
//
//  NULL-SAFETY OPERATORS:
//  ┌──────────────┬──────────────────────────────────────────────┐
//  │  Operator    │  What it does                                │
//  ├──────────────┼──────────────────────────────────────────────┤
//  │  Type?       │  Makes the type nullable                     │
//  │  ??          │  Default value if null                       │
//  │  ?.          │  Safe access (returns null if object is null)│
//  │  ??=         │  Assign only if currently null               │
//  │  !           │  Assert non-null (use with caution!)         │
//  └──────────────┴──────────────────────────────────────────────┘
//
//  BEST PRACTICES:
//    - Prefer non-nullable types when possible
//    - Use ? only when null is a valid/meaningful state
//    - Always handle null before using nullable values
//    - Use ?? to provide sensible defaults
//    - Avoid the ! operator unless you're 100% sure it's not null
// ============================================================
