//------------------------------------------------------------------------------
// F U T U R E - A S Y N C - A W A I T
//------------------------------------------------------------------------------
// SAMPLE 8: Future.any() AND .timeout() — Racing & Time Limits
//------------------------------------------------------------------------------
//
// Future.any()   → starts multiple futures, returns the FIRST one to finish
//                  Think: "Race! Whoever finishes first wins."
//
// .timeout()     → sets a time limit on a future. If it takes too long,
//                  throw a TimeoutException instead of waiting forever.
//                  Think: "You have 3 seconds. If not done, I give up."
//
// Both are useful for making apps RESPONSIVE and avoiding long waits.
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Future.any() — first to finish wins   | Pick the fastest data source
//  2  | .timeout() — set a time limit         | Don't wait forever for slow servers
//  3  | .timeout() with onTimeout callback    | Provide a fallback value on timeout
// -----------------------------------------------------------------------
//
void main() async {
  // ============================================================
  // 1. Future.any() — First one to complete wins
  //    Starts ALL futures at the same time, but only returns
  //    the result of whichever finishes FIRST.
  //    The rest are still running but their results are ignored.
  //
  //    Use case: Try multiple servers, use whichever responds first.
  // ============================================================
  print('=== Future.any() — Race! ===');

  String fastest = await Future.any([
    fetchFromServerA(), // 3 seconds
    fetchFromServerB(), // 1 second  ← this wins!
    fetchFromServerC(), // 2 seconds
  ]);

  print('Winner: $fastest'); // Winner: Data from Server B (fastest!)
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
  print('=== .timeout() — Time limit ===');

  // This future takes 5 seconds, but we only give it 2 seconds
  try {
    String result = await slowServer().timeout(Duration(seconds: 2));
    print('Got result: $result'); // won't run (times out first)
  } catch (e) {
    print('Timed out! Error: $e');
    // Timed out! Error: TimeoutException after 0:00:02.000000: Future not completed
  }

  print('');

  // This future takes 1 second, and we give it 3 seconds — plenty of time
  try {
    String result = await fastServer().timeout(Duration(seconds: 3));
    print('Got result: $result'); // Got result: Fast response!
  } catch (e) {
    print('Timed out! Error: $e'); // won't run (finishes in time)
  }

  print('');

  // ============================================================
  // 3. .timeout() WITH onTimeout CALLBACK — Provide a fallback
  //    Instead of throwing an error on timeout, you can provide
  //    a default value using the onTimeout parameter.
  //    Think: "If the server is slow, just use this default."
  // ============================================================
  print('=== .timeout() with fallback ===');

  String weather = await fetchWeatherFromAPI()
      .timeout(
        Duration(seconds: 2),
        onTimeout: () => 'Weather data unavailable (using default)',
      );

  print('Weather: $weather');
  // Weather: Weather data unavailable (using default)
  // (because fetchWeatherFromAPI takes 5 seconds, but timeout is 2)

  print('');

  // With enough time, it returns the real data
  String weather2 = await fetchWeatherFast()
      .timeout(
        Duration(seconds: 3),
        onTimeout: () => 'Weather data unavailable (using default)',
      );

  print('Weather2: $weather2');
  // Weather2: Sunny, 28°C (real data, finished before timeout)
}

// ============================================================
// SIMULATED ASYNC FUNCTIONS
// ============================================================

// --- Future.any() demo ---
Future<String> fetchFromServerA() async {
  await Future.delayed(Duration(seconds: 3));
  return 'Data from Server A (slow)';
}

Future<String> fetchFromServerB() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Data from Server B (fastest!)';
}

Future<String> fetchFromServerC() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data from Server C (medium)';
}

// --- .timeout() demo ---
Future<String> slowServer() async {
  await Future.delayed(Duration(seconds: 5));
  return 'Slow response (took 5 seconds)';
}

Future<String> fastServer() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Fast response!';
}

// --- .timeout() with fallback demo ---
Future<String> fetchWeatherFromAPI() async {
  await Future.delayed(Duration(seconds: 5)); // too slow!
  return 'Sunny, 28°C';
}

Future<String> fetchWeatherFast() async {
  await Future.delayed(Duration(seconds: 1)); // fast enough
  return 'Sunny, 28°C';
}

// ============================================================
// NOTES: Future.any() and .timeout() Summary
// ============================================================
//  1. Future.any([...])        — returns the FIRST future to complete
//                                (the rest are ignored)
//  2. .timeout(Duration)       — throws TimeoutException if too slow
//  3. .timeout(onTimeout: ...) — returns a fallback value instead of error
//
//  WHEN TO USE:
//  - Future.any(): Try multiple servers/sources, use the fastest response
//  - .timeout(): Prevent your app from freezing on a slow network call
//  - .timeout(onTimeout): Show default/cached data when the server is slow
//
//  IMPORTANT:
//  - Future.any() does NOT cancel the slower futures. They keep running
//    in the background, but their results are simply not used.
//  - .timeout() does NOT cancel the original future either. It just
//    stops waiting for it and throws/returns the fallback.
// ============================================================
