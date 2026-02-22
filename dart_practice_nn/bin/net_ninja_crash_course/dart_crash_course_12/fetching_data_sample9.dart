//------------------------------------------------------------------------------
// F E T C H I N G   D A T A  —  S A M P L E  9
//------------------------------------------------------------------------------
//
// TOPIC: fromJson / toJson — The Proper Model Pattern
//
// In samples 1-8 we manually pulled fields from Maps like:
//   Post(data['title'], data['userId'])
//
// That works, but in real apps you use factory constructors:
//   Post.fromJson(data)    → JSON Map → Dart object
//   post.toJson()          → Dart object → JSON Map
//
// Why?
//   - Keeps parsing logic INSIDE the class (not scattered everywhere)
//   - Easy to reuse — call Post.fromJson() anywhere
//   - Easy to test — one place to check for bugs
//   - Standard pattern in Flutter/Dart projects
//
// API: https://jsonplaceholder.typicode.com/users/1
//
//------------------------------------------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  // === 1. Fetch a user and parse with fromJson ===
  print('--- 1. fromJson — Parse API data into a User object ---');
  User user = await fetchUser(1);
  print('  Name: ${user.name}');
  print('  Email: ${user.email}');
  print('  Phone: ${user.phone}');

  print('');

  // === 2. Convert back to JSON with toJson ===
  print('--- 2. toJson — Convert User object back to a Map ---');
  Map<String, dynamic> json = user.toJson();
  print('  JSON: $json');

  print('');

  // === 3. Encode to JSON string (for sending to server) ===
  print('--- 3. jsonEncode — Convert to JSON string ---');
  String jsonString = convert.jsonEncode(user.toJson());
  print('  String: $jsonString');
}

// =============================================================================
//  Fetch user using fromJson
// =============================================================================

Future<User> fetchUser(int userId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/users/$userId');
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed: ${response.statusCode}');
  }

  Map<String, dynamic> data =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

  // Instead of manually pulling fields, use the factory constructor
  return User.fromJson(data);
}

// =============================================================================
//  User class with fromJson & toJson
// =============================================================================
//
// factory User.fromJson(Map)
//   - A factory constructor that takes a Map and returns a User.
//   - "factory" means it doesn't always create a new instance —
//     it can return an existing one or do work before creating one.
//   - Here it just parses the Map and calls the regular constructor.
//
// Map<String, dynamic> toJson()
//   - Converts the User back into a Map (the reverse of fromJson).
//   - Useful for sending data to the server (jsonEncode needs a Map).
//
// Together:
//   JSON string → jsonDecode → Map → fromJson → User object
//   User object → toJson → Map → jsonEncode → JSON string
//

class User {
  int id;
  String name;
  String email;
  String phone;

  // Regular constructor
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  // Factory constructor: Map → User
  // Reads specific keys from the JSON Map and passes them to the constructor.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  // Convert back: User → Map
  // This Map can be passed to jsonEncode() to get a JSON string.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
