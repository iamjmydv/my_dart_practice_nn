//------------------------------------------------------------------------------
// C O N T R O L  F L O W  —  S A M P L E  3:  L O O P  C O N T R O L
//------------------------------------------------------------------------------
//
// This sample covers BREAK and CONTINUE — two keywords that give you
// fine-grained control over loop execution.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                        | KEYWORDS USED     | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | break                        | break             | Exit a loop early (e.g., stop searching)
//  2  | continue                     | continue          | Skip certain iterations without stopping
// -----------------------------------------------------------------------
//
// KEY DIFFERENCE:
//   break    → STOP the loop entirely, move to code after the loop
//   continue → SKIP this iteration, jump to the NEXT iteration
//
// Both work in: for, for-in, while, and do-while loops.
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. BREAK — Exit a loop early when a condition is met
  //    When Dart hits "break", it immediately EXITS the loop
  //    and continues running the code AFTER the loop.
  //
  //    Use when:
  //      - Searching for something — stop when found
  //      - Processing until a limit is reached
  //      - Validating data — stop on first error
  //
  //    Think of it like looking for your keys:
  //    You check your pockets one by one. The moment you
  //    FIND the keys, you STOP checking. That's break.
  // ============================================================
  print('');
  print('##############################################');
  print('# SECTION 1: break — Exit loop early         #');
  print('##############################################');

  // --- Example 1: Search for an item in a list ---
  print('  --- Searching for Charlie ---');
  List<String> names = ['Alice', 'Bob', 'Charlie', 'Diana'];

  for (String name in names) {
    if (name == 'Charlie') {
      print('    Found Charlie! Stopping search.');
      break; // exits the loop immediately — Diana is never checked
    }
    print('    Checking $name...');
  }
  // Output:
  //   Checking Alice...
  //   Checking Bob...
  //   Found Charlie! Stopping search.
  // Note: Diana is never printed because break stops the loop.

  print('');

  // --- Example 2: Break in a while loop ---
  print('  --- Break in a while loop ---');
  int count = 0;

  while (true) {
    // "while (true)" would run forever without break!
    count++;
    print('    Iteration $count');
    if (count >= 3) {
      print('    Reached 3 — breaking out!');
      break; // without this, the loop runs forever
    }
  }

  print('');

  // --- Example 3: Break with a standard for loop ---
  print('  --- Find first even number ---');
  List<int> numbers = [7, 3, 11, 4, 9, 2, 8];

  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] % 2 == 0) {
      print('    First even number: ${numbers[i]} at index $i');
      break; // stop at the FIRST even number (4 at index 3)
    }
    print('    ${numbers[i]} is odd, keep looking...');
  }

  print('');

  // --- Example 4: Break only exits the INNERMOST loop ---
  print('  --- Break in nested loops (only exits inner loop) ---');
  for (int i = 1; i <= 3; i++) {
    print('    Outer loop i=$i');
    for (int j = 1; j <= 3; j++) {
      if (j == 2) {
        print('      Breaking inner loop at j=$j');
        break; // only exits the INNER loop — outer loop continues
      }
      print('      Inner loop j=$j');
    }
  }
  // The outer loop runs all 3 times.
  // The inner loop breaks at j=2 each time.

  print('');

  // ============================================================
  // 2. CONTINUE — Skip the current iteration, move to the next
  //    When Dart hits "continue", it SKIPS the rest of the
  //    current iteration and jumps to the NEXT one.
  //    The loop does NOT stop — it just skips that one pass.
  //
  //    Use when:
  //      - Ignoring certain items (skip even numbers, etc.)
  //      - Filtering out invalid data in a loop
  //      - Avoiding deeply nested if/else inside loops
  //
  //    Think of it like reviewing job applications:
  //    If an application is incomplete, you skip it and move
  //    to the next one. You don't stop reviewing entirely.
  // ============================================================
  print('##############################################');
  print('# SECTION 2: continue — Skip iteration       #');
  print('##############################################');

  // --- Example 1: Skip even numbers, print only odd ---
  print('  --- Print only odd numbers ---');
  List<int> nums = [1, 2, 3, 4, 5, 6, 7, 8];

  for (int num in nums) {
    if (num % 2 == 0) {
      continue; // skip even numbers — jump to next iteration
    }
    // This print only runs for odd numbers (1, 3, 5, 7)
    print('    Odd number: $num');
  }

  print('');

  // --- Example 2: Continue in a standard for loop ---
  print('  --- Skip index 2 and 4 ---');
  List<String> fruits = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];

  for (int i = 0; i < fruits.length; i++) {
    if (i == 2 || i == 4) {
      print('    Skipping index $i (${fruits[i]})');
      continue; // skip Cherry and Elderberry
    }
    print('    Processing: ${fruits[i]}');
  }

  print('');

  // --- Example 3: Continue in a while loop ---
  print('  --- Skip multiples of 3 (while loop) ---');
  int n = 0;

  while (n < 10) {
    n++;
    if (n % 3 == 0) {
      continue; // skip 3, 6, 9
    }
    print('    n = $n');
  }
  // Prints: 1, 2, 4, 5, 7, 8, 10

  print('');

  // --- Example 4: Using continue to avoid deep nesting ---
  print('  --- Continue to flatten logic (avoid deep nesting) ---');
  List<String> emails = ['alice@mail.com', '', 'bob@mail.com', '   ', 'charlie@mail.com'];

  // WITHOUT continue — deeply nested:
  // for (String email in emails) {
  //   if (email.trim().isNotEmpty) {
  //     if (email.contains('@')) {
  //       print('Valid: $email');
  //     }
  //   }
  // }

  // WITH continue — flat and clean:
  print('    Validating emails:');
  for (String email in emails) {
    if (email.trim().isEmpty) {
      continue; // skip empty or whitespace-only emails
    }
    if (!email.contains('@')) {
      continue; // skip emails without @
    }
    print('      Valid: $email');
  }

  print('');
}

// =============================================================================
// =============================================================================
//  NOTES: Loop Control — Summary
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | KEYWORD      | WHAT IT DOES                    | LOOP CONTINUES?
//  -----------------------------------------------------------------------
//   1  | break        | Exits the loop entirely         | NO — loop is done
//   2  | continue     | Skips to the next iteration     | YES — loop keeps going
//  -----------------------------------------------------------------------
//
//  VISUAL COMPARISON:
//  ┌───────────────────────────────────────────────────────────────────────┐
//  │  for (var item in list) {                                            │
//  │    if (condition) break;     // ← EXITS the loop entirely           │
//  │    if (condition) continue;  // ← SKIPS to next item                │
//  │    print(item);              // ← only runs if no break/continue    │
//  │  }                                                                  │
//  └───────────────────────────────────────────────────────────────────────┘
//
//  NESTED LOOPS — IMPORTANT!
//  ┌───────────────────────────────────────────────────────────────────────┐
//  │  break and continue only affect the INNERMOST loop.                  │
//  │                                                                     │
//  │  for (outer) {           // break here? Use labeled breaks:         │
//  │    for (inner) {         //                                          │
//  │      break;              // ← only exits INNER loop                 │
//  │    }                                                                │
//  │  }                                                                  │
//  │                                                                     │
//  │  // Labeled break (exits outer loop):                               │
//  │  outerLoop:                                                         │
//  │  for (outer) {                                                      │
//  │    for (inner) {                                                    │
//  │      break outerLoop;    // ← exits OUTER loop                     │
//  │    }                                                                │
//  │  }                                                                  │
//  └───────────────────────────────────────────────────────────────────────┘
//
//  WHEN TO USE WHICH:
//  ┌────────────────────────────────────────┬──────────────────────────────┐
//  │  Scenario                              │  Use this                    │
//  ├────────────────────────────────────────┼──────────────────────────────┤
//  │  Found what you're looking for         │  break                       │
//  │  Hit an error, stop processing         │  break                       │
//  │  Reached a limit                       │  break                       │
//  │  Skip invalid/unwanted items           │  continue                    │
//  │  Filter inside a loop                  │  continue                    │
//  │  Avoid deeply nested if/else           │  continue (early return)     │
//  └────────────────────────────────────────┴──────────────────────────────┘
//
// =============================================================================
