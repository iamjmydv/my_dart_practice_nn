//------------------------------------------------------------------------------
// F U N C T I O N S  —  N A M E D  P A R A M E T E R S  ( O P T I O N A L )
//------------------------------------------------------------------------------
//
// Named parameters can be made OPTIONAL by using nullable types (Type?).
// The question mark (?) means the value can be null if not provided.
//
// Think of it like an online profile:
// Your username is REQUIRED, but your bio and profile picture are OPTIONAL.
// If you skip the optional fields, they just stay empty (null).
//
// -----------------------------------------------------------------------
//  #  | WHAT'S COVERED                          | KEY CONCEPT
// -----------------------------------------------------------------------
//  1  | Optional named params (nullable)        | {Type? paramName}
//  2  | Omitting optional parameters            | Value becomes null
//  3  | Mixing required and optional params     | {required Type a, Type? b}
//  4  | Default values for named parameters     | {Type param = defaultValue}
// -----------------------------------------------------------------------
//
// Syntax:  void myFunction({Type? paramName}) { ... }
// Calling: myFunction(paramName: value)  OR  myFunction()  (skip it!)
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. OPTIONAL NAMED PARAMETERS (NULLABLE)
  //    When you use Type? (with the question mark), the parameter
  //    becomes optional. If the caller doesn't provide it, the
  //    value will be null.
  //
  //    Both name and age are optional here — you can skip either
  //    or both when calling the function.
  // ============================================================
  print('=== Optional named parameters (nullable) ===');

  // Provide both parameters
  String result1 = greet(name: 'Mario', age: 25);
  print(result1);
  // Output: Hi my name is Mario and I am 25 years old

  // Provide only name (age will be null)
  String result2 = greet(name: 'Luigi');
  print(result2);
  // Output: Hi my name is Luigi and I am null years old

  // Provide only age (name will be null)
  String result3 = greet(age: 30);
  print(result3);
  // Output: Hi my name is null and I am 30 years old

  // Provide nothing at all (both will be null)
  String result4 = greet();
  print(result4);
  // Output: Hi my name is null and I am null years old

  print('');

  // ============================================================
  // 2. HANDLING NULL VALUES GRACEFULLY
  //    Instead of printing "null", you can check for null and
  //    provide a fallback. The ?? operator means:
  //    "Use the left value, but if it's null, use the right value."
  // ============================================================
  print('=== Handling null gracefully ===');

  String result5 = greetSafely(name: 'Peach');
  print(result5);
  // Output: Hi my name is Peach and I am (age not provided) years old

  String result6 = greetSafely();
  print(result6);
  // Output: Hi my name is Anonymous and I am (age not provided) years old

  print('');

  // ============================================================
  // 3. MIXING REQUIRED AND OPTIONAL PARAMETERS
  //    You can have some parameters be required and others optional.
  //    This is very common in real apps — some info is mandatory,
  //    some is nice-to-have.
  //
  //    Think of a user registration form:
  //    - Email: REQUIRED (you need it to log in)
  //    - Nickname: OPTIONAL (you can set it later)
  // ============================================================
  print('=== Mixing required and optional ===');

  // Must provide email (required), but nickname is optional
  String profile1 = createProfile(email: 'mario@mushroom.com');
  print(profile1);
  // Output: Email: mario@mushroom.com | Nickname: (none)

  String profile2 = createProfile(
    email: 'luigi@mushroom.com',
    nickname: 'GreenMachine',
  );
  print(profile2);
  // Output: Email: luigi@mushroom.com | Nickname: GreenMachine

  print('');

  // ============================================================
  // 4. DEFAULT VALUES FOR NAMED PARAMETERS
  //    Instead of making a parameter nullable, you can give it
  //    a DEFAULT VALUE. If the caller skips it, the default is used.
  //    No null, no question mark needed!
  //
  //    This is often BETTER than nullable because:
  //    - You always have a valid value (never null)
  //    - No need for null checks in the function body
  // ============================================================
  print('=== Default values ===');

  // Provide both — default is ignored
  String greeting1 = greetWithDefaults(name: 'Yoshi', age: 25);
  print(greeting1);
  // Output: Hi my name is Yoshi and I am 25 years old

  // Skip age — default value (0) is used
  String greeting2 = greetWithDefaults(name: 'Toad');
  print(greeting2);
  // Output: Hi my name is Toad and I am 0 years old

  // Skip both — both defaults are used
  String greeting3 = greetWithDefaults();
  print(greeting3);
  // Output: Hi my name is Guest and I am 0 years old

  // Practical example: configuring a button
  printButtonConfig(label: 'Submit');
  // Uses defaults for color and size
  printButtonConfig(label: 'Cancel', color: 'red', size: 24.0);
  // Overrides all defaults

  print('');
}

// --- Helper functions ---

// Both parameters are optional (nullable)
// If not provided, they will be null
String greet({String? name, int? age}) {
  return 'Hi my name is $name and I am $age years old';
}

// Handles null gracefully with the ?? (null-aware) operator
// ?? means: "if the left side is null, use the right side instead"
String greetSafely({String? name, int? age}) {
  String displayName = name ?? 'Anonymous';
  String displayAge = age?.toString() ?? '(age not provided)';
  return 'Hi my name is $displayName and I am $displayAge years old';
}

// Mix of required and optional parameters
// email is REQUIRED — you must provide it
// nickname is OPTIONAL — skip it if you want
String createProfile({required String email, String? nickname}) {
  String displayNickname = nickname ?? '(none)';
  return 'Email: $email | Nickname: $displayNickname';
}

// Named parameters with DEFAULT VALUES
// If not provided, the default value is used instead of null
String greetWithDefaults({String name = 'Guest', int age = 0}) {
  return 'Hi my name is $name and I am $age years old';
}

// Practical example: UI configuration with sensible defaults
void printButtonConfig({
  required String label,
  String color = 'blue',
  double size = 16.0,
}) {
  print('Button: "$label" | Color: $color | Size: $size');
}

//------------------------------------------------------------------------------
// NOTES:
//------------------------------------------------------------------------------
//
//  1. Type? (with question mark) makes a named parameter optional
//  2. If an optional parameter is not provided, its value is null
//  3. Use the ?? operator to provide fallback values for null
//  4. You can MIX required and optional parameters in the same function
//  5. Default values (param = value) are often better than nullable types
//     because you always have a valid value — no null checks needed
//
//  COMPARISON:
//  ┌──────────────────────────────────┬──────────────────────────────────┐
//  │  Nullable (Type?)                │  Default Value (Type = value)   │
//  ├──────────────────────────────────┼──────────────────────────────────┤
//  │  Value can be null               │  Value is never null            │
//  │  Need null checks (?? or if)     │  No null checks needed          │
//  │  Good when "no value" has meaning│  Good when a sensible default   │
//  │  Example: middleName             │  exists. Example: color = 'blue'│
//  └──────────────────────────────────┴──────────────────────────────────┘
//
//  WHEN TO USE OPTIONAL / DEFAULT PARAMETERS:
//  - Use nullable (Type?) when "no value" is meaningful (e.g., no middle name)
//  - Use defaults when there's a sensible fallback (e.g., color = 'blue')
//  - Flutter uses default values HEAVILY (padding, margin, alignment, etc.)
//
//------------------------------------------------------------------------------
