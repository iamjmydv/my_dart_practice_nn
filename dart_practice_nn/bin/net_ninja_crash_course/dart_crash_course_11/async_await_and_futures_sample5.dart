//------------------------------------------------------------------------------
// F U T U R E - A S Y N C - A W A I T
//------------------------------------------------------------------------------
// SAMPLE 5: CHAINING FUTURES WITH .then()
//------------------------------------------------------------------------------
//
// Sometimes you need to do async tasks ONE AFTER ANOTHER where
// each step depends on the result of the previous step.
// Example: First log in → then get profile → then get posts
//
// You can chain .then() calls like links in a chain.
// Each .then() receives the result of the previous future.
//
// We also show the async/await version (which is usually cleaner).
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Chain .then() calls                   | Step-by-step async operations
//  2  | Same thing with async/await           | Cleaner, easier-to-read version
//  3  | Chaining with data transformation     | Transform data at each step
// -----------------------------------------------------------------------
//
void main() async {
  // ============================================================
  // 1. CHAINING .then() — Each step depends on the previous one
  //    Step 1: Log in and get a userId
  //    Step 2: Use that userId to fetch the user's profile
  //    Step 3: Use that profile to get a greeting message
  //
  //    Each .then() passes its result to the NEXT .then().
  //    Like a relay race — one runner passes the baton to the next.
  // ============================================================
  print('=== Chaining with .then() ===');

  login('alice', 'password123')
      .then((userId) {
        print('Step 1 — Logged in. userId: $userId');
        return getProfile(userId); // pass userId to next step
      })
      .then((profile) {
        print('Step 2 — Got profile: $profile');
        return createGreeting(profile); // pass profile to next step
      })
      .then((greeting) {
        print('Step 3 — $greeting');
      })
      .catchError((e) {
        // If ANY step fails, this catches the error
        print('Something went wrong: $e');
      });

  // Wait for the chain above to finish before starting the next section
  await Future.delayed(Duration(seconds: 7));
  print('');

  // ============================================================
  // 2. SAME THING WITH async/await — Much cleaner to read
  //    Instead of nesting .then() callbacks, you just use
  //    await on each line. The code reads top-to-bottom,
  //    just like normal synchronous code.
  // ============================================================
  print('=== Same thing with async/await ===');

  try {
    int userId = await login('bob', 'secret456');
    print('Step 1 — Logged in. userId: $userId');

    String profile = await getProfile(userId);
    print('Step 2 — Got profile: $profile');

    String greeting = await createGreeting(profile);
    print('Step 3 — $greeting');
  } catch (e) {
    print('Something went wrong: $e');
  }

  print('');

  // ============================================================
  // 3. CHAINING WITH DATA TRANSFORMATION
  //    You can transform data at each step of the chain.
  //    Here we: fetch a number → double it → format it as text.
  //    Each .then() takes the previous result and returns
  //    something new for the next .then().
  // ============================================================
  print('=== Chaining with transformation ===');

  fetchNumber()
      .then((number) {
        print('Original number: $number');
        return number * 2; // transform: double the number
      })
      .then((doubled) {
        print('Doubled: $doubled');
        return 'The final answer is $doubled'; // transform: to String
      })
      .then((message) {
        print(message); // The final answer is 84
      });

  await Future.delayed(Duration(seconds: 2));
}

// ============================================================
// SIMULATED ASYNC FUNCTIONS
// These pretend to be real operations (login, fetch profile, etc.)
// ============================================================

// Step 1: "Log in" and return a userId (takes 2 seconds)
Future<int> login(String username, String password) async {
  await Future.delayed(Duration(seconds: 2));
  print('(server: logging in $username...)');
  return 42; // fake userId
}

// Step 2: Use the userId to "fetch" a profile (takes 2 seconds)
Future<String> getProfile(int userId) async {
  await Future.delayed(Duration(seconds: 2));
  print('(server: fetching profile for user $userId...)');
  return 'Alice (ID: $userId)'; // fake profile
}

// Step 3: Create a greeting from the profile (takes 1 second)
Future<String> createGreeting(String profile) async {
  await Future.delayed(Duration(seconds: 1));
  return 'Welcome back, $profile!';
}

// Simple function that returns a number after a delay
Future<int> fetchNumber() async {
  await Future.delayed(Duration(seconds: 1));
  return 42;
}

// ============================================================
// NOTES: Chaining Futures Summary
// ============================================================
//  1. .then().then().then()     — chain dependent async operations
//  2. Each .then() receives     — the RESULT of the previous future
//  3. .catchError() at the end  — catches errors from ANY step in the chain
//  4. async/await version       — same thing but reads like normal code
//  5. You can transform data    — each .then() can return a different type
//
//  WHEN TO USE CHAINING:
//  - When step 2 needs the result of step 1
//  - When step 3 needs the result of step 2
//  - Example: login → get token → fetch data with token
//
//  TIP: Prefer async/await over .then() chains.
//  It's easier to read, easier to debug, and easier to add
//  error handling with try-catch.
// ============================================================
