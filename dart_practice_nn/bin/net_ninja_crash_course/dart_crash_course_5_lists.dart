void main() {
  // join() - Combines all elements into a single String, separated by the given separator.
  // Useful for converting a list into a readable string format.
  List<int> scores = [80, 83, 85, 90, 95, 100];
  print(scores.join(', ')); // output: 80, 83, 85, 90, 95, 100

  // where() - Filters elements based on a condition and returns a new Iterable.
  // Only elements that satisfy the condition (return true) are included.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // var highScores = scores.where((score) => score >= 90);
  // print(highScores.toList()); // output: [90, 95, 100]

  // map() - Transforms each element and returns a new Iterable with the results.
  // The original list is not modified.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // var doubled = scores.map((score) => score * 2);
  // print(doubled.toList()); // output: [160, 166, 170, 180, 190, 200]

  // forEach() - Executes a function on each element in the list.
  // Similar to a for-in loop but written as a method call.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // scores.forEach((score) => print('Score: $score'));
  // output: Score: 80, Score: 83, Score: 85, Score: 90, Score: 95, Score: 100

  // sort() - Sorts the list in place (modifies the original list).
  // By default, it sorts in ascending order. Use a custom comparator for descending.
  // List<int> scores = [95, 80, 100, 83, 90, 85];
  // scores.sort();
  // print(scores); // output: [80, 83, 85, 90, 95, 100]
  // scores.sort((a, b) => b.compareTo(a));
  // print(scores); // output: [100, 95, 90, 85, 83, 80] (descending)

  // reversed - Returns an Iterable with the elements in reverse order.
  // The original list is not modified. Use .toList() to convert back to a List.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // print(scores.reversed.toList()); // output: [100, 95, 90, 85, 83, 80]

  // sublist() - Returns a new list containing elements from start index to end index.
  // The start index is inclusive, the end index is exclusive.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // print(scores.sublist(1, 4)); // output: [83, 85, 90]
  // print(scores.sublist(3)); // output: [90, 95, 100] (from index 3 to the end)

  // contains() - Checks if a specific value exists in the list.
  // Returns true if found, false otherwise.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // print(scores.contains(90)); // output: true
  // print(scores.contains(50)); // output: false

  // first / last - Returns the first or last element of the list.
  // Throws an error if the list is empty.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // print(scores.first); // output: 80
  // print(scores.last); // output: 100

  // isEmpty / isNotEmpty - Checks whether the list has any elements.
  // Returns true or false accordingly.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // print(scores.isEmpty); // output: false
  // print(scores.isNotEmpty); // output: true

  // insert() - Inserts a value at a specific index position.
  // Existing elements at that index and beyond are shifted to the right.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // scores.insert(2, 84);
  // print(scores); // output: [80, 83, 84, 85, 90, 95, 100]

  // addAll() - Appends multiple values to the end of the list at once.
  // Takes another list (or any Iterable) as the argument.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // scores.addAll([110, 120]);
  // print(scores); // output: [80, 83, 85, 90, 95, 100, 110, 120]

  // indexOf() - Searches the list for a specific value and returns its index position.
  // If the value is not found, it returns -1.
  // List<int> scores = [80, 83, 85, 90, 95, 100];
  // print(scores.indexOf(90)); // output: 3
  // print(scores.indexOf(50)); // output: -1 (not found)

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

  // ============================================================
  // NOTES: List<T> Methods & Properties Used in This File
  // ============================================================
  // - join()          — combine elements into a single string with a separator
  // - where()         — filter elements based on a condition (e.g. scores >= 90)
  // - map()           — transform each element (e.g. double every score)
  // - forEach()       — run a function on each element
  // - sort()          — sort ascending + descending with custom comparator
  // - reversed        — get elements in reverse order
  // - sublist()       — extract a portion of the list by index range
  // - contains()      — check if a value exists in the list
  // - first / last    — get the first or last element
  // - isEmpty / isNotEmpty — check if the list has elements
  // - insert()        — insert a value at a specific index position
  // - addAll()        — add multiple values to the end of the list at once
  // - indexOf()       — search for a value and return its index (-1 if not found)
  // - shuffle()       — randomly rearrange the order of elements
  // - length          — get the total number of elements
  // - remove()        — remove the first occurrence of a specific value
  // - removeAt()      — remove an element at a specific index
  // - add()           — append a new value to the end of the list
  // - Type Safety     — typed lists only accept values of the declared type
  // - Updating        — replace a value at a specific index using bracket notation
  // - Accessing       — use bracket notation with index to get a value
  // - Dynamic List    — using 'var' allows mixed types (List<Object>)
  // ============================================================
}
