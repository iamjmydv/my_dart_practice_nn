//------------------------------------------------------------------------------
// C O N T R O L  F L O W  —  S A M P L E  4:  C O N D I T I O N A L S
//                                               &  S W I T C H
//------------------------------------------------------------------------------
//
// This sample covers all the ways to make DECISIONS in Dart:
// if/else, ternary operator, switch statement, and switch expression.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                        | KEYWORDS USED              | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | if / else if / else          | if, else if, else          | Multiple conditions checked top-to-bottom
//  2  | Ternary operator             | ? :                        | One-line if/else for assignments
//  3  | switch statement             | switch, case, default, break | Cleaner than long if/else chains
//  4  | Switch expression (Dart 3+)  | switch, =>, _ , ||         | Modern concise syntax that returns a value
// -----------------------------------------------------------------------
//
// RULE OF THUMB:
//   - 1-2 conditions?     → if/else or ternary
//   - 3+ conditions on    → switch statement or switch expression
//     the SAME variable?
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. IF / ELSE IF / ELSE — Run different code based on conditions
  //    Checks conditions TOP-TO-BOTTOM. The FIRST match wins.
  //    Once a condition is true, its block runs and the rest
  //    are SKIPPED entirely (even if they would also be true).
  //
  //    Structure:
  //      if (condition1) {
  //        // runs if condition1 is true
  //      } else if (condition2) {
  //        // runs if condition1 is false AND condition2 is true
  //      } else {
  //        // runs if ALL conditions above are false
  //      }
  //
  //    Think of it like a waterfall:
  //    Water flows down and takes the FIRST exit it finds.
  // ============================================================
  print('');
  print('##############################################');
  print('# SECTION 1: if / else if / else             #');
  print('##############################################');

  // --- Example 1: Temperature check ---
  print('  --- Temperature check ---');
  int temperature = 35;

  if (temperature >= 30) {
    print('    It is hot outside! ($temperature degrees)');
  } else if (temperature >= 20) {
    print('    Nice weather! ($temperature degrees)');
  } else if (temperature >= 10) {
    print('    A bit chilly. ($temperature degrees)');
  } else {
    print('    It is cold outside! ($temperature degrees)');
  }
  // Only "It is hot outside!" prints.
  // Even though 35 >= 20 is ALSO true, it's skipped because
  // the first condition (>= 30) already matched.

  print('');

  // --- Example 2: Grade calculator ---
  print('  --- Grade calculator ---');
  int score = s4GetStudentScore();

  String grade;
  if (score >= 90) {
    grade = 'A';
  } else if (score >= 80) {
    grade = 'B';
  } else if (score >= 70) {
    grade = 'C';
  } else if (score >= 60) {
    grade = 'D';
  } else {
    grade = 'F';
  }
  print('    Score: $score -> Grade: $grade');

  print('');

  // --- Example 3: Multiple conditions with && and || ---
  print('  --- Multiple conditions with && (AND) and || (OR) ---');
  int age = s4GetUserAge();
  bool hasLicense = s4HasDriverLicense();

  if (age >= 18 && hasLicense) {
    print('    You can drive! (age: $age, license: $hasLicense)');
  } else if (age >= 18 && !hasLicense) {
    print('    Old enough but no license.');
  } else {
    print('    Too young to drive.');
  }

  print('');

  // ============================================================
  // 2. TERNARY OPERATOR — A one-line if/else
  //    Format: condition ? valueIfTrue : valueIfFalse
  //
  //    Perfect for simple assignments where you choose between
  //    two values based on a condition.
  //
  //    AVOID nesting ternaries — they become unreadable fast:
  //      BAD:  a ? b ? c : d : e ? f : g
  //      GOOD: Use if/else for complex logic
  // ============================================================
  print('##############################################');
  print('# SECTION 2: Ternary operator (? :)          #');
  print('##############################################');

  // --- Example 1: Simple status check ---
  print('  --- Adult or Minor ---');
  int userAge = 20;
  String status = userAge >= 18 ? 'Adult' : 'Minor';
  print('    $userAge years old -> $status');

  print('');

  // --- Example 2: Ternary in a print statement ---
  print('  --- Ternary inside print ---');
  int items = 5;
  print('    You have $items ${items == 1 ? 'item' : 'items'} in your cart.');

  print('');

  // --- Example 3: Ternary for choosing a value ---
  print('  --- Choosing a discount ---');
  bool isMember = s4IsPremiumMember();
  double discount = isMember ? 0.20 : 0.05;
  print('    Discount: ${(discount * 100).toInt()}% (member: $isMember)');

  print('');

  // --- Example 4: Ternary vs if/else comparison ---
  print('  --- Same logic, two styles ---');
  int number = 7;

  // Ternary style (one line):
  String parity1 = number % 2 == 0 ? 'even' : 'odd';

  // if/else style (multiple lines):
  String parity2;
  if (number % 2 == 0) {
    parity2 = 'even';
  } else {
    parity2 = 'odd';
  }

  print('    Ternary says: $number is $parity1');
  print('    if/else says: $number is $parity2');
  // Both produce the same result!

  print('');

  // ============================================================
  // 3. SWITCH STATEMENT — Match a value against multiple cases
  //    Cleaner than long if/else chains when comparing ONE
  //    variable against several possible values.
  //
  //    Structure:
  //      switch (variable) {
  //        case 'value1':
  //          // code for value1
  //          break;
  //        case 'value2':
  //          // code for value2
  //          break;
  //        default:
  //          // code if no case matches
  //      }
  //
  //    IMPORTANT: Each case needs a "break" to prevent
  //    "fall-through" (running the next case's code too).
  // ============================================================
  print('##############################################');
  print('# SECTION 3: switch statement                #');
  print('##############################################');

  // --- Example 1: Role-based access ---
  print('  --- Role-based access ---');
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

  print('');

  // --- Example 2: Day of the week ---
  print('  --- Day type ---');
  String day = 'Saturday';

  switch (day) {
    case 'Monday':
    case 'Tuesday':
    case 'Wednesday':
    case 'Thursday':
    case 'Friday':
      // Multiple cases can share the same code block.
      // Empty cases "fall through" to the next non-empty case.
      print('    $day is a Weekday.');
      break;
    case 'Saturday':
    case 'Sunday':
      print('    $day is a Weekend!');
      break;
    default:
      print('    Unknown day: $day');
  }

  print('');

  // --- Example 3: Switch with int ---
  print('  --- HTTP status codes ---');
  int statusCode = 404;

  switch (statusCode) {
    case 200:
      print('    200 - OK');
      break;
    case 301:
      print('    301 - Moved Permanently');
      break;
    case 404:
      print('    404 - Not Found');
      break;
    case 500:
      print('    500 - Internal Server Error');
      break;
    default:
      print('    $statusCode - Unknown status');
  }

  print('');

  // ============================================================
  // 4. SWITCH EXPRESSION (Dart 3+) — Modern, concise syntax
  //    Returns a value directly. No need for break statements.
  //    Uses => (arrow) instead of : and break.
  //    Uses _ as the default/wildcard case.
  //    Uses || to combine multiple values in one case.
  //
  //    Structure:
  //      String result = switch (variable) {
  //        'value1' => 'result1',
  //        'value2' || 'value3' => 'result2or3',
  //        _ => 'defaultResult',
  //      };
  //
  //    ADVANTAGES over switch statement:
  //      - Returns a value (can assign to a variable)
  //      - No break needed
  //      - More concise
  //      - Dart checks that all cases are handled (exhaustive)
  // ============================================================
  print('##############################################');
  print('# SECTION 4: Switch expression (Dart 3+)     #');
  print('##############################################');

  // --- Example 1: Day type (same as above, but shorter) ---
  print('  --- Day type (switch expression) ---');
  String today = 'Monday';

  String type = switch (today) {
    'Monday' || 'Tuesday' || 'Wednesday' || 'Thursday' || 'Friday' => 'Weekday',
    'Saturday' || 'Sunday' => 'Weekend',
    _ => 'Unknown', // _ is the default/wildcard case
  };
  print('    $today is a $type');

  print('');

  // --- Example 2: Grade description ---
  print('  --- Grade description ---');
  String letterGrade = 'B';

  String description = switch (letterGrade) {
    'A' => 'Excellent!',
    'B' => 'Good job!',
    'C' => 'Average.',
    'D' => 'Below average.',
    'F' => 'Failing.',
    _ => 'Invalid grade.',
  };
  print('    Grade $letterGrade: $description');

  print('');

  // --- Example 3: Switch expression with int ---
  print('  --- HTTP status message (switch expression) ---');
  int httpCode = 200;

  String message = switch (httpCode) {
    200 => 'OK',
    301 => 'Moved Permanently',
    404 => 'Not Found',
    500 => 'Internal Server Error',
    _ => 'Unknown status code',
  };
  print('    $httpCode: $message');

  print('');

  // --- Example 4: Switch expression used directly in print ---
  print('  --- Used directly in an expression ---');
  int month = 3;

  print('    Month $month is in ${switch (month) {
    1 || 2 || 3 => 'Q1',
    4 || 5 || 6 => 'Q2',
    7 || 8 || 9 => 'Q3',
    10 || 11 || 12 => 'Q4',
    _ => 'Invalid month',
  }}');

  print('');
}

// --- Sample 4: Helper functions ---
// These helper functions return values to avoid lint warnings about dead code.
// When the analyzer sees a hardcoded value like `int score = 85`, it knows
// which branches can never run and flags them as "dead code."
// Using a function call makes the value opaque to the analyzer.

/// Returns a student's score. Try changing the return value to test
/// different branches of the grade calculator (e.g., 55, 72, 91).
int s4GetStudentScore() {
  return 85;
}

/// Returns the user's age. Try changing to 15 to see "Too young to drive."
int s4GetUserAge() {
  return 25;
}

/// Returns whether the user has a driver license.
/// Try changing to false to see "Old enough but no license."
bool s4HasDriverLicense() {
  return true;
}

/// Returns whether the user is a premium member.
/// Try changing to false to see the 5% discount instead of 20%.
bool s4IsPremiumMember() {
  return true;
}

// =============================================================================
// =============================================================================
//  NOTES: Conditionals & Switch — Summary
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | CONSTRUCT              | BEST FOR
//  -----------------------------------------------------------------------
//   1  | if / else if / else    | Complex conditions, multiple variables
//   2  | Ternary (? :)          | Simple one-line assignments
//   3  | switch statement       | Matching ONE variable against many values
//   4  | Switch expression      | Same as switch statement, but returns a value
//  -----------------------------------------------------------------------
//
//  CHOOSING THE RIGHT CONSTRUCT:
//  ┌────────────────────────────────────────┬──────────────────────────────┐
//  │  Scenario                              │  Use this                    │
//  ├────────────────────────────────────────┼──────────────────────────────┤
//  │  Simple true/false check               │  if/else                     │
//  │  One-line value assignment             │  ternary (? :)               │
//  │  Comparing ranges (>, <, >=)           │  if/else if/else             │
//  │  Matching exact values (==)            │  switch statement            │
//  │  Matching & returning a value          │  switch expression (Dart 3+) │
//  │  Multiple conditions on DIFFERENT vars │  if/else (with && / ||)      │
//  └────────────────────────────────────────┴──────────────────────────────┘
//
//  SWITCH STATEMENT vs SWITCH EXPRESSION (Dart 3+):
//  ┌────────────────────────────┬───────────────────────────────────────────┐
//  │  Switch Statement          │  Switch Expression (Dart 3+)             │
//  ├────────────────────────────┼───────────────────────────────────────────┤
//  │  switch (x) {              │  var result = switch (x) {               │
//  │    case 'a':               │    'a' => 'Alpha',                       │
//  │      print('Alpha');       │    'b' => 'Bravo',                       │
//  │      break;                │    _ => 'Unknown',                       │
//  │    case 'b':               │  };                                      │
//  │      print('Bravo');       │                                          │
//  │      break;                │  Pros: concise, returns a value,         │
//  │    default:                │  no break needed, exhaustiveness check   │
//  │      print('Unknown');     │                                          │
//  │  }                         │                                          │
//  └────────────────────────────┴───────────────────────────────────────────┘
//
//  TERNARY OPERATOR TIPS:
//  ┌───────────────────────────────────────────────────────────────────────┐
//  │  GOOD:  String s = age >= 18 ? 'Adult' : 'Minor';                   │
//  │  BAD:   String s = a ? b ? c : d : e;  // too nested, use if/else   │
//  │                                                                     │
//  │  Rule: If you can't read it in 2 seconds, use if/else instead.      │
//  └───────────────────────────────────────────────────────────────────────┘
//
// =============================================================================
