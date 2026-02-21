//------------------------------------------------------------------------------
// F U T U R E - A S Y N C - A W A I T
//------------------------------------------------------------------------------
// SAMPLE 6: INSTANT FUTURES — Future.value() AND Future.error()
//------------------------------------------------------------------------------
//
// Not all Futures take time. Sometimes you already KNOW the answer
// and just need to wrap it in a Future (because the function
// signature requires it).
//
// Future.value()  → creates a Future that completes INSTANTLY with a value
// Future.error()  → creates a Future that completes INSTANTLY with an error
//
// Think of it like:
// - Future.value() = "Here's your answer right now, no waiting."
// - Future.error() = "Something already went wrong, no need to wait."
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Future.value() — instant success      | Return a value wrapped as a Future
//  2  | Future.error() — instant failure      | Return an error wrapped as a Future
//  3  | Using them in functions               | Useful for caching or validation
//  4  | Future.value() vs regular return      | Understand when each is needed
// -----------------------------------------------------------------------
//
void main() async {
  // ============================================================
  // 1. Future.value() — Create an instant Future with a value
  //    The Future completes immediately (no delay, no waiting).
  //    Useful when a function must return a Future but you
  //    already have the answer.
  // ============================================================
  print('=== Future.value() ===');

  Future<String> instantName = Future.value('Alice');

  // You can still use .then() or await on it
  instantName.then((name) {
    print('Name from Future.value: $name'); // Alice
  });

  // Or use await
  String name = await Future.value('Bob');
  print('Name from await: $name'); // Bob

  print('');

  // ============================================================
  // 2. Future.error() — Create an instant Future with an error
  //    The Future completes immediately but with an error.
  //    Useful when you detect a problem BEFORE doing any work.
  //    Example: invalid input, missing data, etc.
  // ============================================================
  print('=== Future.error() ===');

  // Must handle the error, otherwise it crashes!
  try {
    String result = await Future.error('Something went wrong!');
    print(result); // this line never runs
  } catch (e) {
    print('Caught instant error: $e'); // Caught instant error: Something went wrong!
  }

  // Using .catchError() style
  Future.error('Oops!')
      .then((value) => print(value))
      .catchError((e) => print('catchError got: $e'));
  // catchError got: Oops!

  await Future.delayed(Duration(milliseconds: 100)); // let callbacks finish
  print('');

  // ============================================================
  // 3. USING THEM IN FUNCTIONS — Real-world example
  //    Imagine a function that fetches user data from a cache
  //    or from the server. If it's in the cache, return instantly
  //    with Future.value(). If invalid input, fail instantly
  //    with Future.error(). Otherwise, fetch from server.
  // ============================================================
  print('=== Practical use in functions ===');

  // Case 1: cached data (instant, no server call)
  try {
    String data1 = await getUserData(1);
    print('User 1: $data1'); // User 1: Alice (cached)
  } catch (e) {
    print('Error: $e');
  }

  // Case 2: invalid ID (instant error, no server call)
  try {
    String data2 = await getUserData(-5);
    print('User -5: $data2'); // won't run
  } catch (e) {
    print('Error for ID -5: $e'); // Error for ID -5: Invalid user ID: -5
  }

  // Case 3: not cached, fetches from "server" (takes time)
  try {
    String data3 = await getUserData(99);
    print('User 99: $data3'); // User 99: User #99 (from server)
  } catch (e) {
    print('Error: $e');
  }

  print('');

  // ============================================================
  // 4. Future.value() vs REGULAR RETURN in async functions
  //    In an async function, "return value" automatically wraps
  //    the value in a Future. So you DON'T need Future.value()
  //    inside async functions. But in NON-async functions that
  //    return Future<T>, you DO need Future.value().
  // ============================================================
  print('=== Future.value() vs return ===');

  // These two do the SAME thing:
  String a = await withFutureValue(); // non-async, uses Future.value()
  String b = await withAsyncReturn(); // async, uses regular return

  print('Future.value result: $a'); // Hello from Future.value
  print('async return result: $b'); // Hello from async return
}

// ============================================================
// FUNCTION USING Future.value(), Future.error(), AND REAL ASYNC
// ============================================================

// Simulates a cache + server lookup
// - If userId is in cache → return instantly (Future.value)
// - If userId is invalid  → fail instantly (Future.error)
// - Otherwise             → fetch from "server" (real async)
Future<String> getUserData(int userId) {
  // Check for invalid ID first (no need to do any work)
  if (userId < 0) {
    return Future.error('Invalid user ID: $userId');
  }

  // Check the "cache" (pretend userId 1 is cached)
  if (userId == 1) {
    return Future.value('Alice (cached)');
  }

  // Not cached — go to the "server" (takes 2 seconds)
  return Future.delayed(Duration(seconds: 2), () {
    return 'User #$userId (from server)';
  });
}

// NON-async function that returns a Future — needs Future.value()
Future<String> withFutureValue() {
  return Future.value('Hello from Future.value');
}

// ASYNC function — regular return is automatically wrapped in a Future
Future<String> withAsyncReturn() async {
  return 'Hello from async return';
}

// ============================================================
// NOTES: Instant Futures Summary
// ============================================================
//  1. Future.value(x)    — instant Future that completes with value x
//  2. Future.error(e)    — instant Future that completes with error e
//  3. Use Future.value() — in NON-async functions that return Future<T>
//  4. Use Future.error() — to fail fast when input is invalid
//  5. In async functions — just use "return x" (auto-wrapped in a Future)
//
//  WHEN TO USE:
//  - Future.value(): cached results, default values, mock data for testing
//  - Future.error(): input validation, early failure, mock errors for testing
//  - Both are great for writing functions that SOMETIMES need async
//    and sometimes don't (like cache-first strategies)
// ============================================================
