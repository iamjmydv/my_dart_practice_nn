//------------------------------------------------------------------------------
// F U N C T I O N S  —  C O M P L E T E  G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 4 samples into one runnable file.
// Functions are reusable blocks of code that take inputs (parameters),
// do something, and optionally return a result.
//
// Dart supports several ways to define and pass parameters:
//   - Named parameters (with labels at the call site)
//   - Positional parameters (matched by order)
//   - Required vs optional parameters
//   - Typed vs dynamic (untyped) parameters
//
// Each section has a numbered header, a short description of what it does,
// and detailed comments explaining every concept.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                              | KEY CONCEPTS
// -----------------------------------------------------------------------
//  1  | Named params (required)            | {required Type name}, any order
//  2  | Named params (optional/nullable)   | {Type? name}, defaults, ?? operator
//  3  | Positional arguments               | (Type name), order matters, [optional]
//  4  | Dynamic functions (no types)        | No annotations, dynamic, why to avoid
// -----------------------------------------------------------------------
//
// TIP: To run just ONE sample, comment out the others in main().
//
// -----------------------------------------------------------------------

void main() {
  // ============================================================
  //  Uncomment/comment any sample to run only what you want.
  //  Each sample is independent — they don't depend on each other.
  // ============================================================

  sample1NamedRequired();
  sample2NamedOptional();
  sample3Positional();
  sample4Dynamic();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  NAMED PARAMETERS WITH REQUIRED
//
//  Named parameters let you pass arguments by NAME instead of by position.
//  The 'required' keyword forces the caller to provide the argument.
//
//  Think of it like filling out a form:
//  Each field has a LABEL (the parameter name), and fields marked with a
//  red asterisk (*) are REQUIRED — you can't submit without them.
//
//  Syntax: {required Type paramName}
//
// =============================================================================
// =============================================================================

void sample1NamedRequired() {
  print('');
  print('##############################################');
  print('# SAMPLE 1: Named Params (required)          #');
  print('##############################################');

  // ============================================================
  // 1. BASIC NAMED PARAMETERS WITH REQUIRED
  //    The 'required' keyword means you MUST provide this argument.
  //    If you forget it, Dart gives a compile-time error.
  //    The parameter name appears at the call site, making the
  //    code self-documenting and easy to read.
  // ============================================================
  print('  === Basic named parameters ===');

  final greeting1 = s1Greet(name: 'Luigi', age: 25);
  print('  $greeting1');
  // Output: Hi my name is Luigi and my age is 25!

  final greeting2 = s1Greet(name: 'Mario', age: 30);
  print('  $greeting2');
  // Output: Hi my name is Mario and my age is 30!

  // ============================================================
  // 2. ARGUMENTS CAN BE IN ANY ORDER
  //    Because each argument is labeled, Dart knows which is which
  //    regardless of the order you write them.
  // ============================================================
  print('  === Arguments in any order ===');

  // age first, then name — works perfectly!
  final greeting3 = s1Greet(age: 22, name: 'Peach');
  print('  $greeting3');

  // name first, then age — also works!
  final greeting4 = s1Greet(name: 'Toad', age: 18);
  print('  $greeting4');

  // ============================================================
  // 3. MULTIPLE RETURN TYPES WITH NAMED PARAMS
  //    Named parameters work with any return type.
  // ============================================================
  print('  === Different return types ===');

  String intro = s1Introduce(firstName: 'John', lastName: 'Doe');
  print('  $intro');

  int total = s1AddNumbers(a: 10, b: 20);
  print('  Sum: $total');

  double area = s1CalculateArea(width: 5.5, height: 3.2);
  print('  Area: $area');

  // ============================================================
  // 4. NAMED PARAMS WITH EXPRESSIONS
  //    You can pass variables, calculations, or function calls
  //    as argument values.
  // ============================================================
  print('  === Passing expressions ===');

  int birthYear = 2000;
  int currentYear = 2025;
  final greeting5 = s1Greet(
    name: 'Yoshi',
    age: currentYear - birthYear,
  );
  print('  $greeting5');

  print('');
}

// --- Sample 1: Helper functions ---

String s1Greet({required String name, required int age}) {
  return 'Hi my name is $name and my age is $age!';
}

String s1Introduce({required String firstName, required String lastName}) {
  return 'Hello, I am $firstName $lastName.';
}

int s1AddNumbers({required int a, required int b}) {
  return a + b;
}

double s1CalculateArea({required double width, required double height}) {
  return width * height;
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  NAMED PARAMETERS — OPTIONAL (NULLABLE & DEFAULTS)
//
//  Named parameters can be made OPTIONAL by using nullable types (Type?)
//  or by providing a default value (Type param = defaultValue).
//
//  Think of it like an online profile:
//  Your username is REQUIRED, but your bio and profile picture are OPTIONAL.
//  If you skip the optional fields, they just stay empty (null) or use
//  a sensible default.
//
//  Syntax: {Type? paramName}  or  {Type paramName = defaultValue}
//
// =============================================================================
// =============================================================================

void sample2NamedOptional() {
  print('##############################################');
  print('# SAMPLE 2: Named Params (optional)          #');
  print('##############################################');

  // ============================================================
  // 1. OPTIONAL NAMED PARAMETERS (NULLABLE)
  //    Type? means the parameter is optional and can be null.
  //    You can provide all, some, or none of the arguments.
  // ============================================================
  print('  === Nullable optional parameters ===');

  // Provide both
  print('  ${s2Greet(name: 'Mario', age: 25)}');

  // Provide only name
  print('  ${s2Greet(name: 'Luigi')}');

  // Provide only age
  print('  ${s2Greet(age: 30)}');

  // Provide nothing
  print('  ${s2Greet()}');

  // ============================================================
  // 2. HANDLING NULL GRACEFULLY
  //    Use the ?? operator to provide fallback values.
  //    ?? means: "if left side is null, use the right side."
  // ============================================================
  print('  === Null-safe with ?? operator ===');

  print('  ${s2GreetSafely(name: 'Peach')}');
  print('  ${s2GreetSafely()}');

  // ============================================================
  // 3. MIXING REQUIRED AND OPTIONAL
  //    Some parameters required, some optional — very common
  //    in real-world Dart and Flutter code.
  // ============================================================
  print('  === Mixing required and optional ===');

  print('  ${s2CreateProfile(email: 'mario@mushroom.com')}');
  print('  ${s2CreateProfile(email: 'luigi@mushroom.com', nickname: 'GreenMachine')}');

  // ============================================================
  // 4. DEFAULT VALUES
  //    Instead of nullable, give a default value.
  //    No null, no question mark needed — always a valid value.
  // ============================================================
  print('  === Default values ===');

  print('  ${s2GreetWithDefaults(name: 'Yoshi', age: 25)}');
  print('  ${s2GreetWithDefaults(name: 'Toad')}');
  print('  ${s2GreetWithDefaults()}');

  // Practical example: configuring a button
  s2PrintButtonConfig(label: 'Submit');
  s2PrintButtonConfig(label: 'Cancel', color: 'red', size: 24.0);

  print('');
}

// --- Sample 2: Helper functions ---

String s2Greet({String? name, int? age}) {
  return 'Hi my name is $name and I am $age years old';
}

String s2GreetSafely({String? name, int? age}) {
  String displayName = name ?? 'Anonymous';
  String displayAge = age?.toString() ?? '(age not provided)';
  return 'Hi my name is $displayName and I am $displayAge years old';
}

String s2CreateProfile({required String email, String? nickname}) {
  String displayNickname = nickname ?? '(none)';
  return 'Email: $email | Nickname: $displayNickname';
}

String s2GreetWithDefaults({String name = 'Guest', int age = 0}) {
  return 'Hi my name is $name and I am $age years old';
}

void s2PrintButtonConfig({
  required String label,
  String color = 'blue',
  double size = 16.0,
}) {
  print('  Button: "$label" | Color: $color | Size: $size');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  3:  POSITIONAL ARGUMENTS
//
//  Positional parameters are the traditional way of defining function parameters.
//  Arguments MUST be passed in the EXACT ORDER they are defined.
//
//  Think of it like a phone number:
//  The area code comes FIRST, then the prefix, then the line number.
//  You can't rearrange them — the order IS the meaning.
//
//  Syntax: (Type param1, Type param2)
//
// =============================================================================
// =============================================================================

void sample3Positional() {
  print('##############################################');
  print('# SAMPLE 3: Positional Arguments             #');
  print('##############################################');

  // ============================================================
  // 1. BASIC POSITIONAL PARAMETERS
  //    Arguments are matched by POSITION — first argument goes
  //    to first parameter, second to second, etc.
  // ============================================================
  print('  === Basic positional parameters ===');

  print('  ${s3Greet('Mario', 25)}');
  print('  ${s3Greet('Luigi', 28)}');

  // ============================================================
  // 2. ORDER MATTERS!
  //    Wrong order = compile error (if types differ) or
  //    silent bug (if types happen to match).
  // ============================================================
  print('  === Order matters ===');

  // Correct order
  print('  ${s3BuildFullName('John', 'Doe')}');

  // Swapped — NO error but WRONG result (silent bug!)
  print('  ${s3BuildFullName('Doe', 'John')}');
  print('  ^ "Doe John" is wrong but Dart cannot catch this mistake');
  print('    because both parameters are the same type (String).');

  // ============================================================
  // 3. DIFFERENT PARAMETER COUNTS
  //    Functions can have 0, 1, 2, or many positional parameters.
  // ============================================================
  print('  === Different parameter counts ===');

  s3SayHello(); // 0 params
  print('  Double of 21: ${s3DoubleIt(21)}'); // 1 param
  print('  10 + 20 = ${s3Add(10, 20)}'); // 2 params
  print('  ${s3CreateCard('Yoshi', 'Dinosaur', 'Green', 150)}'); // 3+ params

  // ============================================================
  // 4. OPTIONAL POSITIONAL PARAMETERS
  //    Wrap in square brackets [ ] to make them optional.
  //    Must come AFTER all required params.
  // ============================================================
  print('  === Optional positional parameters ===');

  print('  ${s3Introduce('Mario', 'Plumber', 'Mushroom Kingdom')}');
  print('  ${s3Introduce('Luigi', 'Plumber')}');
  print('  ${s3Introduce('Toad')}');

  // ============================================================
  // 5. OPTIONAL WITH DEFAULT VALUES
  //    Give optional positional params a default value
  //    so they're never null.
  // ============================================================
  print('  === Defaults for optional positional params ===');

  print('  ${s3FormatMessage('Hello', '!!!', 3)}');
  print('  ${s3FormatMessage('Dart is cool', '.')}');
  print('  ${s3FormatMessage('Simple')}');

  print('');
}

// --- Sample 3: Helper functions ---

String s3Greet(String name, int age) {
  return 'Hi my name is $name and I am $age years old';
}

String s3BuildFullName(String firstName, String lastName) {
  return '$firstName $lastName';
}

void s3SayHello() {
  print('  Hello, World!');
}

int s3DoubleIt(int number) {
  return number * 2;
}

int s3Add(int a, int b) {
  return a + b;
}

String s3CreateCard(String name, String species, String color, int weight) {
  return '$name | Species: $species | Color: $color | Weight: ${weight}lb';
}

String s3Introduce(String name, [String? job, String? hometown]) {
  String displayJob = job ?? '(unknown)';
  String displayHometown = hometown ?? '(unknown)';
  return '$name is a $displayJob from $displayHometown';
}

String s3FormatMessage(String text, [String suffix = '', int repeat = 1]) {
  String full = '$text$suffix';
  List<String> parts = [];
  for (int i = 0; i < repeat; i++) {
    parts.add(full);
  }
  return parts.join(' ');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  4:  DYNAMIC FUNCTIONS — No Type Annotations
//
//  When you don't specify types, Dart uses 'dynamic' type by default.
//  The function can accept ANY type and return anything.
//
//  Think of it like a mystery box:
//  You can put ANYTHING in it — a string, a number, a boolean, a list...
//  But when you open it, you don't know what you'll get!
//
//  IMPORTANT: Avoid this in production code! Always prefer typed functions.
//
// =============================================================================
// =============================================================================

void sample4Dynamic() {
  print('##############################################');
  print('# SAMPLE 4: Dynamic Functions (no types)     #');
  print('##############################################');

  // ============================================================
  // 1. FUNCTION WITH NO TYPE ANNOTATIONS
  //    No return type + no param types = everything is dynamic.
  //    Accepts anything, returns anything.
  // ============================================================
  print('  === No type annotations ===');

  // "Intended" use — String and int
  var result1 = s4Greet('Luigi', 25);
  print('  $result1');

  // ============================================================
  // 2. PASSING ANY TYPE — No compile-time checking!
  //    Dart allows ANYTHING because there are no types to check.
  // ============================================================
  print('  === Passing unexpected types ===');

  // int and bool instead of String and int — NO ERROR!
  var result2 = s4Greet(10, true);
  print('  $result2');
  // Output: Hi my name is 10 and I am true years old

  // Two strings
  var result3 = s4Greet('Hello', 'World');
  print('  $result3');

  // A list and a map — still no error!
  var result4 = s4Greet([1, 2, 3], {'key': 'value'});
  print('  $result4');

  // ============================================================
  // 3. WHY DYNAMIC IS DANGEROUS
  //    The + operator behaves differently for different types:
  //    int + int = addition, String + String = concatenation.
  //    With dynamic, you get SILENT BUGS instead of errors.
  // ============================================================
  print('  === Why dynamic is dangerous ===');

  var sum1 = s4AddUnsafe(10, 20);
  print('  s4AddUnsafe(10, 20) = $sum1'); // 30 — correct

  var sum2 = s4AddUnsafe('hello', 'world');
  print('  s4AddUnsafe("hello", "world") = $sum2'); // "helloworld" — BUG!
  print('  ^ We wanted addition, got string concatenation!');

  // ============================================================
  // 4. TYPED VS UNTYPED — Side by side
  //    The typed version catches mistakes at COMPILE TIME.
  //    The untyped version only fails at RUNTIME (or silently bugs).
  // ============================================================
  print('  === Typed vs untyped ===');

  int typedResult = s4AddSafe(10, 20);
  print('  s4AddSafe(10, 20) = $typedResult'); // Safe!

  var untypedResult = s4AddUnsafe(10, 20);
  print('  s4AddUnsafe(10, 20) = $untypedResult'); // Same result, no safety

  // s4AddSafe('hello', 'world'); // COMPILE ERROR — caught before runtime!
  // s4AddUnsafe('hello', 'world'); // No error — silent bug at runtime

  // ============================================================
  // 5. WHEN DYNAMIC IS OK
  //    Rare cases: JSON parsing, truly generic utilities, prototyping.
  // ============================================================
  print('  === Legitimate use of dynamic ===');

  s4PrintInfo('Hello');
  s4PrintInfo(42);
  s4PrintInfo(3.14);
  s4PrintInfo(true);
  s4PrintInfo([1, 2, 3]);

  print('  safeToString(42) = "${s4SafeToString(42)}"');
  print('  safeToString(null) = "${s4SafeToString(null)}"');

  print('');
}

// --- Sample 4: Helper functions ---

// ignore: type_annotate_public_apis
// NO type annotations = everything is dynamic (this is the point of this sample)
// ignore: always_declare_return_types
s4Greet(s4Name, s4Age) {
  return 'Hi my name is $s4Name and I am $s4Age years old';
}

// DANGEROUS: No types means + could be addition OR concatenation
// ignore: always_declare_return_types
s4AddUnsafe(s4A, s4B) {
  return s4A + s4B;
}

// SAFE: Types enforce that only ints are accepted
int s4AddSafe(int a, int b) {
  return a + b;
}

// LEGITIMATE USE: A utility that needs to accept any type
void s4PrintInfo(dynamic value) {
  print('  Value: $value (Type: ${value.runtimeType})');
}

// LEGITIMATE USE: Safe conversion from anything to String
String s4SafeToString(dynamic value) {
  if (value == null) return '(null)';
  return value.toString();
}

// =============================================================================
// =============================================================================
//  NOTES: Functions — Complete Summary of ALL 4 Samples
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | TOPIC                              | KEY CONCEPTS
//  -----------------------------------------------------------------------
//   1  | Named params (required)            | {required Type name}, any order
//   2  | Named params (optional/nullable)   | {Type? name}, defaults, ?? operator
//   3  | Positional arguments               | (Type name), order matters, [optional]
//   4  | Dynamic functions (no types)        | No annotations, dynamic, why to avoid
//  -----------------------------------------------------------------------
//
//  PARAMETER TYPES COMPARISON:
//  ┌───────────────────────────────┬───────────────────────────────────────────┐
//  │  Parameter Style              │  Syntax & Behavior                       │
//  ├───────────────────────────────┼───────────────────────────────────────────┤
//  │  Named + required             │  {required String name}                  │
//  │                               │  Must provide, any order                 │
//  ├───────────────────────────────┼───────────────────────────────────────────┤
//  │  Named + optional (nullable)  │  {String? name}                          │
//  │                               │  Can skip, value is null                 │
//  ├───────────────────────────────┼───────────────────────────────────────────┤
//  │  Named + optional (default)   │  {String name = 'Guest'}                 │
//  │                               │  Can skip, uses default value            │
//  ├───────────────────────────────┼───────────────────────────────────────────┤
//  │  Positional (required)        │  (String name, int age)                  │
//  │                               │  Must provide, order matters             │
//  ├───────────────────────────────┼───────────────────────────────────────────┤
//  │  Positional (optional)        │  (String name, [int? age])               │
//  │                               │  Can skip, value is null or default      │
//  ├───────────────────────────────┼───────────────────────────────────────────┤
//  │  Dynamic (no types)           │  greet(name, age)                        │
//  │                               │  Accepts anything — NOT recommended!     │
//  └───────────────────────────────┴───────────────────────────────────────────┘
//
//  WHEN TO USE EACH:
//  ┌────────────────────────────────────────────────────────────────────────────┐
//  │  Named + required     → Function has 2+ params, all mandatory            │
//  │  Named + optional     → Some params are "nice to have" (e.g., nickname)  │
//  │  Named + defaults     → Sensible default exists (e.g., color = 'blue')   │
//  │  Positional           → 1-2 obvious params (e.g., add(10, 20))           │
//  │  Positional + optional→ Extra params sometimes needed (e.g., formatting) │
//  │  Dynamic              → AVOID! Only for JSON parsing or prototyping      │
//  └────────────────────────────────────────────────────────────────────────────┘
//
//  QUICK DECISION RULE:
//  "How many parameters? Are they the same type?"
//     1 param                    → positional is fine
//     2 params, different types  → positional is OK
//     2 params, same type        → use named (avoid mix-ups!)
//     3+ params                  → almost always use named
//
//  In Flutter, almost EVERYTHING uses named parameters.
//  Get comfortable with them — you'll use them constantly!
//
// =============================================================================
