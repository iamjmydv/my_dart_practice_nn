//------------------------------------------------------------------------------
// F U N C T I O N S  —  P O S I T I O N A L  A R G U M E N T S
//------------------------------------------------------------------------------
//
// Positional parameters are the traditional way of defining function parameters.
// Arguments MUST be passed in the EXACT ORDER they are defined.
//
// Think of it like a phone number:
// The area code comes FIRST, then the prefix, then the line number.
// You can't rearrange them — the order IS the meaning.
//
// -----------------------------------------------------------------------
//  #  | WHAT'S COVERED                          | KEY CONCEPT
// -----------------------------------------------------------------------
//  1  | Basic positional parameters             | (Type param1, Type param2)
//  2  | Order matters!                           | Wrong order = error or bug
//  3  | Functions with different param counts   | 0, 1, 2, 3+ parameters
//  4  | Optional positional parameters          | [Type? param] with brackets
//  5  | Positional params with default values   | [Type param = default]
// -----------------------------------------------------------------------
//
// Syntax:  void myFunction(Type param1, Type param2) { ... }
// Calling: myFunction(value1, value2)  ← order must match!
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. BASIC POSITIONAL PARAMETERS
  //    Arguments are matched by POSITION — the first argument
  //    goes to the first parameter, the second to the second, etc.
  //    No labels, just raw values in order.
  // ============================================================
  print('=== Basic positional parameters ===');

  // 'Mario' goes to name, 25 goes to age
  final greeting = greet('Mario', 25);
  print(greeting);
  // Output: Hi my name is Mario and I am 25 years old

  final greeting2 = greet('Luigi', 28);
  print(greeting2);
  // Output: Hi my name is Luigi and I am 28 years old

  print('');

  // ============================================================
  // 2. ORDER MATTERS!
  //    With positional parameters, you MUST pass arguments in the
  //    correct order. If you swap them, you'll get a type error
  //    (or worse, a silent bug if the types happen to match).
  //
  //    Compare with named params: greet(age: 25, name: 'Mario')
  //    That works because of labels. Here, there are no labels.
  // ============================================================
  print('=== Order matters ===');

  // Correct order: String first, int second
  print(greet('Peach', 22));

  // This would cause a compile ERROR because types don't match:
  // print(greet(22, 'Peach'));  // Error! int is not String, String is not int

  // Danger: if both params were the same type, wrong order = silent bug!
  String result = buildFullName('John', 'Doe');
  print(result); // John Doe — correct!

  // If you accidentally swap them:
  String swapped = buildFullName('Doe', 'John');
  print(swapped); // Doe John — wrong! But NO error. This is a silent bug.
  print('  ^ Notice: "Doe John" is wrong but Dart cannot catch this mistake');
  print('    because both parameters are the same type (String).');
  print('    Named parameters would prevent this: buildFullName(first: ..., last: ...)');

  print('');

  // ============================================================
  // 3. FUNCTIONS WITH DIFFERENT PARAMETER COUNTS
  //    Functions can have 0, 1, 2, or many positional parameters.
  //    Each serves a different purpose.
  // ============================================================
  print('=== Different parameter counts ===');

  // 0 parameters — just does something, no input needed
  sayHello();

  // 1 parameter — takes one input
  int doubled = doubleIt(21);
  print('Double of 21: $doubled');

  // 2 parameters — takes two inputs
  int sum = add(10, 20);
  print('10 + 20 = $sum');

  // 3+ parameters — takes many inputs
  String card = createCard('Yoshi', 'Dinosaur', 'Green', 150);
  print(card);

  print('');

  // ============================================================
  // 4. OPTIONAL POSITIONAL PARAMETERS
  //    Wrap parameters in square brackets [ ] to make them optional.
  //    Optional positional params must come AFTER all required ones.
  //    If not provided, the value is null (so use Type?).
  //
  //    Syntax: void func(Type required1, [Type? optional1, Type? optional2])
  // ============================================================
  print('=== Optional positional parameters ===');

  // Provide all 3 arguments
  String intro1 = introduce('Mario', 'Plumber', 'Mushroom Kingdom');
  print(intro1);
  // Output: Mario is a Plumber from Mushroom Kingdom

  // Provide only 2 — hometown is null
  String intro2 = introduce('Luigi', 'Plumber');
  print(intro2);
  // Output: Luigi is a Plumber from (unknown)

  // Provide only 1 — job and hometown are null
  String intro3 = introduce('Toad');
  print(intro3);
  // Output: Toad is a (unknown) from (unknown)

  print('');

  // ============================================================
  // 5. POSITIONAL PARAMS WITH DEFAULT VALUES
  //    Instead of getting null, optional positional parameters
  //    can have default values. If the caller skips them,
  //    the default is used automatically.
  // ============================================================
  print('=== Default values for optional positional params ===');

  // Provide all arguments
  String msg1 = formatMessage('Hello', '!!!', 3);
  print(msg1);
  // Output: Hello!!! Hello!!! Hello!!!

  // Skip repeat count — uses default of 1
  String msg2 = formatMessage('Dart is cool', '.');
  print(msg2);
  // Output: Dart is cool.

  // Skip both optional params — uses defaults
  String msg3 = formatMessage('Simple');
  print(msg3);
  // Output: Simple

  print('');
}

// --- Helper functions ---

// Basic positional parameters — order must match!
// No curly braces = positional (not named)
String greet(String name, int age) {
  return 'Hi my name is $name and I am $age years old';
}

// Two String params — easy to accidentally swap!
// This is why named params are safer for same-type parameters.
String buildFullName(String firstName, String lastName) {
  return '$firstName $lastName';
}

// 0 parameters
void sayHello() {
  print('Hello, World!');
}

// 1 parameter
int doubleIt(int number) {
  return number * 2;
}

// 2 parameters
int add(int a, int b) {
  return a + b;
}

// 3+ parameters — starts getting hard to remember the order!
// This is where named parameters would be a better choice.
String createCard(String name, String species, String color, int weight) {
  return '$name | Species: $species | Color: $color | Weight: ${weight}lb';
}

// Optional positional parameters — wrapped in [ ]
// 'name' is required, 'job' and 'hometown' are optional
String introduce(String name, [String? job, String? hometown]) {
  String displayJob = job ?? '(unknown)';
  String displayHometown = hometown ?? '(unknown)';
  return '$name is a $displayJob from $displayHometown';
}

// Optional positional parameters with default values
// 'text' is required, 'suffix' and 'repeat' are optional with defaults
String formatMessage(String text, [String suffix = '', int repeat = 1]) {
  String full = '$text$suffix';
  List<String> parts = [];
  for (int i = 0; i < repeat; i++) {
    parts.add(full);
  }
  return parts.join(' ');
}

//------------------------------------------------------------------------------
// NOTES:
//------------------------------------------------------------------------------
//
//  1. Positional parameters don't have labels — order is everything
//  2. All positional parameters are REQUIRED by default
//  3. Wrong order = compile error (if types differ) or silent bug (same types)
//  4. Wrap in [ ] to make positional params optional
//  5. Optional positional params can have default values: [int count = 1]
//  6. Optional positional params MUST come after all required ones
//
//  NAMED vs POSITIONAL — When to use which:
//  ┌──────────────────────────────────┬──────────────────────────────────┐
//  │  Positional                      │  Named                          │
//  ├──────────────────────────────────┼──────────────────────────────────┤
//  │  Good for 1-2 obvious params    │  Good for 2+ params             │
//  │  Shorter to write at call site  │  More readable at call site     │
//  │  Order must be memorized        │  Order doesn't matter           │
//  │  add(10, 20)                    │  greet(name: 'Luigi', age: 25)  │
//  │  Common in utility functions    │  Common in Flutter widgets      │
//  └──────────────────────────────────┴──────────────────────────────────┘
//
//  RULE OF THUMB:
//  - 1 param → positional is fine: doubleIt(5)
//  - 2 params of DIFFERENT types → positional is OK: greet('Mario', 25)
//  - 2 params of SAME type → use named to avoid bugs!
//  - 3+ params → almost always use named parameters
//
//------------------------------------------------------------------------------
