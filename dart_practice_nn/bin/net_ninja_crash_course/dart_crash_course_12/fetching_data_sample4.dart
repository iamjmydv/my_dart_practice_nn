//------------------------------------------------------------------------------
// F E T C H I N G   D A T A  —  S A M P L E  4
//------------------------------------------------------------------------------
//
// TOPIC: POST Request — Sending Data TO the Server
//
// GET = "Give me data"   (read)
// POST = "Here's new data, save it"   (create)
//
// When you submit a form, create an account, or add an item to a cart,
// that's a POST request — you're SENDING data to the server.
//
// We use http.post() and send the data as a JSON string in the body.
//
// API: https://jsonplaceholder.typicode.com/posts  (fake API — simulates saving)
//
//------------------------------------------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  // Create a new post by sending data to the server
  Map<String, dynamic> createdPost = await createPost(
    title: 'My New Post',
    body: 'This is the content of my post.',
    userId: 1,
  );

  print('Post created successfully!');
  print('  ID: ${createdPost['id']}');
  print('  Title: ${createdPost['title']}');
  print('  Body: ${createdPost['body']}');
  print('  UserId: ${createdPost['userId']}');
}

// =============================================================================
//  Create a new post — POST request
// =============================================================================
//
// http.post() sends data TO the server.
//
// Key differences from GET:
//   - We include a BODY (the data we're sending)
//   - We set Content-Type header to 'application/json' so the server
//     knows we're sending JSON (not form data, not XML, etc.)
//   - Server responds with 201 (Created) instead of 200 (OK)
//
// Flow:
//   1. Build the URL
//   2. Create a Map with the data we want to send
//   3. Convert that Map to a JSON string with jsonEncode()
//   4. Send POST request with the JSON string as the body
//   5. Server responds with the created resource (including new ID)
//
Future<Map<String, dynamic>> createPost({
  required String title,
  required String body,
  required int userId,
}) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts');

  // The data we want to send — a regular Dart Map
  Map<String, dynamic> postData = {
    'title': title,
    'body': body,
    'userId': userId,
  };

  // http.post() — notice the extra parameters:
  //   headers: tells the server we're sending JSON
  //   body: the actual data (must be a String, so we jsonEncode the Map)
  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: convert.jsonEncode(postData), // Map → JSON string
  );

  // POST typically returns 201 (Created) on success
  if (response.statusCode != 201) {
    throw Exception('Failed to create post: ${response.statusCode}');
  }

  // The server sends back the created post (with a new ID assigned)
  Map<String, dynamic> createdData =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

  return createdData;
}
