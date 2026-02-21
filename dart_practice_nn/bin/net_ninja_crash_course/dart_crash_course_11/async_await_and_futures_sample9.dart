//------------------------------------------------------------------------------
// F U T U R E - A S Y N C - A W A I T
//------------------------------------------------------------------------------
// SAMPLE 9: .whenComplete() — Cleanup That ALWAYS Runs
//------------------------------------------------------------------------------
//
// .whenComplete() runs a callback when the Future is done,
// WHETHER IT SUCCEEDED OR FAILED. It's like "finally" but for
// .then()/.catchError() chains.
//
// Think of it like washing your hands after cooking:
// Whether the meal turned out great or burned, you still wash up.
//
// Common uses:
//   - Hide a loading spinner
//   - Close a database connection
//   - Reset a "loading" flag
//   - Log that an operation finished
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | .whenComplete() on success            | Runs after a successful future
//  2  | .whenComplete() on failure            | Runs even after an error
//  3  | Full chain: .then + .catchError +     | Complete pattern for real apps
//     |   .whenComplete                       |
//  4  | Compare with try-catch-finally        | Same behavior, different syntax
// -----------------------------------------------------------------------
//
void main() async {
  // ============================================================
  // 1. .whenComplete() ON SUCCESS
  //    The future succeeds → .then() runs → .whenComplete() runs.
  //    .whenComplete() doesn't receive any value or error.
  //    It just knows "the future is done."
  // ============================================================
  print('=== whenComplete on success ===');

  await fetchData()
      .then((data) {
        print('Got data: $data'); // Got data: Hello from server
      })
      .whenComplete(() {
        print('Cleanup: hiding loading spinner...'); // always runs
      });

  print('');

  // ============================================================
  // 2. .whenComplete() ON FAILURE
  //    The future fails → .catchError() runs → .whenComplete()
  //    STILL runs! That's the whole point — it runs no matter what.
  // ============================================================
  print('=== whenComplete on failure ===');

  await fetchBrokenData()
      .then((data) {
        print('Got data: $data'); // WON'T run (future failed)
      })
      .catchError((e) {
        print('Error: $e'); // Error: Server is down!
      })
      .whenComplete(() {
        print('Cleanup: hiding loading spinner...'); // STILL runs!
      });

  print('');

  // ============================================================
  // 3. FULL CHAIN — The complete pattern
  //    .then()         → handle success
  //    .catchError()   → handle failure
  //    .whenComplete() → cleanup (always)
  //
  //    This is the callback-style equivalent of try-catch-finally.
  // ============================================================
  print('=== Full chain pattern ===');

  bool isLoading = true;
  print('Loading: $isLoading'); // Loading: true

  await downloadFile()
      .then((file) {
        print('Downloaded: $file');
      })
      .catchError((e) {
        print('Download failed: $e');
      })
      .whenComplete(() {
        isLoading = false; // always reset the loading flag
        print('Loading: $isLoading'); // Loading: false
        print('(Loading spinner hidden, regardless of success/failure)');
      });

  print('');

  // ============================================================
  // 4. COMPARE WITH try-catch-finally — Same behavior, cleaner look
  //    .then()         = try block
  //    .catchError()   = catch block
  //    .whenComplete() = finally block
  //
  //    Most developers prefer try-catch-finally with async/await
  //    because it reads more naturally.
  // ============================================================
  print('=== Same thing with try-catch-finally ===');

  bool isLoading2 = true;
  print('Loading: $isLoading2');

  try {
    String file = await downloadFile();
    print('Downloaded: $file');
  } catch (e) {
    print('Download failed: $e');
  } finally {
    isLoading2 = false;
    print('Loading: $isLoading2');
    print('(Loading spinner hidden, regardless of success/failure)');
  }
}

// ============================================================
// SIMULATED ASYNC FUNCTIONS
// ============================================================

// Succeeds after 1 second
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Hello from server';
}

// Always fails after 1 second
Future<String> fetchBrokenData() async {
  await Future.delayed(Duration(seconds: 1));
  throw 'Server is down!';
}

// Succeeds after 2 seconds (simulates a file download)
Future<String> downloadFile() async {
  await Future.delayed(Duration(seconds: 2));
  return 'report.pdf (2.5 MB)';
}

// ============================================================
// NOTES: .whenComplete() Summary
// ============================================================
//  1. .whenComplete(() {...})   — runs when the future is done (success OR failure)
//  2. It does NOT receive       — any value or error as a parameter
//  3. It's like "finally"       — for .then()/.catchError() chains
//  4. Common uses:              — hide loading, close connections, reset flags
//
//  COMPARISON TABLE:
//  ┌─────────────────────┬──────────────────────┐
//  │  Callback Style     │  async/await Style   │
//  ├─────────────────────┼──────────────────────┤
//  │  .then()            │  try { ... }         │
//  │  .catchError()      │  catch (e) { ... }   │
//  │  .whenComplete()    │  finally { ... }     │
//  └─────────────────────┴──────────────────────┘
//
//  TIP: Prefer try-catch-finally with async/await.
//  Use .whenComplete() only when you're already using .then() chains.
// ============================================================
