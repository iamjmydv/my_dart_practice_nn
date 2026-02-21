//------------------------------------------------------------------------------
// C O N T R O L  F L O W  —  S A M P L E  2:  W H I L E  L O O P S
//------------------------------------------------------------------------------
//
// This sample covers WHILE and DO-WHILE loops in Dart.
// Unlike for loops (which iterate over known collections), while loops
// keep running as long as a CONDITION is true.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                        | KEYWORDS USED     | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | while loop                   | while             | When iteration count is unknown ahead of time
//  2  | do-while loop                | do, while         | Guarantees at least one execution
// -----------------------------------------------------------------------
//
// KEY DIFFERENCE:
//   while  → checks condition FIRST, then runs the body (may run 0 times)
//   do-while → runs the body FIRST, then checks condition (runs at least 1 time)
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. WHILE LOOP — Keeps running as long as the condition is true
  //    The condition is checked BEFORE each iteration.
  //    If the condition is false from the start, the body
  //    NEVER runs (zero iterations).
  //
  //    Structure:
  //      while (condition) {
  //        // body — runs repeatedly
  //      }
  //
  //    WARNING: If you forget to update the variable in the
  //    condition, you'll create an INFINITE LOOP and your
  //    program will hang forever!
  //
  //    Use when:
  //      - You don't know how many times to loop
  //      - You're waiting for something to happen
  //      - Example: reading lines from a file until end-of-file
  //      - Example: retrying a network call until it succeeds
  // ============================================================
  print('');
  print('##############################################');
  print('# SECTION 1: while loop                      #');
  print('##############################################');

  // --- Example 1: Simple countdown ---
  print('  --- Countdown ---');
  int countdown = 5;

  // Before each iteration, Dart checks: is countdown > 0?
  // If YES → run the body. If NO → skip to after the loop.
  while (countdown > 0) {
    print('    Countdown: $countdown');
    countdown--; // decrease by 1 each time (5, 4, 3, 2, 1)
  }
  print('    Go!');
  // After the loop, countdown is 0.

  print('');

  // --- Example 2: While with a condition that starts false ---
  print('  --- Condition starts false (body never runs) ---');
  int x = 0;

  // x > 10 is false from the start, so the body is skipped entirely.
  while (x > 10) {
    print('    This will never print!');
    x++;
  }
  print('    Loop skipped because $x is NOT > 10.');

  print('');

  // --- Example 3: Doubling until a threshold ---
  print('  --- Doubling until we reach 100 ---');
  int value = 1;

  // We don't know how many times we need to double.
  // The while loop keeps going until value reaches or exceeds 100.
  while (value < 100) {
    print('    Value: $value');
    value *= 2; // double it each time (1, 2, 4, 8, 16, 32, 64, 128)
  }
  print('    Final value: $value (exceeded 100, loop stopped)');

  print('');

  // ============================================================
  // 2. DO-WHILE LOOP — Runs the body FIRST, then checks condition
  //    Guarantees the body executes AT LEAST ONCE, even if the
  //    condition is false from the start.
  //
  //    Structure:
  //      do {
  //        // body — runs at least once
  //      } while (condition);  // note the semicolon!
  //
  //    Use when:
  //      - You need the body to run at least once
  //      - Example: showing a menu and asking for input
  //      - Example: generating a random number until you get
  //        one that meets a criteria
  //
  //    KEY DIFFERENCE from while:
  //      while → checks THEN runs (might run 0 times)
  //      do-while → runs THEN checks (always runs at least 1 time)
  // ============================================================
  print('##############################################');
  print('# SECTION 2: do-while loop                   #');
  print('##############################################');

  // --- Example 1: Simple attempt counter ---
  print('  --- Attempt counter ---');
  int attempts = 0;

  // The body runs FIRST, then checks if attempts < 3.
  // So even if attempts started at 3, it would still run once.
  do {
    attempts++;
    print('    Attempt #$attempts');
  } while (attempts < 3);
  print('    Done after $attempts attempts.');

  print('');

  // --- Example 2: Do-while with condition false from the start ---
  print('  --- Condition starts false (body STILL runs once) ---');
  int y = 100;

  // Even though y < 10 is FALSE, the body runs once first.
  // This is the key difference from a regular while loop.
  do {
    print('    y is $y — body ran even though y < 10 is false!');
  } while (y < 10);
  print('    Loop ended after 1 execution.');

  print('');

  // --- Example 3: Simulating a menu loop ---
  // In a real app, you'd read user input. Here we simulate it.
  print('  --- Simulated menu loop ---');
  List<String> simulatedInputs = ['view', 'edit', 'quit'];
  int inputIndex = 0;

  do {
    String choice = simulatedInputs[inputIndex];
    print('    Menu choice: $choice');
    inputIndex++;
  } while (inputIndex < simulatedInputs.length &&
      simulatedInputs[inputIndex - 1] != 'quit');
  print('    User chose to quit.');

  print('');
}

// =============================================================================
// =============================================================================
//  NOTES: While Loops — Summary
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | LOOP TYPE        | CONDITION CHECK    | MINIMUM RUNS
//  -----------------------------------------------------------------------
//   1  | while            | Before each run    | 0 (may never run)
//   2  | do-while         | After each run     | 1 (always runs once)
//  -----------------------------------------------------------------------
//
//  WHEN TO USE WHICH:
//  ┌────────────────────────────────────────┬──────────────────────────────┐
//  │  Scenario                              │  Use this                    │
//  ├────────────────────────────────────────┼──────────────────────────────┤
//  │  Might not need to run at all          │  while                       │
//  │  MUST run at least once                │  do-while                    │
//  │  Know exact number of iterations       │  for loop (Sample 1)         │
//  │  Iterating over a collection           │  for-in loop (Sample 1)      │
//  │  Waiting for a condition to be met     │  while                       │
//  │  Showing a menu / prompt user          │  do-while                    │
//  └────────────────────────────────────────┴──────────────────────────────┘
//
//  COMMON PITFALL — INFINITE LOOPS:
//  ┌──────────────────────────────────────────────────────────────────────┐
//  │  // BAD — infinite loop! countdown never changes.                   │
//  │  int countdown = 5;                                                 │
//  │  while (countdown > 0) {                                            │
//  │    print(countdown);                                                │
//  │    // forgot countdown--;  <-- THIS IS THE BUG                      │
//  │  }                                                                  │
//  │                                                                     │
//  │  // GOOD — countdown decreases each time, eventually reaches 0.    │
//  │  int countdown = 5;                                                 │
//  │  while (countdown > 0) {                                            │
//  │    print(countdown);                                                │
//  │    countdown--;  // <-- this makes the loop end eventually          │
//  │  }                                                                  │
//  └──────────────────────────────────────────────────────────────────────┘
//
//  TIP: Always make sure the condition in a while/do-while loop
//  will eventually become false. Otherwise, your program hangs forever.
//
// =============================================================================
