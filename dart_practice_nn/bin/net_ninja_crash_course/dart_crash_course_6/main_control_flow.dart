//------------------------------------------------------------------------------
// C O N T R O L  F L O W  —  C O M P L E T E  G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 5 samples into one runnable file.
// Control flow is how you tell Dart WHICH code to run and HOW MANY TIMES.
// It includes loops, conditionals, error handling, and more.
//
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                        | KEY CONCEPTS                    | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | For Loops                    | for-in, .where(), for(i++)      | Iterate through collections
//  2  | While Loops                  | while, do-while                 | Loop when count is unknown
//  3  | Loop Control                 | break, continue                 | Fine-grained loop control
//  4  | Conditionals & Switch        | if/else, ternary, switch        | Make decisions in code
//  5  | Null Check, Errors & Assert  | null, try/catch, assert         | Safety and error handling
// -----------------------------------------------------------------------
//
// TIP: To run just ONE sample, comment out the others in main().
//      Each sample is independent — they don't depend on each other.
//
// -----------------------------------------------------------------------

void main() {
  // ============================================================
  //  Uncomment/comment any sample to run only what you want.
  //  Each sample is independent — they don't depend on each other.
  // ============================================================

  sample1ForLoops();
  sample2WhileLoops();
  sample3LoopControl();
  sample4ConditionalsAndSwitch();
  sample5NullCheckErrorHandlingAndAssert();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  F O R  L O O P S
//
//  Covers all the ways to use for loops in Dart:
//    - for-in with .where() — filter before looping
//    - if/else inside a loop — categorize while iterating
//    - for-in (forEach style) — simple iteration
//    - Standard for loop — when you need the index
//
//  For loops are the bread-and-butter of iteration.
//  Use for-in when you just need the values.
//  Use standard for when you need the index (position).
//
// =============================================================================
// =============================================================================

void sample1ForLoops() {
  print('');
  print('##############################################');
  print('# SAMPLE 1: For Loops                        #');
  print('##############################################');

  // ============================================================
  // 1. FOR-IN WITH .where() — Filter items before looping
  //    .where() returns only elements that pass the condition.
  // ============================================================
  print('');
  print('  --- for-in with .where() ---');
  List<int> scores = [50, 75, 20, 99, 100, 30];
  print('  All scores: $scores');

  for (int score in scores.where((s) => s > 50)) {
    print('    The score $score is greater than 50!');
  }

  // ============================================================
  // 2. IF / ELSE INSIDE A LOOP — Categorize items
  // ============================================================
  print('');
  print('  --- if/else inside a loop ---');
  List<int> scores2 = [50, 75, 20, 99, 100, 30];

  for (int score in scores2) {
    if (score > 50) {
      print('    $score - Passed!');
    } else {
      print('    $score - Not high enough.');
    }
  }

  // ============================================================
  // 3. FOR-IN LOOP (forEach style) — Loop through every item
  // ============================================================
  print('');
  print('  --- for-in loop (forEach style) ---');
  List<int> scores3 = [50, 75, 20, 99, 100, 30];

  for (int score in scores3) {
    print('    Score: $score');
  }

  // ============================================================
  // 4. STANDARD FOR LOOP WITH INDEX — When position matters
  // ============================================================
  print('');
  print('  --- Standard for loop with index ---');
  List<int> scores4 = [50, 75, 20, 99, 100, 30];

  for (int i = 0; i < scores4.length; i++) {
    print('    Score at index $i is ${scores4[i]}');
  }

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  W H I L E  L O O P S
//
//  Covers while and do-while loops:
//    - while — checks condition FIRST, may run 0 times
//    - do-while — runs body FIRST, always runs at least once
//
//  Use when you don't know how many times to loop.
//  The key difference: while checks THEN runs, do-while runs THEN checks.
//
// =============================================================================
// =============================================================================

void sample2WhileLoops() {
  print('##############################################');
  print('# SAMPLE 2: While Loops                      #');
  print('##############################################');

  // ============================================================
  // 1. WHILE LOOP — Runs as long as the condition is true
  // ============================================================
  print('');
  print('  --- while loop (countdown) ---');
  int countdown = 5;

  while (countdown > 0) {
    print('    Countdown: $countdown');
    countdown--;
  }
  print('    Go!');

  // ============================================================
  // 2. DO-WHILE LOOP — Runs at least once, then checks
  // ============================================================
  print('');
  print('  --- do-while loop (attempts) ---');
  int attempts = 0;

  do {
    attempts++;
    print('    Attempt #$attempts');
  } while (attempts < 3);
  print('    Done after $attempts attempts.');

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  3:  L O O P  C O N T R O L
//
//  Covers break and continue:
//    - break — EXIT the loop entirely (stop searching)
//    - continue — SKIP this iteration, move to the next
//
//  Both work in for, for-in, while, and do-while loops.
//  break stops the loop. continue skips one pass.
//
// =============================================================================
// =============================================================================

void sample3LoopControl() {
  print('##############################################');
  print('# SAMPLE 3: Loop Control (break & continue)  #');
  print('##############################################');

  // ============================================================
  // 1. BREAK — Exit a loop early when a condition is met
  // ============================================================
  print('');
  print('  --- break (search for Charlie) ---');
  List<String> names = ['Alice', 'Bob', 'Charlie', 'Diana'];

  for (String name in names) {
    if (name == 'Charlie') {
      print('    Found Charlie! Stopping search.');
      break;
    }
    print('    Checking $name...');
  }

  // ============================================================
  // 2. CONTINUE — Skip the current iteration
  // ============================================================
  print('');
  print('  --- continue (skip even numbers) ---');
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8];

  for (int num in numbers) {
    if (num % 2 == 0) {
      continue; // skip even numbers
    }
    print('    Odd number: $num');
  }

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  4:  C O N D I T I O N A L S  &  S W I T C H
//
//  Covers all the ways to make decisions in Dart:
//    - if / else if / else — multiple conditions checked top-to-bottom
//    - Ternary operator (? :) — one-line if/else for assignments
//    - switch statement — match a value against multiple cases
//    - switch expression (Dart 3+) — modern concise switch that returns a value
//
//  Rule of thumb:
//    1-2 conditions? → if/else or ternary
//    3+ conditions on the SAME variable? → switch
//
// =============================================================================
// =============================================================================

void sample4ConditionalsAndSwitch() {
  print('##############################################');
  print('# SAMPLE 4: Conditionals & Switch            #');
  print('##############################################');

  // ============================================================
  // 1. IF / ELSE IF / ELSE — Run different code based on conditions
  // ============================================================
  print('');
  print('  --- if / else if / else ---');
  int temperature = s4GetTemperature();

  if (temperature >= 30) {
    print('    It is hot outside! ($temperature degrees)');
  } else if (temperature >= 20) {
    print('    Nice weather! ($temperature degrees)');
  } else if (temperature >= 10) {
    print('    A bit chilly. ($temperature degrees)');
  } else {
    print('    It is cold outside! ($temperature degrees)');
  }

  // ============================================================
  // 2. TERNARY OPERATOR — A one-line if/else
  //    Format: condition ? valueIfTrue : valueIfFalse
  // ============================================================
  print('');
  print('  --- Ternary operator ---');
  int age = s4GetAge();
  String status = age >= 18 ? 'Adult' : 'Minor';
  print('    $age years old -> $status');

  // ============================================================
  // 3. SWITCH STATEMENT — Match a value against multiple cases
  // ============================================================
  print('');
  print('  --- switch statement ---');
  String role = 'admin';

  switch (role) {
    case 'admin':
      print('    Full access granted.');
      break;
    case 'editor':
      print('    Edit access granted.');
      break;
    case 'viewer':
      print('    Read-only access.');
      break;
    default:
      print('    Unknown role.');
  }

  // ============================================================
  // 4. SWITCH EXPRESSION (Dart 3+) — Modern, concise switch
  //    Returns a value directly. No break needed.
  // ============================================================
  print('');
  print('  --- switch expression (Dart 3+) ---');
  String day = 'Monday';

  String type = switch (day) {
    'Monday' || 'Tuesday' || 'Wednesday' || 'Thursday' || 'Friday' => 'Weekday',
    'Saturday' || 'Sunday' => 'Weekend',
    _ => 'Unknown',
  };
  print('    $day is a $type');

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  5:  N U L L  C H E C K ,  E R R O R  H A N D L I N G
//                    &  A S S E R T
//
//  Covers three safety mechanisms:
//    - Null check with if — safely handle nullable values
//    - try / catch / finally — handle errors without crashing
//    - assert — debug-only validation for developers
//
//  These are essential for writing robust code that handles
//  unexpected situations gracefully.
//
// =============================================================================
// =============================================================================

void sample5NullCheckErrorHandlingAndAssert() {
  print('##############################################');
  print('# SAMPLE 5: Null Check, Errors & Assert      #');
  print('##############################################');

  // ============================================================
  // 1. NULL CHECK WITH IF — Safely handle nullable values
  // ============================================================
  print('');
  print('  --- Null check with if ---');
  String? username = s5GetUserName();

  if (username != null) {
    print('    Welcome, $username!');
  } else {
    print('    No user logged in.');
  }

  // Null-aware operator ??
  String displayName = s5GetNickname() ?? 'Guest';
  print('    Display name: $displayName');

  // ============================================================
  // 2. TRY / CATCH / FINALLY — Handle errors without crashing
  // ============================================================
  print('');
  print('  --- try / catch / finally ---');
  try {
    int result = 10 ~/ 0; // integer division by zero
    print('    Result: $result');
  } catch (e) {
    print('    Error: $e');
  } finally {
    print('    This always runs, error or not.');
  }

  // ============================================================
  // 3. ASSERT — Debug-only check (ignored in production)
  //    Crashes with a message if the condition is false.
  // ============================================================
  print('');
  print('  --- assert ---');
  int price = 100;
  assert(price > 0, 'Price must be positive!');
  print('    Price is valid: $price');

  print('');
}

// =============================================================================
//  HELPER FUNCTIONS — Used to avoid lint warnings about dead code
// =============================================================================

// --- Sample 4 helpers ---

/// Returns a temperature value. Try changing to test different branches.
int s4GetTemperature() {
  return 35;
}

/// Returns an age value. Try changing to 15 to see 'Minor' instead.
int s4GetAge() {
  return 20;
}

// --- Sample 5 helpers ---

/// Returns a username or null. Try changing to null to test the else branch.
String? s5GetUserName() {
  return 'JohnAce';
}

/// Returns a nickname or null. Currently returns null to demonstrate
/// how the ?? (if-null) operator provides a default value.
String? s5GetNickname() {
  return null;
}

// =============================================================================
// =============================================================================
//  NOTES: Control Flow — Complete Summary of ALL 5 Samples
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | TOPIC                    | KEY CONCEPTS
//  -----------------------------------------------------------------------
//   1  | For Loops                | for-in, .where(), for(i++), forEach
//   2  | While Loops              | while, do-while
//   3  | Loop Control             | break (exit), continue (skip)
//   4  | Conditionals & Switch    | if/else, ternary, switch statement/expression
//   5  | Null, Errors & Assert    | null check, try/catch/finally, assert
//  -----------------------------------------------------------------------
//
//  ALL CONTROL FLOW CONSTRUCTS COVERED:
//  ┌────────────────────────────┬────────────────────────────────────────────┐
//  │  Construct                 │  What it does                             │
//  ├────────────────────────────┼────────────────────────────────────────────┤
//  │  for-in                    │  Loop through each item (Sample 1)        │
//  │  for-in + .where()         │  Filter then loop (Sample 1)             │
//  │  for (i = 0; ...)          │  Loop with index access (Sample 1)       │
//  │  while                     │  Loop while condition is true (Sample 2)  │
//  │  do-while                  │  Loop at least once (Sample 2)           │
//  │  break                     │  Exit loop early (Sample 3)             │
//  │  continue                  │  Skip iteration (Sample 3)              │
//  │  if / else if / else       │  Conditional branching (Sample 4)       │
//  │  ternary (? :)             │  One-line conditional (Sample 4)        │
//  │  switch statement          │  Multi-case matching (Sample 4)         │
//  │  switch expression         │  Modern switch that returns (Sample 4)  │
//  │  if (x != null)            │  Null safety check (Sample 5)          │
//  │  ?? / ?. / ??=             │  Null-aware operators (Sample 5)        │
//  │  try / catch / finally     │  Error handling (Sample 5)              │
//  │  assert                    │  Debug-only validation (Sample 5)       │
//  └────────────────────────────┴────────────────────────────────────────────┘
//
//  QUICK DECISION RULES:
//  ┌───────────────────────────────────────────────────────────────────────┐
//  │  "Do I know how many times to loop?"                                │
//  │     YES → for loop / for-in                                         │
//  │     NO  → while / do-while                                          │
//  │                                                                     │
//  │  "Do I need to stop early or skip items?"                           │
//  │     STOP → break                                                    │
//  │     SKIP → continue                                                 │
//  │                                                                     │
//  │  "How many conditions am I checking?"                               │
//  │     1-2 → if/else or ternary                                        │
//  │     3+  → switch statement or switch expression                     │
//  │                                                                     │
//  │  "Might this value be null?"                                        │
//  │     YES → if (x != null) or use ?? / ?.                             │
//  │                                                                     │
//  │  "Might this code throw an error?"                                  │
//  │     YES → wrap in try / catch / finally                             │
//  └───────────────────────────────────────────────────────────────────────┘
//
//  This is the control flow toolkit you'll use in every Dart and Flutter app.
// =============================================================================
