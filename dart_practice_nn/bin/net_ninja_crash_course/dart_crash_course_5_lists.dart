void main() {
  // indexOf() - Searches the list for a specific value and returns its index position.
  // If the value is not found, it returns -1.
  List<int> scores = [80, 83, 85, 90, 95, 100];
  print(scores.indexOf(90)); // output: 3

  // shuffle() - Randomly rearranges the order of elements in the list.
  // The list is modified in place (no new list is created).
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // scores.shuffle();
  // print(scores); // output: random order, e.g. [95, 80, 100, 83, 90, 85]

  // length - Returns the total number of elements in the list.
  // Note: length counts starting from 1, unlike index which starts from 0.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // print(scores.length); // output: 6

  // remove() - Removes the first occurrence of a specific value from the list.
  // Returns true if the value was found and removed, false otherwise.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // print(scores.remove(100)); // output: true
  // print(scores); // output: [80, 83, 85, 90, 95]

  // removeAt() - Removes the element at a specific index position.
  // Returns the value that was removed from the list.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // print(scores.removeAt(2)); // output: 85 (the removed value)
  // print(scores); // output: [80, 83, 90, 95, 100]

  // add() - Appends a new value to the end of the list.
  // The value must match the list's type (int in this case).
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // scores.add(150);
  // print(scores); // output: [80, 83, 85, 90, 95, 100, 150]

  // Type Safety - You cannot assign a value of a different type to a typed list.
  // A List<int> only accepts int values, not String or other types.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // scores[0] = "Mario"; // ERROR: A value of type 'String' can't be assigned to a variable of type 'int'
  // print(scores[0]);

  // Updating a value - You can replace a value at a specific index using bracket notation.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // scores[0] = 84;
  // print(scores[0]); // output: 84 (the new value)

  // Accessing elements - Use bracket notation with the index to get a value.
  // List indexes start at 0, so the first element is at index 0.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // print(scores[0]); // output: 80

  // Dynamic List - Using 'var' without a type allows mixed types in the list.
  // Dart infers the type as List<Object>, so it can hold both int and String values.
  // var myList = [1, 2, 3, 4, 5, "Mario", 'Luigi'];
  // for (var element in myList) {
  //   print(element.toString());
  // }
}
