void main() {
  // difference() - Returns a new set with elements that are in the first set but not in the second.
  // Useful for finding what's unique to one set compared to another.
  Set<String> names = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  Set<String> villains = {'Bowser', 'Wario'};
  print(names.difference(villains)); // output: {Mario, Luigi, Peach}

  // intersection() - Returns a new set containing only elements that exist in both sets.
  // Useful for finding common elements between two sets.
  // Set<String> names = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  // Set<String> villains = {'Bowser', 'Wario'};
  // print(names.intersection(villains)); // output: {Bowser}

  // union() - Returns a new set combining all elements from both sets.
  // Duplicates are automatically excluded since sets don't allow them.
  // Set<String> names = {'Mario', 'Luigi', 'Peach'};
  // Set<String> villains = {'Bowser', 'Wario'};
  // print(names.union(villains)); // output: {Mario, Luigi, Peach, Bowser, Wario}

  // contains() - Checks if a specific value exists in the set.
  // Returns true if found, false otherwise.
  // Set<String> names = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  // print(names.contains('Luigi')); // output: true
  // print(names.contains('Yoshi')); // output: false

  // length - Returns the total number of elements in the set.
  // Set<String> names = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  // print(names.length); // output: 4

  // remove() - Removes a specific value from the set.
  // Returns true if the value was found and removed, false otherwise.
  // Set<String> names = {'Mario', 'Luigi', 'Peach', 'Bowser'};
  // names.remove('Luigi');
  // print(names); // output: {Mario, Peach, Bowser}

  // add() - Adds a new value to the set.
  // If the value already exists, the set remains unchanged (no duplicates allowed).
  // Set<String> names = {'Mario', 'Luigi', 'Peach'};
  // names.add('Bowser');
  // names.add('Peach');
  // print(names); // output: {Mario, Luigi, Peach, Bowser}

  // No Duplicates - Sets automatically ignore duplicate values.
  // Even if you declare a set with duplicates, only unique values are kept.
  // Set<String> names = {'Mario', 'Luigi', 'Peach', 'Peach', 'Luigi'};
  // print(names); // output: {Mario, Luigi, Peach}

  // Type Safety - A Set<String> only accepts String values.
  // You cannot add a value of a different type to a typed set.
  // Set<String> names = {'Mario', 'Luigi', 'Peach'};
  // names.add(100); // ERROR: The argument type 'int' can't be assigned to the parameter type 'String'

  // Basic Set - Creating and printing a set using Set<T> type annotation.
  // Sets use curly braces {} unlike lists which use square brackets [].
  // Set<String> names = {'Mario', 'Luigi', 'Peach'};
  // print(names); // output: {Mario, Luigi, Peach}

  // Dynamic Set - Using 'var' without a type allows mixed types in the set.
  // Dart infers the type as Set<Object>, so it can hold both int and String values.
  // var names = {'Mario', 'Luigi', 1, 2, 3};
  // print(names); // output: {Mario, Luigi, 1, 2, 3}

  // ============================================================
  // NOTES: Set<T> Methods & Properties Used in This File
  // ============================================================
  // - difference()    — get elements in one set but not in another
  // - intersection()  — get elements common to both sets
  // - union()         — combine all elements from both sets (no duplicates)
  // - contains()      — check if a value exists in the set
  // - length          — get the total number of elements
  // - remove()        — remove a specific value from the set
  // - add()           — add a new value (ignored if it already exists)
  // - No Duplicates   — sets automatically ignore duplicate values
  // - Type Safety     — typed sets only accept values of the declared type
  // - Basic Set       — creating a set using Set<T> with curly braces {}
  // - Dynamic Set     — using 'var' allows mixed types (Set<Object>)
  // ============================================================
}
