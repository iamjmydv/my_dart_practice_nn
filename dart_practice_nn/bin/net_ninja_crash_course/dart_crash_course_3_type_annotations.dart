// TYPE ANNOTATIONS
// Type annotations explicitly declare the data type of a variable
// This provides better code clarity, IDE support, and compile-time error checking
// Dart can also infer types using 'var', but explicit types improve readability

void main() {
  //-------------BASIC TYPE ANNOTATIONS-----------------------------------------
  // Type annotations format: <Type> variableName = value;

    // String: Used for text/character sequences
    // Can use single ('') or double ("") quotes
    String name = 'Mario';
    print(name);

    // int: Used for whole numbers (no decimal points)
    // Range: -2^63 to 2^63 - 1 on 64-bit systems
    int age = 25;
    print(age);

    // bool: Boolean type with only two values: true or false
    // Used for conditional logic and flags
    bool isOpen = true;
    print(isOpen);

    // double: Used for floating-point numbers (numbers with decimals)
    // 64-bit double-precision floating-point numbers
    double averageRating = 8.75;
    print(averageRating);

    // IMPORTANT: Dart does NOT have a char type
    // Unlike languages like C, C++, or Java, single characters are Strings
    // A single character is just a String of length 1
    const String bloodType = 'a';
    print(bloodType);

    //-------------USING CONST---------------------------------------------------
    // const: Compile-time constant - value must be known at compile time
    // - Implicitly final (cannot be reassigned)
    // - Must be initialized at declaration
    // - More memory efficient (creates a single instance)
    // - Use for values that will NEVER change (like mathematical constants, config values)
    const int newAge = 27;
    print(newAge);

    const String newName = "Luigi";
    print(newName);


    //------------USING FINAL---------------------------------------------------
    // final: Runtime constant - value can be determined at runtime
    // - Can only be set once, but doesn't need to be known at compile time
    // - Can be initialized later (but only once)
    // - Use for values that won't change after initialization but depend on runtime data
    final String friendName;
    friendName = 'Princess';  // Initialized after declaration (allowed with final)
    print(friendName);

    // Key difference: const is compile-time, final is runtime
    // Example: const pi = 3.14; (known at compile time)
    //          final currentTime = DateTime.now(); (only known at runtime)

    //---------NULLABLE vs NON-NULLABLE TYPES-----------------------------------
    // Dart has null safety - by default, variables cannot be null
    // Adding '?' after the type makes it nullable

    // int? means this can hold an int value OR null
    int? points;  // Not initialized, defaults to null
    print(points);  // Prints: null

    // Without '?', variables MUST be initialized with a non-null value
    // int score;  // ERROR: Non-nullable variable must be initialized

    // To use nullable values safely, check for null first:
    // if (points != null) { /* safe to use */ }
}