//------------------------------------------------------------------------------
// C O N T R O L  F L O W  —  S A M P L E  5:  N U L L  C H E C K ,
//                               E R R O R  H A N D L I N G  &  A S S E R T
//------------------------------------------------------------------------------
//
// This sample covers three important safety mechanisms in Dart:
// null checking, error handling with try/catch/finally, and assert.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                        | KEYWORDS USED          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Null check with if           | if, != null, ?         | Safely handle nullable values
//  2  | try / catch / finally        | try, catch, finally    | Error handling without crashing
//  3  | assert                       | assert                 | Debug-only validation
// -----------------------------------------------------------------------
//
// These constructs are essential for writing ROBUST code that doesn't
// crash when unexpected things happen (null values, errors, bad data).
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. NULL CHECK WITH IF — Safely handle values that might be null
  //    In Dart, a variable marked with ? (e.g., String?) can be null.
  //    Before using a nullable value, you should CHECK if it's null.
  //
  //    Why? If you try to call a method on null, your app CRASHES:
  //      String? name = null;
  //      print(name.length);  // CRASH! "Null check operator used on a null value"
  //
  //    By checking first, you handle both cases gracefully.
  //
  //    Common in real apps:
  //      - API responses (might return null)
  //      - User input (might be empty/null)
  //      - Database lookups (record might not exist)
  // ============================================================
  print('');
  print('##############################################');
  print('# SECTION 1: Null check with if              #');
  print('##############################################');

  // --- Example 1: Basic null check ---
  // s5GetUserName() returns String? — it MIGHT be null.
  // We use a helper function so the analyzer doesn't know
  // the value at compile time (avoiding dead code warnings).
  print('  --- Basic null check ---');
  String? username = s5GetUserName();

  if (username != null) {
    // Inside this block, Dart PROMOTES username to String (non-null).
    // You can safely use .length, .toUpperCase(), etc.
    print('    Welcome, $username!');
    print('    Username length: ${username.length}');
  } else {
    print('    No user logged in.');
  }

  print('');

  // --- Example 2: Null check with a null value ---
  print('  --- Checking a null value ---');
  String? nickname = s5GetNickname();

  if (nickname != null) {
    print('    Nickname: $nickname');
  } else {
    print('    No nickname set. (value is null)');
  }

  print('');

  // --- Example 3: Null-aware operators ---
  print('  --- Null-aware operators ---');

  // ?? (if-null operator): Use a default value if the left side is null.
  String displayName = s5GetNickname() ?? 'Guest';
  print('    Display name: $displayName');
  // Since getNickname() returns null, displayName becomes 'Guest'.

  // ?. (null-aware access): Call a method only if NOT null.
  // If null, the whole expression evaluates to null (no crash).
  String? email = s5GetEmail();
  int? emailLength = email?.length; // null if email is null
  print('    Email: $email');
  print('    Email length: $emailLength');

  // ??= (null-aware assignment): Assign ONLY if the variable is currently null.
  String? city = s5GetCity();
  print('    City before ??=: $city');
  city ??= 'Unknown City'; // only assigns if city is null
  print('    City after ??=: $city');

  print('');

  // ============================================================
  // 2. TRY / CATCH / FINALLY — Handle errors without crashing
  //    When code might fail (divide by zero, invalid input, etc.),
  //    wrap it in try/catch to handle the error gracefully.
  //
  //    Structure:
  //      try {
  //        // code that MIGHT throw an error
  //      } catch (e) {
  //        // what to do if an error occurs
  //      } finally {
  //        // code that ALWAYS runs (error or not)
  //      }
  //
  //    Think of it like a safety net:
  //    The trapeze artist (try) performs. If they fall (error),
  //    the net (catch) saves them. The show goes on (finally).
  // ============================================================
  print('##############################################');
  print('# SECTION 2: try / catch / finally           #');
  print('##############################################');

  // --- Example 1: Catching a division by zero error ---
  print('  --- Division by zero ---');
  try {
    int result = 10 ~/ 0; // ~/ is integer division; dividing by 0 throws!
    print('    Result: $result'); // this line will NOT run
  } catch (e) {
    // "e" contains the error object.
    print('    Error: $e');
    // Output: Error: IntegerDivisionByZeroException
  } finally {
    // This runs NO MATTER WHAT — whether try succeeded or failed.
    print('    This always runs, error or not.');
  }

  print('');

  // --- Example 2: Catching a specific exception type ---
  print('  --- Catching specific exception types ---');
  try {
    // Trying to parse a non-numeric string as int
    int value = int.parse('not_a_number');
    print('    Parsed value: $value'); // won't run
  } on FormatException catch (e) {
    // "on FormatException" catches ONLY FormatException errors.
    // This is more precise than a generic catch.
    print('    FormatException caught: $e');
  } catch (e) {
    // This catches any OTHER type of error (fallback).
    print('    Some other error: $e');
  }

  print('');

  // --- Example 3: try-catch-finally with cleanup ---
  print('  --- Full try-catch-finally pattern ---');
  bool isLoading = true;
  print('    isLoading: $isLoading');

  try {
    print('    Attempting risky operation...');
    // Simulating an operation that might fail
    List<int> numbers = [1, 2, 3];
    print('    Accessing index 10: ${numbers[10]}'); // throws RangeError!
  } catch (e) {
    print('    Caught error: $e');
  } finally {
    // Perfect for cleanup: hide spinners, close connections, reset flags.
    isLoading = false;
    print('    isLoading: $isLoading (reset in finally block)');
  }

  print('');

  // --- Example 4: Re-throwing an error ---
  print('  --- Re-throwing errors ---');
  try {
    s5RiskyOperation();
  } catch (e) {
    print('    Caught re-thrown error: $e');
  }

  print('');

  // --- Example 5: try without catch (only finally) ---
  // You CAN use try-finally without catch. The error still
  // propagates, but finally runs first.
  print('  --- try-finally (no catch) ---');
  try {
    try {
      int badResult = 100 ~/ 0; // throws!
      print('    $badResult'); // won't run
    } finally {
      // This runs even though we don't catch the error.
      print('    Finally ran! (error will propagate up)');
    }
  } catch (e) {
    // The outer catch handles the error that propagated up.
    print('    Outer catch got: $e');
  }

  print('');

  // ============================================================
  // 3. ASSERT — Debug-only check (ignored in production)
  //    assert(condition) crashes with a message if the condition
  //    is FALSE. It's a developer tool for catching bugs early.
  //
  //    IMPORTANT: Asserts are ONLY checked in DEBUG mode.
  //    In production (release) builds, asserts are completely
  //    ignored — they don't exist in the compiled code.
  //
  //    Use for:
  //      - Validating function arguments during development
  //      - Catching impossible states early
  //      - Documenting assumptions in code
  //
  //    To run with asserts enabled:
  //      dart run                    → asserts ARE checked
  //      dart compile exe && ./app   → asserts are IGNORED
  //
  //    NOTE: Don't use assert for user input validation!
  //    Use if/else or throw for that (since asserts vanish
  //    in production). Assert is ONLY for developer mistakes.
  // ============================================================
  print('##############################################');
  print('# SECTION 3: assert — Debug validation       #');
  print('##############################################');

  // --- Example 1: Basic assert ---
  print('  --- Basic assert ---');
  int price = 100;
  assert(price > 0, 'Price must be positive!');
  print('    Price is valid: $price');
  // If price were -5, this would crash (in debug mode) with:
  // "Assertion failed: Price must be positive!"

  // --- Example 2: Assert with a function result ---
  print('  --- Assert with function result ---');
  String name = s5GetUserName() ?? 'Unknown';
  assert(name.isNotEmpty, 'Name must not be empty!');
  print('    Name is valid: $name');

  // --- Example 3: Assert on a list ---
  print('  --- Assert on a list ---');
  List<int> scores = [85, 92, 78];
  assert(scores.isNotEmpty, 'Scores list must not be empty!');
  print('    Scores list has ${scores.length} items.');

  // --- Example 4: Assert vs if/else — when to use which ---
  print('  --- Assert vs if/else ---');
  print('    assert: For catching DEVELOPER mistakes in debug mode.');
  print('    if/else: For handling USER input and runtime conditions.');
  print('    throw:   For signaling errors to calling code.');
  // Example:
  //   assert(age >= 0);           // Developer bug if age is negative
  //   if (age < 18) { ... }       // Valid user scenario to handle
  //   throw ArgumentError('...');  // Signal error to caller

  print('');
}

// --- Sample 5: Helper functions ---
// These functions return nullable types to simulate real-world scenarios
// (like fetching data from an API or database) and to avoid lint warnings
// about dead code when the analyzer can see the value is always non-null.

/// Returns a username or null. Try changing the return value to null
/// to test the else branch of the null check.
String? s5GetUserName() {
  return 'JohnAce';
}

/// Returns a nickname or null. Currently returns null to demonstrate
/// how null checks and null-aware operators work.
String? s5GetNickname() {
  return null;
}

/// Returns an email or null. Try changing to 'john@example.com'
/// to see the null-aware ?. operator in action with a real value.
String? s5GetEmail() {
  return null;
}

/// Returns a city name or null. Used to demonstrate the ??= operator.
String? s5GetCity() {
  return null;
}

/// A function that catches an error internally, then re-throws it.
/// This demonstrates that you can catch an error, do some logging
/// or cleanup, and then pass the error along to the caller.
void s5RiskyOperation() {
  try {
    List<String> items = ['a', 'b'];
    print('    Accessing index 5: ${items[5]}'); // throws RangeError
  } catch (e) {
    print('    (Inside s5RiskyOperation) Caught: $e');
    print('    (Inside s5RiskyOperation) Re-throwing...');
    rethrow; // pass the error to whoever called this function
  }
}

// =============================================================================
// =============================================================================
//  NOTES: Null Check, Error Handling & Assert — Summary
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | CONSTRUCT              | PURPOSE
//  -----------------------------------------------------------------------
//   1  | Null check (if)        | Safely handle values that might be null
//   2  | try / catch / finally  | Handle errors without crashing
//   3  | assert                 | Debug-only validation for developers
//  -----------------------------------------------------------------------
//
//  NULL-AWARE OPERATORS CHEAT SHEET:
//  ┌──────────┬────────────────────────────────────────────────────────────┐
//  │ Operator │  What it does                                             │
//  ├──────────┼────────────────────────────────────────────────────────────┤
//  │  ??      │  Use right side if left is null:  name ?? 'Guest'         │
//  │  ?.      │  Call method only if not null:    email?.length            │
//  │  ??=     │  Assign only if currently null:   city ??= 'Unknown'      │
//  │  !       │  Assert non-null (DANGEROUS):     name!.length            │
//  └──────────┴────────────────────────────────────────────────────────────┘
//
//  TRY-CATCH PATTERNS:
//  ┌───────────────────────────────────────────────────────────────────────┐
//  │  // Pattern 1: Generic catch                                        │
//  │  try { ... } catch (e) { print(e); }                                │
//  │                                                                     │
//  │  // Pattern 2: Specific exception type                              │
//  │  try { ... } on FormatException catch (e) { ... }                   │
//  │                                                                     │
//  │  // Pattern 3: With stack trace                                     │
//  │  try { ... } catch (e, stackTrace) { print(stackTrace); }          │
//  │                                                                     │
//  │  // Pattern 4: Full pattern with cleanup                            │
//  │  try { ... } catch (e) { ... } finally { cleanup(); }              │
//  │                                                                     │
//  │  // Pattern 5: Re-throw to let caller handle it                     │
//  │  try { ... } catch (e) { log(e); rethrow; }                        │
//  └───────────────────────────────────────────────────────────────────────┘
//
//  ASSERT vs IF/ELSE vs THROW — When to use which:
//  ┌────────────────────────────────────┬──────────────────────────────────┐
//  │  Scenario                          │  Use this                        │
//  ├────────────────────────────────────┼──────────────────────────────────┤
//  │  Developer mistake / impossible    │  assert (debug only)             │
//  │  state that should never happen    │                                  │
//  │                                    │                                  │
//  │  User input / runtime condition    │  if/else (handle gracefully)     │
//  │  that is valid but needs handling  │                                  │
//  │                                    │                                  │
//  │  Error that calling code should    │  throw (signal error to caller)  │
//  │  handle                            │                                  │
//  └────────────────────────────────────┴──────────────────────────────────┘
//
// =============================================================================
