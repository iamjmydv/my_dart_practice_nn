//------------------------------------------------------------------------------
// F U T U R E S ,  A S Y N C  &  A W A I T  —  C O M P L E T E  G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 10 samples into one runnable file.
// Futures in Dart are like Promises in JavaScript —
// they represent a value that will be available LATER (after some work is done).
// A Future can be in an UNCOMPLETED or COMPLETED state.
//
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                    | KEY CONCEPTS                              | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Future with .then()     | Future.delayed, .then() callback          | Callback style — the original way to handle Futures
//  2  | async/await basics      | async, await keywords                     | Cleaner syntax — reads like normal code
//  3  | Error handling          | try-catch-finally, .catchError(), throw   | Prevent crashes when async calls fail
//  4  | Multiple Futures        | Future.wait(), parallel, Stopwatch        | Run independent tasks at the same time (faster!)
//  5  | Chaining Futures        | .then().then() chains, transformation     | Step-by-step dependent async operations
//  6  | Instant Futures         | Future.value(), Future.error(), caching   | Return a value instantly wrapped as a Future
//  7  | Sequential vs Parallel  | When to use which, mixed pattern          | Choose the right approach for maximum speed
//  8  | Racing & Time Limits    | Future.any(), .timeout(), onTimeout       | Use the fastest source, set time limits
//  9  | Cleanup                 | .whenComplete(), try-catch-finally        | Code that ALWAYS runs (success or failure)
// 10  | Real-world pattern      | Combines ALL concepts                     | How async code looks in production apps
// -----------------------------------------------------------------------
//
// TIP: This file takes a while to run (because of all the delays).
//      To run just ONE sample, comment out the others in main().
//
// -----------------------------------------------------------------------

void main() async {
  // ============================================================
  //  Uncomment/comment any sample to run only what you want.
  //  Each sample is independent — they don't depend on each other.
  // ============================================================

  await sample1FutureWithThen();
  await sample2AsyncAwaitBasics();
  await sample3ErrorHandling();
  await sample4MultipleFutures();
  await sample5ChainingFutures();
  await sample6InstantFutures();
  await sample7SequentialVsParallel();
  await sample8RacingAndTimeouts();
  await sample9WhenComplete();
  await sample10RealWorldPattern();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  FUTURE WITH .then() — Callback Style
//
//  Futures are like promises in JavaScript.
//  .then() says: "When the Future finishes, DO THIS with the result."
//
//  Flow: Start Future → wait → Future completes → .then() runs
//
//  Think of ordering food online:
//  You place the order (Future starts) → food is being made (waiting) →
//  food arrives (.then() runs with the food).
//
// =============================================================================
// =============================================================================

Future<void> sample1FutureWithThen() async {
  print('');
  print('##############################################');
  print('# SAMPLE 1: Future with .then()              #');
  print('##############################################');

  // fetchPost() returns a Future<Post> that takes 3 seconds.
  // .then() receives the Post object once the Future completes.
  // Nothing after .then() waits for it — it runs in the background.
  s1FetchPost().then((p) {
    print('  Title: ${p.title}');
    print('  UserId: ${p.userId}');
  });

  // Wait for the .then() callback to finish before moving to sample 2
  await Future.delayed(Duration(seconds: 4));
  print('');
}

// --- Sample 1: Helper functions ---

// RUNS 3 seconds before passing the value to .then()
// Future.delayed() creates a Future that completes after a delay.
// Think of it as: "Wait 3 seconds, then give back this Post."
Future<S1Post> s1FetchPost() {
  final delay = Duration(seconds: 3);
  return Future.delayed(delay, () {
    return S1Post("My Post", 123);
  });
}

// Acts as Model/DTO — a simple class to hold the data
class S1Post {
  String title;
  int userId;

  S1Post(this.title, this.userId);
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  ASYNC / AWAIT — Cleaner Syntax
//
//  Instead of .then(), you can use "await" to PAUSE and wait for
//  the Future to complete. The function must be marked "async".
//
//  .then() style:  fetchPost().then((p) { print(p.title); });
//  async/await:    var p = await fetchPost(); print(p.title);
//
//  Both do the SAME thing — async/await just reads cleaner.
//  Think of it like: "Wait here until the food arrives, then eat."
//
// =============================================================================
// =============================================================================

Future<void> sample2AsyncAwaitBasics() async {
  print('##############################################');
  print('# SAMPLE 2: async/await basics               #');
  print('##############################################');

  // "await" pauses HERE until fetchPost() finishes (3 seconds).
  // The result goes directly into the variable — no callbacks needed.
  final post = await s2FetchPost();
  print('  Title: ${post.title}');
  print('  UserId: ${post.userId}');
  print('');
}

// --- Sample 2: Helper functions ---

// Same function as sample 1, but now we call it with await instead of .then()
Future<S2Post> s2FetchPost() {
  final delay = Duration(seconds: 3);
  return Future.delayed(delay, () {
    return S2Post("My Post", 123);
  });
}

class S2Post {
  String title;
  int userId;

  S2Post(this.title, this.userId);
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  3:  ERROR HANDLING — try-catch-finally & .catchError()
//
//  When an async function fails (throws an error), we need to catch it.
//  Just like you'd catch a dropped ball — if you don't, the app crashes.
//
//  There are TWO ways to handle errors with Futures:
//    1. .then() + .catchError()  → callback style (like sample 1)
//    2. try-catch-finally        → cleaner style with async/await
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
// =============================================================================
// =============================================================================

Future<void> sample3ErrorHandling() async {
  print('##############################################');
  print('# SAMPLE 3: Error handling                    #');
  print('##############################################');

  // ============================================================
  // 1. TRY-CATCH — Wrap the await call in try-catch
  //    - "try" block: put the code that MIGHT fail here
  //    - "catch" block: runs ONLY if an error is thrown
  //    - The error object (e) contains the error message
  // ============================================================
  try {
    print('  Fetching user...');
    S3User user = await s3FetchUser(); // this will throw an error
    print('  User: ${user.name}'); // this line will NOT run
  } catch (e) {
    // This runs because fetchUser() threw an error
    print('  Error caught: $e'); // Error caught: User not found!
  }

  print('  ---');

  // ============================================================
  // 2. TRY-CATCH-FINALLY — "finally" always runs
  //    Whether the try succeeds or fails, "finally" runs.
  //    Perfect for: hiding a loading spinner, closing a
  //    database connection, or resetting a flag.
  // ============================================================
  try {
    print('  Fetching user again...');
    S3User user = await s3FetchUser();
    print('  User: ${user.name}');
  } catch (e) {
    print('  Error caught: $e');
  } finally {
    // This runs NO MATTER WHAT — success or failure
    print('  Done fetching (finally block ran).');
  }

  print('  ---');

  // ============================================================
  // 3. .catchError() — Callback-style error handling
  //    Instead of try-catch, you can chain .catchError() after
  //    .then(). This is the older style, but still works.
  //    Think of it as: "do this, but if it fails, do that."
  // ============================================================
  s3FetchUser()
      .then((user) {
        print('  User: ${user.name}'); // won't run (error happens)
      })
      .catchError((e) {
        print('  catchError caught: $e'); // catchError caught: User not found!
      });

  // Give the .then()/.catchError() time to complete
  await Future.delayed(Duration(seconds: 3));
  print('');
}

// --- Sample 3: Helper functions ---

// Simulates a failed API call — always throws an error after 2 seconds
Future<S3User> s3FetchUser() async {
  await Future.delayed(Duration(seconds: 2));
  throw 'User not found!';
  // If it succeeded, you would do: return S3User('Alice', 25);
}

class S3User {
  String name;
  int age;

  S3User(this.name, this.age);
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  4:  MULTIPLE FUTURES WITH Future.wait()
//
//  Sometimes you need to fetch MULTIPLE things at the same time.
//  Example: Load a user's profile, their posts, AND their settings
//  all at once — instead of waiting for each one, one by one.
//
//  Future.wait() runs multiple futures IN PARALLEL (at the same time)
//  and waits for ALL of them to finish before moving on.
//  Think of it like: "Go get milk, bread, and eggs at the same time."
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                        | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Run 3 futures one by one (slow)     | Shows how sequential is slower
//  2  | Run 3 futures with Future.wait()    | All run at the same time (faster!)
//  3  | Access individual results           | Each result is in the returned list
//  4  | Future.wait() with error handling   | If ANY future fails, catch the error
// -----------------------------------------------------------------------
//
// =============================================================================
// =============================================================================

Future<void> sample4MultipleFutures() async {
  print('##############################################');
  print('# SAMPLE 4: Multiple Futures (Future.wait)    #');
  print('##############################################');

  // ============================================================
  // 1. SEQUENTIAL — One after another (SLOW)
  //    Each await waits for the previous one to finish.
  //    Total time: 2 + 3 + 1 = 6 seconds
  // ============================================================
  print('  === Sequential (one by one) ===');
  Stopwatch stopwatch = Stopwatch()..start();

  String user = await s4FetchUserName(); // waits 2 seconds
  String post = await s4FetchLatestPost(); // waits 3 seconds
  String setting = await s4FetchSettings(); // waits 1 second

  stopwatch.stop();
  print('  User: $user');
  print('  Post: $post');
  print('  Setting: $setting');
  print('  Sequential took: ${stopwatch.elapsed.inSeconds} seconds');
  // Sequential took: ~6 seconds (2 + 3 + 1)

  print('');

  // ============================================================
  // 2. PARALLEL WITH Future.wait() — All at the same time (FAST)
  //    Future.wait() takes a LIST of futures and runs them all
  //    at the same time. It returns a List of results when ALL
  //    futures are done.
  //    Total time: max(2, 3, 1) = 3 seconds (the slowest one)
  // ============================================================
  print('  === Parallel (all at once) ===');
  stopwatch = Stopwatch()..start();

  List<String> results = await Future.wait([
    s4FetchUserName(), // starts immediately
    s4FetchLatestPost(), // starts immediately
    s4FetchSettings(), // starts immediately
  ]);

  stopwatch.stop();
  print('  User: ${results[0]}');
  print('  Post: ${results[1]}');
  print('  Setting: ${results[2]}');
  print('  Parallel took: ${stopwatch.elapsed.inSeconds} seconds');
  // Parallel took: ~3 seconds (only as slow as the slowest future)

  print('');

  // ============================================================
  // 3. ACCESSING INDIVIDUAL RESULTS — Each result is in the list
  //    The results list has the SAME ORDER as the futures list.
  //    results[0] = fetchUserName result
  //    results[1] = fetchLatestPost result
  //    results[2] = fetchSettings result
  // ============================================================
  print('  === Accessing results individually ===');
  String userName = results[0];
  String latestPost = results[1];
  String userSettings = results[2];

  print('  Welcome back, $userName!');
  print('  Your latest post: "$latestPost"');
  print('  Theme: $userSettings');

  print('');

  // ============================================================
  // 4. Future.wait() WITH ERROR HANDLING
  //    If ANY of the futures throws an error, Future.wait()
  //    throws that error. Use try-catch to handle it.
  //    Think of it like: if ONE errand fails, the whole trip fails.
  // ============================================================
  print('  === Future.wait() with error ===');
  try {
    List<String> badResults = await Future.wait([
      s4FetchUserName(), // succeeds
      s4FetchBrokenData(), // FAILS — throws an error
      s4FetchSettings(), // succeeds
    ]);
    print('  $badResults'); // This line won't run
  } catch (e) {
    print('  One of the futures failed: $e');
    // One of the futures failed: Server error: data not available
  }

  print('');
}

// --- Sample 4: Helper functions ---

Future<String> s4FetchUserName() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Alice';
}

Future<String> s4FetchLatestPost() async {
  await Future.delayed(Duration(seconds: 3));
  return 'Learning Dart Futures!';
}

Future<String> s4FetchSettings() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dark Mode';
}

Future<String> s4FetchBrokenData() async {
  await Future.delayed(Duration(seconds: 1));
  throw 'Server error: data not available';
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  5:  CHAINING FUTURES WITH .then()
//
//  Sometimes you need to do async tasks ONE AFTER ANOTHER where
//  each step depends on the result of the previous step.
//  Example: First log in → then get profile → then get posts
//
//  You can chain .then() calls like links in a chain.
//  Each .then() receives the result of the previous future.
//  Like a relay race — one runner passes the baton to the next.
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Chain .then() calls                   | Step-by-step async operations
//  2  | Same thing with async/await           | Cleaner, easier-to-read version
//  3  | Chaining with data transformation     | Transform data at each step
// -----------------------------------------------------------------------
//
// =============================================================================
// =============================================================================

Future<void> sample5ChainingFutures() async {
  print('##############################################');
  print('# SAMPLE 5: Chaining Futures (.then chains)   #');
  print('##############################################');

  // ============================================================
  // 1. CHAINING .then() — Each step depends on the previous one
  //    Step 1: Log in and get a userId
  //    Step 2: Use that userId to fetch the user's profile
  //    Step 3: Use that profile to get a greeting message
  //
  //    Each .then() passes its result to the NEXT .then().
  // ============================================================
  print('  === Chaining with .then() ===');

  s5Login('alice', 'password123')
      .then((userId) {
        print('  Step 1 — Logged in. userId: $userId');
        return s5GetProfile(userId); // pass userId to next step
      })
      .then((profile) {
        print('  Step 2 — Got profile: $profile');
        return s5CreateGreeting(profile); // pass profile to next step
      })
      .then((greeting) {
        print('  Step 3 — $greeting');
      })
      .catchError((e) {
        print('  Something went wrong: $e');
      });

  // Wait for the chain above to finish
  await Future.delayed(Duration(seconds: 7));
  print('');

  // ============================================================
  // 2. SAME THING WITH async/await — Much cleaner to read
  //    Instead of nesting .then() callbacks, you just use
  //    await on each line. The code reads top-to-bottom,
  //    just like normal synchronous code.
  // ============================================================
  print('  === Same thing with async/await ===');

  try {
    int userId = await s5Login('bob', 'secret456');
    print('  Step 1 — Logged in. userId: $userId');

    String profile = await s5GetProfile(userId);
    print('  Step 2 — Got profile: $profile');

    String greeting = await s5CreateGreeting(profile);
    print('  Step 3 — $greeting');
  } catch (e) {
    print('  Something went wrong: $e');
  }

  print('');

  // ============================================================
  // 3. CHAINING WITH DATA TRANSFORMATION
  //    You can transform data at each step of the chain.
  //    Here we: fetch a number → double it → format it as text.
  //    Each .then() takes the previous result and returns
  //    something new for the next .then().
  // ============================================================
  print('  === Chaining with transformation ===');

  s5FetchNumber()
      .then((number) {
        print('  Original number: $number');
        return number * 2; // transform: double the number
      })
      .then((doubled) {
        print('  Doubled: $doubled');
        return 'The final answer is $doubled'; // transform: to String
      })
      .then((message) {
        print('  $message'); // The final answer is 84
      });

  await Future.delayed(Duration(seconds: 2));
  print('');
}

// --- Sample 5: Helper functions ---

Future<int> s5Login(String username, String password) async {
  await Future.delayed(Duration(seconds: 2));
  print('  (server: logging in $username...)');
  return 42; // fake userId
}

Future<String> s5GetProfile(int userId) async {
  await Future.delayed(Duration(seconds: 2));
  print('  (server: fetching profile for user $userId...)');
  return 'Alice (ID: $userId)';
}

Future<String> s5CreateGreeting(String profile) async {
  await Future.delayed(Duration(seconds: 1));
  return 'Welcome back, $profile!';
}

Future<int> s5FetchNumber() async {
  await Future.delayed(Duration(seconds: 1));
  return 42;
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  6:  INSTANT FUTURES — Future.value() & Future.error()
//
//  Not all Futures take time. Sometimes you already KNOW the answer
//  and just need to wrap it in a Future (because the function
//  signature requires it).
//
//  Future.value()  → creates a Future that completes INSTANTLY with a value
//  Future.error()  → creates a Future that completes INSTANTLY with an error
//
//  Think of it like:
//  - Future.value() = "Here's your answer right now, no waiting."
//  - Future.error() = "Something already went wrong, no need to wait."
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
// =============================================================================
// =============================================================================

Future<void> sample6InstantFutures() async {
  print('##############################################');
  print('# SAMPLE 6: Instant Futures                   #');
  print('##############################################');

  // ============================================================
  // 1. Future.value() — Create an instant Future with a value
  //    The Future completes immediately (no delay, no waiting).
  //    Useful when a function must return a Future but you
  //    already have the answer.
  // ============================================================
  print('  === Future.value() ===');

  Future<String> instantName = Future.value('Alice');

  // You can still use .then() or await on it
  instantName.then((name) {
    print('  Name from Future.value: $name'); // Alice
  });

  // Or use await
  String name = await Future.value('Bob');
  print('  Name from await: $name'); // Bob

  print('');

  // ============================================================
  // 2. Future.error() — Create an instant Future with an error
  //    The Future completes immediately but with an error.
  //    Useful when you detect a problem BEFORE doing any work.
  //    Example: invalid input, missing data, etc.
  // ============================================================
  print('  === Future.error() ===');

  // Must handle the error, otherwise it crashes!
  try {
    String result = await Future.error('Something went wrong!');
    print('  $result'); // this line never runs
  } catch (e) {
    print('  Caught instant error: $e');
  }

  // Using .catchError() style
  Future.error('Oops!')
      .then((value) => print('  $value'))
      .catchError((e) => print('  catchError got: $e'));

  await Future.delayed(Duration(milliseconds: 100)); // let callbacks finish
  print('');

  // ============================================================
  // 3. USING THEM IN FUNCTIONS — Real-world example
  //    Imagine a function that fetches user data from a cache
  //    or from the server. If it's in the cache, return instantly
  //    with Future.value(). If invalid input, fail instantly
  //    with Future.error(). Otherwise, fetch from server.
  // ============================================================
  print('  === Practical use in functions ===');

  // Case 1: cached data (instant, no server call)
  try {
    String data1 = await s6GetUserData(1);
    print('  User 1: $data1'); // User 1: Alice (cached)
  } catch (e) {
    print('  Error: $e');
  }

  // Case 2: invalid ID (instant error, no server call)
  try {
    String data2 = await s6GetUserData(-5);
    print('  User -5: $data2'); // won't run
  } catch (e) {
    print('  Error for ID -5: $e');
  }

  // Case 3: not cached, fetches from "server" (takes time)
  try {
    String data3 = await s6GetUserData(99);
    print('  User 99: $data3'); // User 99: User #99 (from server)
  } catch (e) {
    print('  Error: $e');
  }

  print('');

  // ============================================================
  // 4. Future.value() vs REGULAR RETURN in async functions
  //    In an async function, "return value" automatically wraps
  //    the value in a Future. So you DON'T need Future.value()
  //    inside async functions. But in NON-async functions that
  //    return Future<T>, you DO need Future.value().
  // ============================================================
  print('  === Future.value() vs return ===');

  String a = await s6WithFutureValue(); // non-async, uses Future.value()
  String b = await s6WithAsyncReturn(); // async, uses regular return

  print('  Future.value result: $a');
  print('  async return result: $b');
  print('');
}

// --- Sample 6: Helper functions ---

// Simulates a cache + server lookup
Future<String> s6GetUserData(int userId) {
  if (userId < 0) {
    return Future.error('Invalid user ID: $userId');
  }
  if (userId == 1) {
    return Future.value('Alice (cached)');
  }
  return Future.delayed(Duration(seconds: 2), () {
    return 'User #$userId (from server)';
  });
}

// NON-async function — needs Future.value() to return a Future
Future<String> s6WithFutureValue() {
  return Future.value('Hello from Future.value');
}

// ASYNC function — regular return is automatically wrapped in a Future
Future<String> s6WithAsyncReturn() async {
  return 'Hello from async return';
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  7:  SEQUENTIAL vs PARALLEL — When to use which
//
//  SEQUENTIAL: Run one at a time. Use when step 2 NEEDS step 1's result.
//    Example: Login first → then fetch that user's data
//
//  PARALLEL: Run all at once. Use when tasks are INDEPENDENT.
//    Example: Fetch weather + news + stocks at the same time
//
//  Choosing the right approach can make your app 2-3x faster!
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Sequential — dependent tasks          | When results depend on each other
//  2  | Parallel — independent tasks          | When tasks can run at the same time
//  3  | Mixed — some depend, some don't       | Real-world apps use BOTH together
// -----------------------------------------------------------------------
//
// =============================================================================
// =============================================================================

Future<void> sample7SequentialVsParallel() async {
  print('##############################################');
  print('# SAMPLE 7: Sequential vs Parallel            #');
  print('##############################################');

  // ============================================================
  // 1. SEQUENTIAL — Tasks that DEPEND on each other
  //    You MUST wait for each step before starting the next.
  //    Here: you can't fetch orders without the userId,
  //    and you can't calculate the total without the orders.
  //
  //    Total time: 1 + 2 + 1 = 4 seconds
  // ============================================================
  print('  === Sequential (dependent tasks) ===');
  Stopwatch sw = Stopwatch()..start();

  int userId = await s7Authenticate('alice', 'pass123');
  print('  1. Got userId: $userId');

  List<String> orders = await s7FetchOrders(userId);
  print('  2. Got orders: $orders');

  double total = await s7CalculateTotal(orders);
  print('  3. Total: \$$total');

  sw.stop();
  print('  Sequential time: ${sw.elapsed.inSeconds}s (expected ~4s)');
  print('');

  // ============================================================
  // 2. PARALLEL — Tasks that are INDEPENDENT
  //    These three tasks don't need each other's results.
  //    Run them ALL at the same time with Future.wait().
  //
  //    Total time: max(2, 3, 1) = 3 seconds (the slowest one)
  // ============================================================
  print('  === Parallel (independent tasks) ===');
  sw = Stopwatch()..start();

  var results = await Future.wait([
    s7FetchWeather(), // 2 seconds
    s7FetchNews(), // 3 seconds
    s7FetchStockPrice(), // 1 second
  ]);

  print('  Weather: ${results[0]}');
  print('  News: ${results[1]}');
  print('  Stock: ${results[2]}');

  sw.stop();
  print('  Parallel time: ${sw.elapsed.inSeconds}s (expected ~3s)');
  print('');

  // ============================================================
  // 3. MIXED — Real-world scenario with BOTH patterns
  //    Some tasks depend on each other, some don't.
  //
  //    Step 1: Login (must be first)                    → 1 second
  //    Step 2: Fetch profile AND notifications together → 2 seconds (parallel)
  //    Step 3: Build dashboard from both results        → 1 second
  //
  //    Total: 1 + 2 + 1 = 4 seconds
  //    (If all sequential: 1 + 2 + 2 + 1 = 6 seconds!)
  // ============================================================
  print('  === Mixed (sequential + parallel) ===');
  sw = Stopwatch()..start();

  String token = await s7LoginUser('bob');
  print('  1. Logged in with token: $token');

  var dashboardData = await Future.wait([
    s7FetchProfile(token), // 2 seconds
    s7FetchNotifications(token), // 2 seconds
  ]);
  String profile = dashboardData[0];
  String notifications = dashboardData[1];
  print('  2. Profile: $profile');
  print('  2. Notifications: $notifications');

  String dashboard = await s7BuildDashboard(profile, notifications);
  print('  3. $dashboard');

  sw.stop();
  print('  Mixed time: ${sw.elapsed.inSeconds}s (saved ~2s vs all sequential!)');
  print('');
}

// --- Sample 7: Helper functions ---

Future<int> s7Authenticate(String user, String pass) async {
  await Future.delayed(Duration(seconds: 1));
  return 42;
}

Future<List<String>> s7FetchOrders(int userId) async {
  await Future.delayed(Duration(seconds: 2));
  return ['Order-A', 'Order-B', 'Order-C'];
}

Future<double> s7CalculateTotal(List<String> orders) async {
  await Future.delayed(Duration(seconds: 1));
  return 149.99;
}

Future<String> s7FetchWeather() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Sunny, 25°C';
}

Future<String> s7FetchNews() async {
  await Future.delayed(Duration(seconds: 3));
  return 'Dart 3.0 Released!';
}

Future<String> s7FetchStockPrice() async {
  await Future.delayed(Duration(seconds: 1));
  return '\$150.25';
}

Future<String> s7LoginUser(String username) async {
  await Future.delayed(Duration(seconds: 1));
  return 'token_abc123';
}

Future<String> s7FetchProfile(String token) async {
  await Future.delayed(Duration(seconds: 2));
  return 'Bob (Premium User)';
}

Future<String> s7FetchNotifications(String token) async {
  await Future.delayed(Duration(seconds: 2));
  return '3 new messages';
}

Future<String> s7BuildDashboard(String profile, String notifications) async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dashboard: $profile | $notifications';
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  8:  RACING & TIME LIMITS — Future.any() & .timeout()
//
//  Future.any()   → starts multiple futures, returns the FIRST one to finish
//                   Think: "Race! Whoever finishes first wins."
//
//  .timeout()     → sets a time limit on a future. If it takes too long,
//                   throw a TimeoutException instead of waiting forever.
//                   Think: "You have 3 seconds. If not done, I give up."
//
//  Both are useful for making apps RESPONSIVE and avoiding long waits.
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Future.any() — first to finish wins   | Pick the fastest data source
//  2  | .timeout() — set a time limit         | Don't wait forever for slow servers
//  3  | .timeout() with onTimeout callback    | Provide a fallback value on timeout
// -----------------------------------------------------------------------
//
// =============================================================================
// =============================================================================

Future<void> sample8RacingAndTimeouts() async {
  print('##############################################');
  print('# SAMPLE 8: Racing & Time Limits              #');
  print('##############################################');

  // ============================================================
  // 1. Future.any() — First one to complete wins
  //    Starts ALL futures at the same time, but only returns
  //    the result of whichever finishes FIRST.
  //    The rest are still running but their results are ignored.
  //
  //    Use case: Try multiple servers, use whichever responds first.
  // ============================================================
  print('  === Future.any() — Race! ===');

  String fastest = await Future.any([
    s8FetchFromServerA(), // 3 seconds
    s8FetchFromServerB(), // 1 second  ← this wins!
    s8FetchFromServerC(), // 2 seconds
  ]);

  print('  Winner: $fastest');
  // Server A and C results are ignored

  print('');

  // ============================================================
  // 2. .timeout() — Set a time limit on a Future
  //    If the future doesn't complete within the given Duration,
  //    it throws a TimeoutException.
  //    Use try-catch to handle the timeout gracefully.
  //
  //    Use case: Don't let a slow API freeze your whole app.
  // ============================================================
  print('  === .timeout() — Time limit ===');

  // This future takes 5 seconds, but we only give it 2 seconds
  try {
    String result = await s8SlowServer().timeout(Duration(seconds: 2));
    print('  Got result: $result'); // won't run (times out first)
  } catch (e) {
    print('  Timed out! Error: $e');
  }

  print('');

  // This future takes 1 second, and we give it 3 seconds — plenty of time
  try {
    String result = await s8FastServer().timeout(Duration(seconds: 3));
    print('  Got result: $result'); // Got result: Fast response!
  } catch (e) {
    print('  Timed out! Error: $e');
  }

  print('');

  // ============================================================
  // 3. .timeout() WITH onTimeout CALLBACK — Provide a fallback
  //    Instead of throwing an error on timeout, you can provide
  //    a default value using the onTimeout parameter.
  //    Think: "If the server is slow, just use this default."
  // ============================================================
  print('  === .timeout() with fallback ===');

  String weather = await s8FetchWeatherSlow()
      .timeout(
        Duration(seconds: 2),
        onTimeout: () => 'Weather data unavailable (using default)',
      );

  print('  Weather: $weather');
  // Weather: Weather data unavailable (using default)

  print('');

  // With enough time, it returns the real data
  String weather2 = await s8FetchWeatherFast()
      .timeout(
        Duration(seconds: 3),
        onTimeout: () => 'Weather data unavailable (using default)',
      );

  print('  Weather2: $weather2');
  // Weather2: Sunny, 28°C (real data, finished before timeout)
  print('');
}

// --- Sample 8: Helper functions ---

Future<String> s8FetchFromServerA() async {
  await Future.delayed(Duration(seconds: 3));
  return 'Data from Server A (slow)';
}

Future<String> s8FetchFromServerB() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Data from Server B (fastest!)';
}

Future<String> s8FetchFromServerC() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data from Server C (medium)';
}

Future<String> s8SlowServer() async {
  await Future.delayed(Duration(seconds: 5));
  return 'Slow response (took 5 seconds)';
}

Future<String> s8FastServer() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Fast response!';
}

Future<String> s8FetchWeatherSlow() async {
  await Future.delayed(Duration(seconds: 5));
  return 'Sunny, 28°C';
}

Future<String> s8FetchWeatherFast() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Sunny, 28°C';
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  9:  .whenComplete() — Cleanup That ALWAYS Runs
//
//  .whenComplete() runs a callback when the Future is done,
//  WHETHER IT SUCCEEDED OR FAILED. It's like "finally" but for
//  .then()/.catchError() chains.
//
//  Think of it like washing your hands after cooking:
//  Whether the meal turned out great or burned, you still wash up.
//
//  Common uses:
//    - Hide a loading spinner
//    - Close a database connection
//    - Reset a "loading" flag
//    - Log that an operation finished
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
// =============================================================================
// =============================================================================

Future<void> sample9WhenComplete() async {
  print('##############################################');
  print('# SAMPLE 9: .whenComplete() — Cleanup         #');
  print('##############################################');

  // ============================================================
  // 1. .whenComplete() ON SUCCESS
  //    The future succeeds → .then() runs → .whenComplete() runs.
  //    .whenComplete() doesn't receive any value or error.
  //    It just knows "the future is done."
  // ============================================================
  print('  === whenComplete on success ===');

  await s9FetchData()
      .then((data) {
        print('  Got data: $data');
      })
      .whenComplete(() {
        print('  Cleanup: hiding loading spinner...');
      });

  print('');

  // ============================================================
  // 2. .whenComplete() ON FAILURE
  //    The future fails → .catchError() runs → .whenComplete()
  //    STILL runs! That's the whole point — it runs no matter what.
  // ============================================================
  print('  === whenComplete on failure ===');

  await s9FetchBrokenData()
      .then((data) {
        print('  Got data: $data'); // WON'T run
      })
      .catchError((e) {
        print('  Error: $e');
      })
      .whenComplete(() {
        print('  Cleanup: hiding loading spinner...'); // STILL runs!
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
  print('  === Full chain pattern ===');

  bool isLoading = true;
  print('  Loading: $isLoading');

  await s9DownloadFile()
      .then((file) {
        print('  Downloaded: $file');
      })
      .catchError((e) {
        print('  Download failed: $e');
      })
      .whenComplete(() {
        isLoading = false;
        print('  Loading: $isLoading');
        print('  (Loading spinner hidden, regardless of success/failure)');
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
  print('  === Same thing with try-catch-finally ===');

  bool isLoading2 = true;
  print('  Loading: $isLoading2');

  try {
    String file = await s9DownloadFile();
    print('  Downloaded: $file');
  } catch (e) {
    print('  Download failed: $e');
  } finally {
    isLoading2 = false;
    print('  Loading: $isLoading2');
    print('  (Loading spinner hidden, regardless of success/failure)');
  }

  print('');
}

// --- Sample 9: Helper functions ---

Future<String> s9FetchData() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Hello from server';
}

Future<String> s9FetchBrokenData() async {
  await Future.delayed(Duration(seconds: 1));
  throw 'Server is down!';
}

Future<String> s9DownloadFile() async {
  await Future.delayed(Duration(seconds: 2));
  return 'report.pdf (2.5 MB)';
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  10:  REAL-WORLD PATTERN — Async Data Pipeline
//
//  This sample puts EVERYTHING together in a realistic scenario.
//  It simulates a mini app that:
//    1. Logs in a user
//    2. Fetches their profile + orders in parallel
//    3. Processes the orders
//    4. Displays a summary
//    5. Handles errors and cleanup properly
//
//  This uses: async/await, Future.wait(), try-catch-finally,
//  error handling, and sequential + parallel patterns.
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | CONCEPTS USED
// -----------------------------------------------------------------------
//  1  | Login (sequential — must be first)    | async/await, try-catch
//  2  | Fetch profile + orders (parallel)     | Future.wait()
//  3  | Process orders (sequential)           | await, data transformation
//  4  | Display summary                       | String formatting
//  5  | Full flow with error handling         | try-catch-finally, cleanup
// -----------------------------------------------------------------------
//
// =============================================================================
// =============================================================================

Future<void> sample10RealWorldPattern() async {
  print('##############################################');
  print('# SAMPLE 10: Real-World Pattern               #');
  print('##############################################');
  print('');
  print('  ========================================');
  print('    MINI ORDER DASHBOARD');
  print('  ========================================');
  print('');

  bool isLoading = true;

  try {
    // --- Step 1: Login (SEQUENTIAL — need the token first) ---
    print('  [1/4] Logging in...');
    String token = await s10LoginToServer('john_doe', 'mypassword');
    print('        Logged in! Token: $token');
    print('');

    // --- Step 2: Fetch profile AND orders (PARALLEL — independent!) ---
    print('  [2/4] Fetching profile and orders...');
    var results = await Future.wait([
      s10FetchUserProfile(token),
      s10FetchUserOrders(token),
    ]);

    S10UserProfile profile = results[0] as S10UserProfile;
    List<S10Order> orders = results[1] as List<S10Order>;

    print('        Profile: ${profile.name} (${profile.email})');
    print('        Orders found: ${orders.length}');
    print('');

    // --- Step 3: Process orders (SEQUENTIAL — calculate totals) ---
    print('  [3/4] Processing orders...');
    double grandTotal = 0;
    for (var order in orders) {
      print('        - ${order.item}: \$${order.price.toStringAsFixed(2)}');
      grandTotal += order.price;
    }
    print('');

    // --- Step 4: Display summary ---
    print('  [4/4] Dashboard Summary');
    print('        ┌──────────────────────────────┐');
    print('        │  Welcome, ${profile.name}!');
    print('        │  Email: ${profile.email}');
    print('        │  Member since: ${profile.memberSince}');
    print('        │  Orders: ${orders.length}');
    print('        │  Grand Total: \$${grandTotal.toStringAsFixed(2)}');
    print('        └──────────────────────────────┘');
  } catch (e) {
    print('');
    print('  ERROR: $e');
    print('  Please try again later.');
  } finally {
    isLoading = false;
    print('');
    print('  (Loading complete. isLoading = $isLoading)');
    print('  ========================================');
  }

  print('');

  // ============================================================
  // BONUS: What happens when something fails?
  // ============================================================
  print('  --- Simulating a failed login ---');

  try {
    print('  [1/4] Logging in with bad credentials...');
    String token = await s10LoginToServer('hacker', 'wrongpassword');
    print('        Token: $token');
  } catch (e) {
    print('        Login failed: $e');
  } finally {
    print('        (Cleanup done)');
  }

  print('');
}

// --- Sample 10: Data classes ---

class S10UserProfile {
  String name;
  String email;
  String memberSince;

  S10UserProfile(this.name, this.email, this.memberSince);
}

class S10Order {
  String item;
  double price;
  String date;

  S10Order(this.item, this.price, this.date);
}

// --- Sample 10: Helper functions ---

Future<String> s10LoginToServer(String username, String password) async {
  await Future.delayed(Duration(seconds: 1));
  if (username == 'hacker' || password == 'wrongpassword') {
    throw 'Invalid credentials for user "$username"';
  }
  return 'tok_${username}_2024';
}

Future<S10UserProfile> s10FetchUserProfile(String token) async {
  await Future.delayed(Duration(seconds: 2));
  return S10UserProfile('John Doe', 'john@example.com', 'January 2023');
}

Future<List<S10Order>> s10FetchUserOrders(String token) async {
  await Future.delayed(Duration(seconds: 2));
  return [
    S10Order('Dart Programming Book', 39.99, '2024-01-15'),
    S10Order('Mechanical Keyboard', 129.99, '2024-02-20'),
    S10Order('USB-C Hub', 24.99, '2024-03-05'),
    S10Order('Monitor Stand', 45.00, '2024-03-18'),
  ];
}

// =============================================================================
// =============================================================================
//  NOTES: Async, Await & Futures — Complete Summary of ALL 10 Samples
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | TOPIC                    | KEY CONCEPTS
//  -----------------------------------------------------------------------
//   1  | Future with .then()     | Future.delayed, .then() callback
//   2  | async/await basics      | async, await keywords
//   3  | Error handling          | try-catch-finally, .catchError(), throw
//   4  | Multiple Futures        | Future.wait(), parallel execution, Stopwatch
//   5  | Chaining Futures        | .then().then() chains, data transformation
//   6  | Instant Futures         | Future.value(), Future.error(), caching pattern
//   7  | Sequential vs Parallel  | When to use which, mixed pattern
//   8  | Racing & Time Limits    | Future.any(), .timeout(), onTimeout fallback
//   9  | Cleanup                 | .whenComplete(), comparison with try-catch-finally
//  10  | Real-world pattern      | Combines ALL concepts into a mini dashboard app
//  -----------------------------------------------------------------------
//
//  CALLBACK STYLE vs ASYNC/AWAIT — Comparison Table:
//  ┌──────────────────────────┬──────────────────────────┐
//  │  Callback Style          │  async/await Style       │
//  ├──────────────────────────┼──────────────────────────┤
//  │  .then((value) {...})    │  var value = await ...   │
//  │  .catchError((e) {...})  │  catch (e) { ... }       │
//  │  .whenComplete(() {...}) │  finally { ... }         │
//  └──────────────────────────┴──────────────────────────┘
//
//  ALL FUTURE METHODS & CONSTRUCTORS COVERED:
//  ┌────────────────────────────┬────────────────────────────────────────────┐
//  │  Method / Constructor      │  What it does                             │
//  ├────────────────────────────┼────────────────────────────────────────────┤
//  │  Future.delayed()          │  Completes after a delay (Sample 1, 2)    │
//  │  .then()                   │  Runs callback on success (Sample 1, 5)   │
//  │  .catchError()             │  Runs callback on error (Sample 3)        │
//  │  .whenComplete()           │  Runs callback always (Sample 9)          │
//  │  Future.wait()             │  Run futures in parallel (Sample 4, 7)    │
//  │  Future.any()              │  First to finish wins (Sample 8)          │
//  │  Future.value()            │  Instant success Future (Sample 6)        │
//  │  Future.error()            │  Instant error Future (Sample 6)          │
//  │  .timeout()                │  Set a time limit (Sample 8)              │
//  │  async / await             │  Cleaner syntax (Sample 2+)              │
//  │  try-catch-finally         │  Error handling (Sample 3, 9, 10)         │
//  │  throw                     │  Trigger an error manually (Sample 3)     │
//  └────────────────────────────┴────────────────────────────────────────────┘
//
//  REAL-WORLD PATTERN (from Sample 10):
//  ┌────────────────────────────────────────────┐
//  │  1. Show loading                           │
//  │  2. try {                                  │
//  │       await login (sequential)             │
//  │       await Future.wait([...]) (parallel)  │
//  │       process results                      │
//  │       display to user                      │
//  │     } catch (e) {                          │
//  │       show error message                   │
//  │     } finally {                            │
//  │       hide loading                         │
//  │     }                                      │
//  └────────────────────────────────────────────┘
//
//  QUICK DECISION RULE:
//  "Does step B need the result of step A?"
//     YES → sequential (await A, then await B)
//     NO  → parallel (Future.wait([A, B]))
//
//  This is the pattern you'll use in Flutter apps, server apps,
//  CLI tools, and anywhere else you work with async data in Dart.
// =============================================================================
