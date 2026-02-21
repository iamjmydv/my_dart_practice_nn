//------------------------------------------------------------------------------
// F U T U R E - A S Y N C - A W A I T
//------------------------------------------------------------------------------
// SAMPLE 3: ERROR HANDLING WITH try-catch IN ASYNC FUNCTIONS
//------------------------------------------------------------------------------
//
// When an async function fails (throws an error), we need to catch it.
// Just like you'd catch a dropped ball — if you don't, the app crashes.
//
// There are TWO ways to handle errors with Futures:
//   1. .then() + .catchError()  → callback style (like sample 1)
//   2. try-catch-finally        → cleaner style with async/await (this sample)
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                        | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Async function that throws an error | Simulates a failed network call
//  2  | try-catch to handle the error       | Prevents the app from crashing
//  3  | finally block runs no matter what   | Cleanup code (hide loading, close DB)
//  4  | .catchError() alternative           | Callback-style error handling
// -----------------------------------------------------------------------
//
void main() async {
  // ============================================================
  // 1. CALLING AN ASYNC FUNCTION THAT WILL FAIL
  //    fetchUser() will throw an error after 2 seconds.
  //    Without try-catch, this would crash the entire app.
  // ============================================================

  // ============================================================
  // 2. TRY-CATCH — Wrap the await call in try-catch
  //    - "try" block: put the code that MIGHT fail here
  //    - "catch" block: runs ONLY if an error is thrown
  //    - The error object (e) contains the error message
  // ============================================================
  try {
    print('Fetching user...');
    User user = await fetchUser(); // this will throw an error
    print('User: ${user.name}'); // this line will NOT run
  } catch (e) {
    // This runs because fetchUser() threw an error
    print('Error caught: $e'); // Error caught: User not found!
  }

  print('---');

  // ============================================================
  // 3. TRY-CATCH-FINALLY — "finally" always runs
  //    Whether the try succeeds or fails, "finally" runs.
  //    Perfect for: hiding a loading spinner, closing a
  //    database connection, or resetting a flag.
  // ============================================================
  try {
    print('Fetching user again...');
    User user = await fetchUser();
    print('User: ${user.name}');
  } catch (e) {
    print('Error caught: $e');
  } finally {
    // This runs NO MATTER WHAT — success or failure
    print('Done fetching (finally block ran).');
  }

  print('---');

  // ============================================================
  // 4. .catchError() — Callback-style error handling
  //    Instead of try-catch, you can chain .catchError() after
  //    .then(). This is the older style, but still works.
  //    Think of it as: "do this, but if it fails, do that."
  // ============================================================
  fetchUser()
      .then((user) {
        print('User: ${user.name}'); // won't run (error happens)
      })
      .catchError((e) {
        print('catchError caught: $e'); // catchError caught: User not found!
      });

  // Give the .then()/.catchError() time to complete
  await Future.delayed(Duration(seconds: 3));
}

// ============================================================
// ASYNC FUNCTION THAT THROWS AN ERROR
// This simulates a failed API call (e.g., no internet, user
// doesn't exist, server is down, etc.)
//
// Future.delayed() waits 2 seconds, then throws an error
// instead of returning a value.
// ============================================================
Future<User> fetchUser() async {
  await Future.delayed(Duration(seconds: 2));
  // Simulate a failure — throw instead of return
  throw 'User not found!';
  // If it succeeded, you would do: return User('Alice', 25);
}

// Simple class to represent a User
class User {
  String name;
  int age;

  User(this.name, this.age);
}

// ============================================================
// NOTES: Error Handling Summary
// ============================================================
//  1. try-catch         — wrap await calls to catch errors safely
//  2. catch (e)         — "e" holds the error message or object
//  3. finally           — always runs (success or failure), good for cleanup
//  4. .catchError()     — callback-style alternative to try-catch
//  5. throw             — manually trigger an error in your async function
//
//  RULE OF THUMB:
//  - Use try-catch with async/await (cleaner, easier to read)
//  - Use .catchError() with .then() chains (callback style)
//  - Always handle errors in real apps — unhandled errors crash the app!
// ============================================================
