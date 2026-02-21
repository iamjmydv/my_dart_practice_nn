//------------------------------------------------------------------------------
// F U N C T I O N S  —  N A M E D  P A R A M E T E R S  ( R E Q U I R E D )
//------------------------------------------------------------------------------
//
// Named parameters let you pass arguments by NAME instead of by position.
// The 'required' keyword forces the caller to provide the argument.
//
// Think of it like filling out a form:
// Each field has a LABEL (the parameter name), and fields marked with a
// red asterisk (*) are REQUIRED — you can't submit without them.
//
// -----------------------------------------------------------------------
//  #  | WHAT'S COVERED                          | KEY CONCEPT
// -----------------------------------------------------------------------
//  1  | Basic named parameters with required    | {required Type name}
//  2  | Arguments can be in any order            | Order doesn't matter
//  3  | Multiple return types with named params | String, int, double returns
//  4  | Named params with expressions           | Passing computed values
// -----------------------------------------------------------------------
//
// Syntax:  void myFunction({required Type paramName}) { ... }
// Calling: myFunction(paramName: value)
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. BASIC NAMED PARAMETERS WITH REQUIRED
  //    The 'required' keyword means you MUST provide this argument.
  //    If you forget it, Dart gives a compile-time error.
  //    The parameter name appears at the call site, making the
  //    code self-documenting and easy to read.
  // ============================================================
  print('=== Basic named parameters with required ===');

  final greeting = greet(name: 'Luigi', age: 25);
  print(greeting);
  // Output: Hi my name is Luigi and my age is 25!

  final greeting2 = greet(name: 'Mario', age: 30);
  print(greeting2);
  // Output: Hi my name is Mario and my age is 30!

  print('');

  // ============================================================
  // 2. ARGUMENTS CAN BE IN ANY ORDER
  //    Because each argument is labeled, Dart knows which is which
  //    regardless of the order you write them.
  //    Compare with positional args where order is strict!
  // ============================================================
  print('=== Arguments in any order ===');

  // age first, then name — works perfectly!
  final greeting3 = greet(age: 22, name: 'Peach');
  print(greeting3);
  // Output: Hi my name is Peach and my age is 22!

  // name first, then age — also works!
  final greeting4 = greet(name: 'Toad', age: 18);
  print(greeting4);
  // Output: Hi my name is Toad and my age is 18!

  print('');

  // ============================================================
  // 3. MULTIPLE RETURN TYPES WITH NAMED PARAMS
  //    Named parameters work with any return type.
  //    The function signature tells you exactly what goes in
  //    and what comes out.
  // ============================================================
  print('=== Different return types ===');

  // Returns a String
  String intro = introduce(firstName: 'John', lastName: 'Doe');
  print(intro);

  // Returns an int
  int total = addNumbers(a: 10, b: 20);
  print('Sum: $total');

  // Returns a double
  double area = calculateArea(width: 5.5, height: 3.2);
  print('Area: $area');

  print('');

  // ============================================================
  // 4. NAMED PARAMS WITH EXPRESSIONS
  //    You can pass any expression as the argument value —
  //    variables, calculations, function calls, etc.
  // ============================================================
  print('=== Passing expressions ===');

  int birthYear = 2000;
  int currentYear = 2025;

  final greeting5 = greet(
    name: 'Yoshi',
    age: currentYear - birthYear, // expression: 2025 - 2000 = 25
  );
  print(greeting5);
  // Output: Hi my name is Yoshi and my age is 25!

  String fullName = '${'Bowser'} Jr.';
  final greeting6 = greet(name: fullName, age: 8);
  print(greeting6);
  // Output: Hi my name is Bowser Jr. and my age is 8!

  print('');
}

// --- Helper functions ---

// The curly braces {} around parameters indicate they are named parameters.
// 'required' means these parameters MUST be provided when calling the function.
// Without 'required', named parameters are optional by default.
String greet({required String name, required int age}) {
  // String interpolation using $ allows us to embed variables in strings
  return 'Hi my name is $name and my age is $age!';
}

// Named parameters work with any return type
String introduce({required String firstName, required String lastName}) {
  return 'Hello, I am $firstName $lastName.';
}

int addNumbers({required int a, required int b}) {
  return a + b;
}

double calculateArea({required double width, required double height}) {
  return width * height;
}

//------------------------------------------------------------------------------
// NOTES:
//------------------------------------------------------------------------------
//
//  1. Named parameters are wrapped in curly braces { }
//  2. 'required' makes the parameter mandatory (compile-time error if missing)
//  3. Arguments can be passed in ANY order (order doesn't matter)
//  4. Makes code self-documenting: greet(name: 'Luigi', age: 25)
//     is clearer than greet('Luigi', 25)
//  5. Named parameters are especially useful when a function has
//     many parameters — you don't have to remember the order
//  6. You can pass expressions, variables, or literals as argument values
//
//  WHEN TO USE NAMED PARAMETERS WITH REQUIRED:
//  - When the function has 2+ parameters and order isn't obvious
//  - When you want maximum readability at the call site
//  - When ALL parameters are mandatory (no optional ones)
//  - In Flutter widgets — almost everything uses named parameters!
//
//------------------------------------------------------------------------------
