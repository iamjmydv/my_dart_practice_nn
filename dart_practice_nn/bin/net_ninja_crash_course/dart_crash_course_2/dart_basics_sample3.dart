//------------------------------------------------------------------------------
// D A R T  B A S I C S
//------------------------------------------------------------------------------
// SAMPLE 3: STRING INTERPOLATION — Putting Variables Inside Strings
//------------------------------------------------------------------------------
//
// Interpolation means inserting a variable or expression into a string
// using the $ symbol. It's how Dart builds dynamic text.
//
// Think of it like a fill-in-the-blank sentence:
// "Hello, ____!" → "Hello, $name!" → "Hello, Mario!"
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                          | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | $variable — simple variable            | Insert a variable directly
//  2  | ${expression} — expressions            | Insert calculations/properties
//  3  | ${object.property} — object access     | Access fields of an object
//  4  | Concatenation vs interpolation         | Why interpolation is better
// -----------------------------------------------------------------------
//
// QUICK RULE:
//   $variable         → simple variable (no braces needed)
//   ${expression}     → calculation, property access, or logic (braces needed)
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. $variable — Simple Variable Interpolation
  //    Use $ followed by the variable name.
  //    No braces {} needed for simple variables.
  //    Dart automatically converts the value to a string.
  // ============================================================
  print('=== Simple \$variable ===');

  String name = 'John';
  int age = 25;
  double height = 5.9;
  bool isDeveloper = true;

  // $ inserts the variable's value directly into the string
  print('Name: $name'); // Name: John
  print('Age: $age'); // Age: 25
  print('Height: $height ft'); // Height: 5.9 ft
  print('Is developer: $isDeveloper'); // Is developer: true

  // Multiple variables in one string
  print('$name is $age years old and $height ft tall.');
  // John is 25 years old and 5.9 ft tall.

  print('');

  // ============================================================
  // 2. ${expression} — Expression Interpolation
  //    Use ${} when you need to:
  //      - Do a calculation
  //      - Call a method
  //      - Write any expression (more than just a variable name)
  //
  //    Think of ${} as: "evaluate this, then put the result here."
  // ============================================================
  print('=== \${expression} ===');

  // Calculation inside the string
  print('Next year, $name will be ${age + 1} years old.');
  // Next year, John will be 26 years old.

  // Method call inside the string
  print('Name in uppercase: ${name.toUpperCase()}');
  // Name in uppercase: JOHN

  print('Name length: ${name.length} characters');
  // Name length: 4 characters

  // Math expressions
  int width = 10;
  int length = 5;
  print('Area: ${width * length} sq units');
  // Area: 50 sq units

  print('');

  // ============================================================
  // 3. ${object.property} — Accessing Object Properties
  //    When you have an object and want to print its fields,
  //    you MUST use ${} because object.property is an expression.
  //
  //    $person.name would be interpreted as:
  //      "$person" + ".name" (wrong — prints Person instance + ".name")
  //    ${person.name} is:
  //      the value of person's name field (correct!)
  // ============================================================
  print('=== \${object.property} ===');

  Person person = Person('Alice', 30);

  // CORRECT — use ${} for object properties
  print('Name: ${person.name}'); // Name: Alice
  print('Age: ${person.age}'); // Age: 30
  print('${person.name} is ${person.age} years old.');
  // Alice is 30 years old.

  // You can also call methods on objects
  print('Info: ${person.getInfo()}');
  // Info: Alice (age 30)

  print('');

  // ============================================================
  // 4. CONCATENATION vs INTERPOLATION — Why interpolation wins
  //    Concatenation uses + to join strings.
  //    Interpolation uses $ to embed values.
  //    Interpolation is shorter, cleaner, and easier to read.
  // ============================================================
  print('=== Concatenation vs Interpolation ===');

  String firstName = 'Mario';
  String lastName = 'Bros';
  int score = 1000;

  // CONCATENATION — using + (old style, harder to read)
  // Note: you must convert non-strings with .toString()
  // ignore: prefer_interpolation_to_compose_strings
  String msg1 = 'Player: ' + firstName + ' ' + lastName + ' | Score: ' + score.toString();
  print(msg1); // Player: Mario Bros | Score: 1000

  // INTERPOLATION — using $ (modern, cleaner)
  // No need for .toString() — Dart handles it automatically
  String msg2 = 'Player: $firstName $lastName | Score: $score';
  print(msg2); // Player: Mario Bros | Score: 1000

  // Both produce the same output, but interpolation is:
  //   - Shorter to write
  //   - Easier to read
  //   - No manual .toString() needed
  //   - Less error-prone (no missing + or spaces)

  print('');
  print('--- Summary ---');
  print('\$variable         → simple variable (e.g., \$name)');
  print('\${expression}     → calculation or method (e.g., \${age + 1})');
  print('\${object.property} → object field (e.g., \${person.name})');
}

// --- Sample 3: Helper class ---

class Person {
  String name;
  int age;

  Person(this.name, this.age);

  String getInfo() {
    return '$name (age $age)';
  }
}

// ============================================================
// NOTES: String Interpolation Summary
// ============================================================
//  1. $variable         → insert a simple variable's value
//  2. ${expression}     → insert the result of an expression
//  3. ${object.property} → access a field of an object
//  4. ${method()}       → call a method and insert its return value
//
//  WHEN TO USE BRACES {}:
//    - Accessing a property:    ${person.name}
//    - Doing a calculation:     ${age + 1}
//    - Calling a method:        ${name.toUpperCase()}
//    - Using a ternary:         ${isTrue ? 'yes' : 'no'}
//
//  WHEN BRACES ARE OPTIONAL:
//    - Simple variable:         $name  (same as ${name})
//
//  TIP: When in doubt, use ${} — it always works.
//       $variable is just a shortcut for ${variable}.
// ============================================================
