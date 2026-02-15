// const is decided before the app starts. (COMPILE TIME)
// final is decided once while the app is running. (RUNTIME)

// COMPILE TIME vs RUNTIME
//Compile time → When Dart checks and prepares your code before the app starts running.
//Runtime → When your app is actually running and doing things.

void main() {
  // ------------- C O M P I L E - T I M E ----- ( C O N S T - U S A G E ) -----
  //Const is used since before RUNTIME/RUN_THE_APP the value is determined.
  const int age = 25;
  print(age);

  // `const` is used because the value is known at compile time.
  // The value is determined before the program runs and cannot change.
  const bool isAging = true;
  print('Does the user is aging? : $isAging');

  //============================================================================
  // ------------- R U N T I M E ----- ( F I N A L - U S A G E ) --------------
  // `final` is used because the value is assigned at runtime.
  // The variable can only be set once, but the value does not need to be known at compile time.
  final DateTime currentTime = DateTime.now();
  print(currentTime);

  final String name;
  name = 'Mario';
  print(name);
}


/*

Interpolation in Dart
Interpolation means putting a variable inside a string using $.

✅ Without braces {}
Use this when inserting a single simple variable:

String name = "John";
print("Hello $name");
✔ Use $variableName

✅ With braces {}
Use this when:
	• Writing an expression
	• Accessing a property
	• Doing calculation

int age = 20;
print("Next year you will be ${age + 1}");
✔ Use ${expression}

🎯 Simple Rule
	• $variable → simple variable
	• ${something more complex} → calculation or expression

here’s a simple example of accessing an object property using interpolation with braces.


Example: Accessing Object Property

class Person {
  String name;
  int age;

Person(this.name, this.age);
}

void main() {
  Person person = Person("John", 25);

print("Name: ${person.name}");
  print("Age: ${person.age}");
}



Why we use {} here?
We use ${} because:
	• person.name is not just a simple variable
	• It is accessing a property of an object
	• That makes it an expression


Simple Rule Reminder
	• $variable → simple variable
	• ${object.property} → accessing property
	• ${expression} → calculations or logic


*/