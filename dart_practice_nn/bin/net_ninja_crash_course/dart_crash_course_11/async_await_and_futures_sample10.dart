//------------------------------------------------------------------------------
// F U T U R E - A S Y N C - A W A I T
//------------------------------------------------------------------------------
// SAMPLE 10: REAL-WORLD PATTERN — Async Data Pipeline
//------------------------------------------------------------------------------
//
// This sample puts EVERYTHING together in a realistic scenario.
// It simulates a mini app that:
//   1. Logs in a user
//   2. Fetches their profile + orders in parallel
//   3. Processes the orders
//   4. Displays a summary
//   5. Handles errors and cleanup properly
//
// This uses: async/await, Future.wait(), try-catch-finally,
// error handling, and sequential + parallel patterns.
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
void main() async {
  // ============================================================
  // FULL REAL-WORLD FLOW
  // This is how you'd structure async code in a real app.
  // Notice: sequential when needed, parallel when possible.
  // ============================================================
  print('========================================');
  print('  MINI ORDER DASHBOARD');
  print('========================================');
  print('');

  bool isLoading = true;

  try {
    // --- Step 1: Login (SEQUENTIAL — need the token first) ---
    print('[1/4] Logging in...');
    String token = await loginToServer('john_doe', 'mypassword');
    print('      Logged in! Token: $token');
    print('');

    // --- Step 2: Fetch profile AND orders (PARALLEL — independent!) ---
    print('[2/4] Fetching profile and orders...');
    var results = await Future.wait([
      fetchUserProfile(token),
      fetchUserOrders(token),
    ]);

    UserProfile profile = results[0] as UserProfile;
    List<Order> orders = results[1] as List<Order>;

    print('      Profile: ${profile.name} (${profile.email})');
    print('      Orders found: ${orders.length}');
    print('');

    // --- Step 3: Process orders (SEQUENTIAL — calculate totals) ---
    print('[3/4] Processing orders...');
    double grandTotal = 0;
    for (var order in orders) {
      print('      - ${order.item}: \$${order.price.toStringAsFixed(2)}');
      grandTotal += order.price;
    }
    print('');

    // --- Step 4: Display summary ---
    print('[4/4] Dashboard Summary');
    print('      ┌──────────────────────────────┐');
    print('      │  Welcome, ${profile.name}!');
    print('      │  Email: ${profile.email}');
    print('      │  Member since: ${profile.memberSince}');
    print('      │  Orders: ${orders.length}');
    print('      │  Grand Total: \$${grandTotal.toStringAsFixed(2)}');
    print('      └──────────────────────────────┘');
  } catch (e) {
    // If ANY step fails, we land here
    print('');
    print('ERROR: $e');
    print('Please try again later.');
  } finally {
    // ALWAYS runs — success or failure
    isLoading = false;
    print('');
    print('(Loading complete. isLoading = $isLoading)');
    print('========================================');
  }

  print('');

  // ============================================================
  // BONUS: What happens when something fails?
  // Uncomment the line below to simulate a login failure
  // and see how the error handling works.
  // ============================================================
  print('--- Simulating a failed login ---');

  try {
    print('[1/4] Logging in with bad credentials...');
    String token = await loginToServer('hacker', 'wrongpassword');
    print('      Token: $token'); // won't reach here
  } catch (e) {
    print('      Login failed: $e');
    // Steps 2-4 never run because we caught the error early
  } finally {
    print('      (Cleanup done)');
  }
}

// ============================================================
// DATA CLASSES (like models/DTOs in real apps)
// ============================================================

class UserProfile {
  String name;
  String email;
  String memberSince;

  UserProfile(this.name, this.email, this.memberSince);
}

class Order {
  String item;
  double price;
  String date;

  Order(this.item, this.price, this.date);
}

// ============================================================
// ASYNC FUNCTIONS (simulate real API calls)
// ============================================================

// Step 1: Login — returns a token or throws an error
Future<String> loginToServer(String username, String password) async {
  await Future.delayed(Duration(seconds: 1));

  // Simulate validation — reject bad credentials
  if (username == 'hacker' || password == 'wrongpassword') {
    throw 'Invalid credentials for user "$username"';
  }

  return 'tok_${username}_2024'; // fake token
}

// Step 2a: Fetch user profile using the token
Future<UserProfile> fetchUserProfile(String token) async {
  await Future.delayed(Duration(seconds: 2));
  return UserProfile(
    'John Doe',
    'john@example.com',
    'January 2023',
  );
}

// Step 2b: Fetch user orders using the token
Future<List<Order>> fetchUserOrders(String token) async {
  await Future.delayed(Duration(seconds: 2));
  return [
    Order('Dart Programming Book', 39.99, '2024-01-15'),
    Order('Mechanical Keyboard', 129.99, '2024-02-20'),
    Order('USB-C Hub', 24.99, '2024-03-05'),
    Order('Monitor Stand', 45.00, '2024-03-18'),
  ];
}

// ============================================================
// NOTES: Real-World Async Pattern Summary
// ============================================================
//
//  THIS SAMPLE COMBINES ALL CONCEPTS FROM SAMPLES 1-9:
//
//  From Sample 1: .then() callbacks (Future basics)
//  From Sample 2: async/await syntax
//  From Sample 3: try-catch-finally error handling
//  From Sample 4: Future.wait() for parallel execution
//  From Sample 5: Chaining dependent async calls
//  From Sample 6: Understanding when futures resolve
//  From Sample 7: Sequential vs parallel decision-making
//  From Sample 8: Timeout and racing (could add .timeout() here too)
//  From Sample 9: Cleanup with finally (isLoading flag)
//
//  REAL-WORLD PATTERN:
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
//  This is the pattern you'll use in Flutter apps, server apps,
//  CLI tools, and anywhere else you work with async data in Dart.
// ============================================================
