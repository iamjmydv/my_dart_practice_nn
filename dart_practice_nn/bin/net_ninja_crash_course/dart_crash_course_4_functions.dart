//==============================================================================
// NAMED PARAMETERS WITH REQUIRED KEYWORD
//==============================================================================
// Named parameters allow you to pass arguments in any order by specifying the
// parameter name. The 'required' keyword makes these parameters mandatory.
//
// Benefits:
// - More readable code when calling functions (you can see what each value is)
// - Arguments can be passed in any order (age: 25, name: 'Luigi' works too)
// - The 'required' keyword ensures you don't forget to pass important values
//
// Syntax: {required Type paramName}
//==============================================================================
void main() {
  // Notice how we explicitly name each argument when calling the function
  // This makes the code self-documenting and easier to understand
  final greeting = greet(name: 'Luigi',age: 25);
  print(greeting);
}

// The curly braces {} around parameters indicate they are named parameters
// 'required' means these parameters MUST be provided when calling the function
String greet({required String name, required int age }) {
  // String interpolation using $ allows us to embed variables in strings
  return 'Hi my name is $name and my age is $age!';
}

//==============================================================================
// NAMED PARAMETERS WITH NULLABLE TYPES (OPTIONAL PARAMETERS)
//==============================================================================
// Named parameters can be made optional by using nullable types (Type?).
// The question mark (?) means the parameter can be null if not provided.
//
// Key differences from 'required':
// - These parameters are OPTIONAL - you can call the function without them
// - If not provided, the value will be null
// - Useful when you want to make some parameters optional
// - The order of arguments doesn't matter: greet(age: 25, name: 'Luigi') works!
//
// Syntax: {Type? paramName}
//==============================================================================
// void main() {
//   // You can provide both parameters
//   final greeting = greet(name: 'Mario',age: 25);
//   print(greeting);
//
//   // Or you can omit one or both (they'll be null)
//   // final greeting2 = greet(name: 'Mario'); // age would be null
//   // final greeting3 = greet(); // both would be null
// }

// String? means this parameter can be null (not provided)
// int? means this parameter can be null (not provided)
// String greet({String? name ,int?  age}) {
//   // If name or age is null, it will print 'null' in the string
//   return 'Hi my name is $name and I am $age years old';
// }

//==============================================================================
// POSITIONAL ARGUMENTS (TRADITIONAL FUNCTION PARAMETERS)
//==============================================================================
// Positional parameters are the traditional way of defining function parameters.
// Arguments must be passed in the EXACT ORDER they are defined.
//
// Key characteristics:
// - All positional parameters are REQUIRED by default
// - Order matters! greet('Mario', 25) works, but greet(25, 'Mario') causes error
// - More concise but less self-documenting than named parameters
// - Good for functions with few parameters where the order is obvious
//
// Syntax: (Type paramName)
//==============================================================================
// void main() {
//   // Arguments MUST be in order: name first, then age
//   final greeting = greet('Mario', 25);
//   print(greeting);
//
//   // This would cause an error because the order is wrong:
//   // final badGreeting = greet(25, 'Mario'); // Error!
// }

// No curly braces means these are positional parameters
// String return type means this function returns a String
// String greet(String name ,int  age) {
//   return 'Hi my name is $name and I am $age years old';
// }

//==============================================================================
// DYNAMIC FUNCTION (NO TYPE ANNOTATIONS)
//==============================================================================
// When you don't specify types, Dart uses 'dynamic' type by default.
// This means the function can accept ANY type of data.
//
// Important notes:
// - NOT RECOMMENDED in production code - loses type safety!
// - Can accept any type: Strings, ints, booleans, objects, etc.
// - No compile-time type checking - errors only appear at runtime
// - Useful for quick prototyping or learning, but avoid in real projects
//
// Why avoid this?
// - Harder to catch bugs during development
// - Less readable - you can't tell what types are expected
// - No IDE autocomplete or helpful suggestions
//==============================================================================
// void main() {
//   // This works even though we're passing an int and bool instead of String!
//   final greeting = greet(10, true);
//   print(greeting); // Output: Hi my name is 10 and I am true years old
//
//   // This also works - any types are accepted
//   // final greeting2 = greet('Luigi', 'twenty-five'); // Works but wrong!
// }

// No return type specified = dynamic return type (can return anything)
// No parameter types = dynamic parameters (can accept anything)
// greet(name,age) {
//   // This works with any type because name and age are dynamic
//   return 'Hi my name is $name and I am $age years old';
// }