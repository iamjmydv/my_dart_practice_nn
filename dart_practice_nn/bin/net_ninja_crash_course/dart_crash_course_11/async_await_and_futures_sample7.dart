//------------------------------------------------------------------------------
// F U T U R E - A S Y N C - A W A I T
//------------------------------------------------------------------------------
// SAMPLE 7: SEQUENTIAL vs PARALLEL — When to use which
//------------------------------------------------------------------------------
//
// This sample compares TWO approaches to running multiple Futures:
//
// SEQUENTIAL: Run one at a time. Use when step 2 NEEDS step 1's result.
//   Example: Login first → then fetch that user's data
//
// PARALLEL: Run all at once. Use when tasks are INDEPENDENT.
//   Example: Fetch weather + news + stocks at the same time
//
// Choosing the right approach can make your app 2-3x faster!
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Sequential — dependent tasks          | When results depend on each other
//  2  | Parallel — independent tasks          | When tasks can run at the same time
//  3  | Mixed — some depend, some don't       | Real-world apps use BOTH together
// -----------------------------------------------------------------------
//
void main() async {
  // ============================================================
  // 1. SEQUENTIAL — Tasks that DEPEND on each other
  //    You MUST wait for each step before starting the next.
  //    Here: you can't fetch orders without the userId,
  //    and you can't calculate the total without the orders.
  //
  //    Total time: 1 + 2 + 1 = 4 seconds
  // ============================================================
  print('=== Sequential (dependent tasks) ===');
  Stopwatch sw = Stopwatch()..start();

  // Step 1: Get the userId first (1 second)
  int userId = await authenticate('alice', 'pass123');
  print('1. Got userId: $userId');

  // Step 2: Fetch orders for THAT userId (2 seconds)
  //         Can't start this until we have the userId!
  List<String> orders = await fetchOrders(userId);
  print('2. Got orders: $orders');

  // Step 3: Calculate total for THOSE orders (1 second)
  //         Can't start this until we have the orders!
  double total = await calculateTotal(orders);
  print('3. Total: \$$total');

  sw.stop();
  print('Sequential time: ${sw.elapsed.inSeconds}s (expected ~4s)');
  print('');

  // ============================================================
  // 2. PARALLEL — Tasks that are INDEPENDENT
  //    These three tasks don't need each other's results.
  //    Run them ALL at the same time with Future.wait().
  //
  //    Total time: max(2, 3, 1) = 3 seconds (the slowest one)
  // ============================================================
  print('=== Parallel (independent tasks) ===');
  sw = Stopwatch()..start();

  // All three start at the SAME time
  var results = await Future.wait([
    fetchWeather(), // 2 seconds
    fetchNews(), // 3 seconds
    fetchStockPrice(), // 1 second
  ]);

  print('Weather: ${results[0]}');
  print('News: ${results[1]}');
  print('Stock: ${results[2]}');

  sw.stop();
  print('Parallel time: ${sw.elapsed.inSeconds}s (expected ~3s)');
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
  print('=== Mixed (sequential + parallel) ===');
  sw = Stopwatch()..start();

  // Step 1: Must login first (sequential — need the token)
  String token = await loginUser('bob');
  print('1. Logged in with token: $token');

  // Step 2: Fetch profile AND notifications at the SAME time (parallel)
  //         Both need the token, but they don't need each other!
  var dashboardData = await Future.wait([
    fetchProfile(token), // 2 seconds
    fetchNotifications(token), // 2 seconds
  ]);
  String profile = dashboardData[0];
  String notifications = dashboardData[1];
  print('2. Profile: $profile');
  print('2. Notifications: $notifications');

  // Step 3: Build dashboard (needs both results — sequential)
  String dashboard = await buildDashboard(profile, notifications);
  print('3. $dashboard');

  sw.stop();
  print('Mixed time: ${sw.elapsed.inSeconds}s (saved ~2s vs all sequential!)');
}

// ============================================================
// SIMULATED ASYNC FUNCTIONS
// ============================================================

// --- Sequential demo functions ---
Future<int> authenticate(String user, String pass) async {
  await Future.delayed(Duration(seconds: 1));
  return 42; // fake userId
}

Future<List<String>> fetchOrders(int userId) async {
  await Future.delayed(Duration(seconds: 2));
  return ['Order-A', 'Order-B', 'Order-C'];
}

Future<double> calculateTotal(List<String> orders) async {
  await Future.delayed(Duration(seconds: 1));
  return 149.99;
}

// --- Parallel demo functions ---
Future<String> fetchWeather() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Sunny, 25°C';
}

Future<String> fetchNews() async {
  await Future.delayed(Duration(seconds: 3));
  return 'Dart 3.0 Released!';
}

Future<String> fetchStockPrice() async {
  await Future.delayed(Duration(seconds: 1));
  return '\$150.25';
}

// --- Mixed demo functions ---
Future<String> loginUser(String username) async {
  await Future.delayed(Duration(seconds: 1));
  return 'token_abc123';
}

Future<String> fetchProfile(String token) async {
  await Future.delayed(Duration(seconds: 2));
  return 'Bob (Premium User)';
}

Future<String> fetchNotifications(String token) async {
  await Future.delayed(Duration(seconds: 2));
  return '3 new messages';
}

Future<String> buildDashboard(String profile, String notifications) async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dashboard: $profile | $notifications';
}

// ============================================================
// NOTES: Sequential vs Parallel Summary
// ============================================================
//  1. SEQUENTIAL (await one by one):
//     - Use when each step NEEDS the result of the previous step
//     - Total time = sum of ALL durations
//     - Example: login → get token → use token to fetch data
//
//  2. PARALLEL (Future.wait):
//     - Use when tasks are INDEPENDENT of each other
//     - Total time = duration of the SLOWEST task only
//     - Example: fetch weather + news + stocks simultaneously
//
//  3. MIXED (both together):
//     - Real apps use BOTH patterns
//     - Sequential for dependent steps, parallel for independent ones
//     - Can save a LOT of time compared to all-sequential
//
//  QUICK RULE:
//  "Does step B need the result of step A?"
//     YES → sequential (await A, then await B)
//     NO  → parallel (Future.wait([A, B]))
// ============================================================
