//------------------------------
// C O N T R O L - F L O W
//------------------------------
//
// This file covers all major control flow constructs in Dart.
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                        | KEYWORDS USED          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | for-in loop with .where()    | for, in, .where()      | Filter items before looping
//  2  | if / else if / else chain    | if, else if, else      | Multiple conditions checked top-to-bottom
//  3  | if / else inside a loop      | for, in, if, else      | Categorize items while iterating
//  4  | for-in loop (forEach style)  | for, in               | Loop through every item without needing an index
//  5  | Standard for loop with index | for, i++, .length      | When you need the position, not just the value
//  6  | while loop                   | while                  | When iteration count is unknown ahead of time
//  7  | do-while loop                | do, while              | Guarantees at least one execution
//  8  | break                        | break                  | Exit a loop early (e.g., stop searching)
//  9  | continue                     | continue               | Skip certain iterations without stopping
// 10  | Ternary operator             | ? :                    | One-line if/else for assignments
// 11  | switch statement             | switch, case, default, break | Cleaner than long if/else chains
// 12  | Switch expression (Dart 3+)  | switch, =>, _ , ||     | Modern concise syntax that returns a value
// 13  | Null check with if           | if, != null, ?         | Safely handle nullable values
// 14  | try / catch / finally        | try, catch, finally    | Error handling without crashing
// 15  | assert                       | assert                 | Debug-only validation
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. FOR-IN LOOP WITH .where() - Filter items before looping
  //    .where() returns only elements that pass the condition,
  //    so the loop only runs on matching items.
  // ============================================================
  List<int> scores = [50, 75, 20, 99, 100, 30];
  print(scores);

  for (int score in scores.where((s) => s > 50)) {
    print('The score $score is greater than 50!');
  }

  // ============================================================
  // 2. IF / ELSE IF / ELSE - Run different code based on conditions
  //    Checks conditions top-to-bottom, runs the FIRST match only.
  // ============================================================
  int temperature = 35;

  if (temperature >= 30) {
    print('It is hot outside!');
  } else if (temperature >= 20) {
    print('Nice weather!');
  } else if (temperature >= 10) {
    print('A bit chilly.');
  } else {
    print('It is cold outside!');
  }

  // ============================================================
  // 3. IF / ELSE inside a loop - Common for categorizing list items
  // ============================================================
  List<int> scores2 = [50, 75, 20, 99, 100, 30];

  for (int score in scores2) {
    if (score > 50) {
      print('$score - Passed!');
    } else {
      print('$score - Not high enough.');
    }
  }

  // ============================================================
  // 4. FOR-IN LOOP (forEach style) - Loop through every item in a list
  //    Simpler than a regular for-loop when you don't need the index.
  // ============================================================
  List<int> scores3 = [50, 75, 20, 99, 100, 30];

  for (int score in scores3) {
    print('Score: $score');
  }

  // ============================================================
  // 5. STANDARD FOR LOOP - Use when you need the index (i)
  //    Great for accessing items by position or counting iterations.
  // ============================================================
  List<int> scores4 = [50, 75, 20, 99, 100, 30];

  for (int i = 0; i < scores4.length; i++) {
    print('Score at index $i is ${scores4[i]}');
  }

  // ============================================================
  // 6. WHILE LOOP - Keeps running as long as the condition is true
  //    Useful when you don't know how many times you need to loop.
  // ============================================================
  int countdown = 5;

  while (countdown > 0) {
    print('Countdown: $countdown');
    countdown--; // decrease by 1 each time
  }
  print('Go!');

  // ============================================================
  // 7. DO-WHILE LOOP - Runs the code FIRST, then checks the condition
  //    Guarantees the code runs at least once.
  // ============================================================
  int attempts = 0;

  do {
    attempts++;
    print('Attempt #$attempts');
  } while (attempts < 3);

  // ============================================================
  // 8. BREAK - Exit a loop early when a condition is met
  //    Commonly used to stop searching once you find what you need.
  // ============================================================
  List<String> names = ['Alice', 'Bob', 'Charlie', 'Diana'];

  for (String name in names) {
    if (name == 'Charlie') {
      print('Found Charlie! Stopping search.');
      break; // exits the loop immediately
    }
    print('Checking $name...');
  }

  // ============================================================
  // 9. CONTINUE - Skip the current iteration and move to the next
  //    Useful for ignoring certain items without stopping the loop.
  // ============================================================
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8];

  for (int num in numbers) {
    if (num % 2 == 0) {
      continue; // skip even numbers
    }
    print('Odd number: $num');
  }

  // ============================================================
  // 10. TERNARY OPERATOR - A one-line if/else
  //     Format: condition ? valueIfTrue : valueIfFalse
  //     Great for assigning values based on a condition.
  // ============================================================
  int age = 20;
  String status = age >= 18 ? 'Adult' : 'Minor';
  print('$age years old -> $status');

  // ============================================================
  // 11. SWITCH STATEMENT - Match a value against multiple cases
  //     Cleaner than long if/else chains when comparing one variable.
  // ============================================================
  String role = 'admin';

  switch (role) {
    case 'admin':
      print('Full access granted.');
      break;
    case 'editor':
      print('Edit access granted.');
      break;
    case 'viewer':
      print('Read-only access.');
      break;
    default:
      print('Unknown role.');
  }

  // ============================================================
  // 12. SWITCH EXPRESSION (Dart 3+) - Modern, concise switch
  //     Returns a value directly. No need for break statements.
  // ============================================================
  String day = 'Monday';

  String type = switch (day) {
    'Monday' || 'Tuesday' || 'Wednesday' || 'Thursday' || 'Friday' => 'Weekday',
    'Saturday' || 'Sunday' => 'Weekend',
    _ => 'Unknown', // _ is the default/wildcard case
  };
  print('$day is a $type');

  // ============================================================
  // 13. NULL CHECK WITH IF - Safely handle values that might be null
  //     Very common in real apps (e.g., API responses, user input).
  // ============================================================
  // try changing the value to null to see the else branch run
  String? username = getUserName();

  if (username != null) {
    print('Welcome, $username!');
  } else {
    print('No user logged in.');
  }

  // ============================================================
  // 14. TRY / CATCH / FINALLY - Handle errors without crashing
  //     try: code that might fail
  //     catch: what to do if it fails
  //     finally: code that ALWAYS runs (cleanup)
  // ============================================================
  try {
    int result = 10 ~/ 0; // integer division by zero
    print(result);
  } catch (e) {
    print('Error: $e');
  } finally {
    print('This always runs, error or not.');
  }

  // ============================================================
  // 15. ASSERT - Debug-only check (ignored in production)
  //     Crashes with a message if the condition is false.
  //     Useful for catching bugs during development.
  // ============================================================
  int price = 100;
  assert(price > 0, 'Price must be positive!');
  print('Price is valid: $price');
}

// Helper function for section 13 (Null Check).
// Returns a nullable String to simulate real-world scenarios
// like fetching data from an API or database.
// Try changing the return value to null to test the else branch.
String? getUserName() {
  return 'JohnAce';
}
