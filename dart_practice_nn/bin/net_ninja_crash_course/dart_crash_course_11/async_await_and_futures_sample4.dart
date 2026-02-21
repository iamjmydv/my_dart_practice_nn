//------------------------------------------------------------------------------
// F U T U R E - A S Y N C - A W A I T
//------------------------------------------------------------------------------
// SAMPLE 4: MULTIPLE FUTURES WITH Future.wait()
//------------------------------------------------------------------------------
//
// Sometimes you need to fetch MULTIPLE things at the same time.
// Example: Load a user's profile, their posts, AND their settings
// all at once — instead of waiting for each one, one by one.
//
// Future.wait() runs multiple futures IN PARALLEL (at the same time)
// and waits for ALL of them to finish before moving on.
// Think of it like: "Go get milk, bread, and eggs at the same time."
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
void main() async {
  // ============================================================
  // 1. SEQUENTIAL — One after another (SLOW)
  //    Each await waits for the previous one to finish.
  //    Total time: 2 + 3 + 1 = 6 seconds
  // ============================================================
  print('=== Sequential (one by one) ===');
  Stopwatch stopwatch = Stopwatch()..start();

  String user = await fetchUserName(); // waits 2 seconds
  String post = await fetchLatestPost(); // waits 3 seconds
  String setting = await fetchSettings(); // waits 1 second

  stopwatch.stop();
  print('User: $user');
  print('Post: $post');
  print('Setting: $setting');
  print('Sequential took: ${stopwatch.elapsed.inSeconds} seconds');
  // Sequential took: ~6 seconds (2 + 3 + 1)

  print('');

  // ============================================================
  // 2. PARALLEL WITH Future.wait() — All at the same time (FAST)
  //    Future.wait() takes a LIST of futures and runs them all
  //    at the same time. It returns a List of results when ALL
  //    futures are done.
  //    Total time: max(2, 3, 1) = 3 seconds (the slowest one)
  // ============================================================
  print('=== Parallel (all at once) ===');
  stopwatch = Stopwatch()..start();

  List<String> results = await Future.wait([
    fetchUserName(), // starts immediately
    fetchLatestPost(), // starts immediately
    fetchSettings(), // starts immediately
  ]);
  // All three run at the same time!
  // It only takes as long as the SLOWEST one (3 seconds)

  stopwatch.stop();
  print('User: ${results[0]}');
  print('Post: ${results[1]}');
  print('Setting: ${results[2]}');
  print('Parallel took: ${stopwatch.elapsed.inSeconds} seconds');
  // Parallel took: ~3 seconds (only as slow as the slowest future)

  print('');

  // ============================================================
  // 3. ACCESSING INDIVIDUAL RESULTS — Each result is in the list
  //    The results list has the SAME ORDER as the futures list.
  //    results[0] = fetchUserName result
  //    results[1] = fetchLatestPost result
  //    results[2] = fetchSettings result
  // ============================================================
  print('=== Accessing results individually ===');
  String userName = results[0];
  String latestPost = results[1];
  String userSettings = results[2];

  print('Welcome back, $userName!');
  print('Your latest post: "$latestPost"');
  print('Theme: $userSettings');

  print('');

  // ============================================================
  // 4. Future.wait() WITH ERROR HANDLING
  //    If ANY of the futures throws an error, Future.wait()
  //    throws that error. Use try-catch to handle it.
  //    Think of it like: if ONE errand fails, the whole trip fails.
  // ============================================================
  print('=== Future.wait() with error ===');
  try {
    List<String> badResults = await Future.wait([
      fetchUserName(), // succeeds
      fetchBrokenData(), // FAILS — throws an error
      fetchSettings(), // succeeds
    ]);
    print(badResults); // This line won't run
  } catch (e) {
    print('One of the futures failed: $e');
    // One of the futures failed: Server error: data not available
  }
}

// ============================================================
// SIMULATED ASYNC FUNCTIONS
// Each one pretends to fetch data from a server.
// The Duration simulates how long the "server" takes to respond.
// ============================================================

// Takes 2 seconds to "fetch" a username
Future<String> fetchUserName() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Alice';
}

// Takes 3 seconds to "fetch" a post
Future<String> fetchLatestPost() async {
  await Future.delayed(Duration(seconds: 3));
  return 'Learning Dart Futures!';
}

// Takes 1 second to "fetch" settings
Future<String> fetchSettings() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dark Mode';
}

// This one ALWAYS fails — to demonstrate error handling
Future<String> fetchBrokenData() async {
  await Future.delayed(Duration(seconds: 1));
  throw 'Server error: data not available';
}

// ============================================================
// NOTES: Future.wait() Summary
// ============================================================
//  1. Sequential (await one by one)   — simple but SLOW
//  2. Future.wait([...])              — runs futures in PARALLEL (fast!)
//  3. Results come back as a List     — same order as the input list
//  4. If ANY future fails             — the whole Future.wait() fails
//  5. Use try-catch with Future.wait  — to handle errors gracefully
//
//  WHEN TO USE:
//  - Use Future.wait() when futures DON'T depend on each other
//    (e.g., fetching user + posts + settings at the same time)
//  - Use sequential awaits when one result DEPENDS on another
//    (e.g., fetch user first, then fetch THAT user's posts)
// ============================================================
