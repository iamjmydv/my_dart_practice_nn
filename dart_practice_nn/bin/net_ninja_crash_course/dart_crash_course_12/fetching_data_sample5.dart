//------------------------------------------------------------------------------
// F E T C H I N G   D A T A  —  S A M P L E  5
//------------------------------------------------------------------------------
//
// TOPIC: PUT & PATCH Requests — Updating Data on the Server
//
// PUT   = "Replace the ENTIRE resource with this new version"
// PATCH = "Update ONLY the fields I'm sending, keep the rest"
//
// Think of editing a profile:
//   PUT   = Rewrite the whole profile from scratch
//   PATCH = Just change the email, leave everything else alone
//
// API: https://jsonplaceholder.typicode.com/posts/1
//
//------------------------------------------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  // === 1. PUT — Replace entire post ===
  print('--- 1. PUT (full replace) ---');
  var putResult = await updatePostWithPut(
    postId: 1,
    title: 'Updated Title',
    body: 'Completely new body content.',
    userId: 1,
  );
  print('  PUT result: $putResult');

  print('');

  // === 2. PATCH — Update only the title ===
  print('--- 2. PATCH (partial update) ---');
  var patchResult = await updatePostWithPatch(
    postId: 1,
    title: 'Only Title Changed',
  );
  print('  PATCH result: $patchResult');
}

// =============================================================================
//  PUT — Replace the entire resource
// =============================================================================
//
// http.put() sends ALL fields. The server replaces the whole resource.
// If you forget a field, it might be set to null or removed!
//
// PUT /posts/1 means: "Replace post #1 with this new data."
//
Future<Map<String, dynamic>> updatePostWithPut({
  required int postId,
  required String title,
  required String body,
  required int userId,
}) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/$postId');

  // Send ALL fields — PUT replaces everything
  final response = await http.put(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: convert.jsonEncode({
      'id': postId,
      'title': title,
      'body': body,
      'userId': userId,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('PUT failed: ${response.statusCode}');
  }

  return convert.jsonDecode(response.body) as Map<String, dynamic>;
}

// =============================================================================
//  PATCH — Update only specific fields
// =============================================================================
//
// http.patch() sends ONLY the fields you want to change.
// The server keeps all other fields as they were.
//
// PATCH /posts/1 with {"title": "New Title"} means:
//   "Change ONLY the title of post #1. Don't touch anything else."
//
Future<Map<String, dynamic>> updatePostWithPatch({
  required int postId,
  required String title,
}) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/$postId');

  // Only send the field we want to change
  final response = await http.patch(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: convert.jsonEncode({
      'title': title,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('PATCH failed: ${response.statusCode}');
  }

  return convert.jsonDecode(response.body) as Map<String, dynamic>;
}
