//------------------------------------------------------------------------------
// F E T C H I N G   D A T A  —  S A M P L E  3
//------------------------------------------------------------------------------
//
// TOPIC: Error Handling for HTTP Requests
//
// Things go wrong when fetching data:
//   - The server might be down (500 error)
//   - The URL might not exist (404 error)
//   - There might be no internet connection
//   - The JSON might be malformed
//
// This sample shows how to handle these cases so your app doesn't crash.
//
//------------------------------------------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  // === 1. Successful request ===
  print('--- 1. Successful request ---');
  try {
    Post post = await fetchPost(1);
    print('  Got post: ${post.title}');
  } catch (e) {
    print('  Error: $e');
  }

  print('');

  // === 2. 404 — Resource not found ===
  print('--- 2. Post not found (404) ---');
  try {
    Post post = await fetchPost(99999);
    print('  Got post: ${post.title}');
  } catch (e) {
    print('  Error: $e');
  }

  print('');

  // === 3. Network error — bad host ===
  print('--- 3. Network error (bad host) ---');
  try {
    Post post = await fetchFromBadHost();
    print('  Got post: ${post.title}');
  } catch (e) {
    // This catches SocketException or ClientException
    print('  Network error: $e');
  }
}

// =============================================================================
//  Fetch with proper error handling
// =============================================================================
//
// Checks:
//   1. Was the HTTP request successful? (status code)
//   2. Can we decode the JSON? (try parsing)
//   3. Does the JSON have the fields we need?
//
Future<Post> fetchPost(int postId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/$postId');

  // http.get() can throw if there's no internet or DNS fails
  final response = await http.get(uri);

  // Check HTTP status — 200 = OK, anything else is a problem
  if (response.statusCode == 404) {
    throw Exception('Post #$postId not found (404)');
  }
  if (response.statusCode != 200) {
    throw Exception('Server error: ${response.statusCode}');
  }

  // Parse JSON — if body isn't valid JSON, jsonDecode throws FormatException
  Map<String, dynamic> data =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

  return Post(data['title'], data['userId']);
}

// =============================================================================
//  Fetch from a bad host — simulates network failure
// =============================================================================
//
// This throws because the host doesn't exist.
// Always wrap HTTP calls in try-catch to handle network errors!
//
Future<Post> fetchFromBadHost() async {
  var uri = Uri.https('this-server-does-not-exist-12345.com', '/data');
  final response = await http.get(uri);
  Map<String, dynamic> data =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
  return Post(data['title'], data['userId']);
}

class Post {
  String title;
  int userId;

  Post(this.title, this.userId);
}
