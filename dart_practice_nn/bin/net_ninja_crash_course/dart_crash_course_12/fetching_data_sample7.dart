//------------------------------------------------------------------------------
// F E T C H I N G   D A T A  —  S A M P L E  7
//------------------------------------------------------------------------------
//
// TOPIC: Query Parameters — Filtering & Searching Data
//
// Query parameters are the ?key=value parts at the end of a URL.
// They tell the server: "Don't give me everything — filter the results."
//
// Examples:
//   /posts?userId=1       → only posts by user 1
//   /comments?postId=1    → only comments on post 1
//   /posts?_limit=5       → only the first 5 posts
//
// Uri.https() has a 3rd argument for query params — a Map<String, String>.
// It automatically adds the ? and & for you.
//
// API: https://jsonplaceholder.typicode.com
//
//------------------------------------------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  // === 1. Filter posts by userId ===
  print('--- 1. Posts by user #1 ---');
  List posts = await fetchPostsByUser(1);
  print('  Found ${posts.length} posts by user #1');
  print('  First: ${posts[0]['title']}');

  print('');

  // === 2. Get comments for a specific post ===
  print('--- 2. Comments on post #1 ---');
  List comments = await fetchCommentsForPost(1);
  print('  Found ${comments.length} comments');
  print('  First comment by: ${comments[0]['email']}');

  print('');

  // === 3. Multiple query params (limit + start) ===
  print('--- 3. Paginated posts (page 2, 3 per page) ---');
  List paged = await fetchPostsPaginated(page: 2, perPage: 3);
  for (var post in paged) {
    print('  Post ${post['id']}: ${post['title']}');
  }
}

// =============================================================================
//  Filter by query parameter
// =============================================================================
//
// Uri.https('host', '/path', {'key': 'value'})
//   → https://host/path?key=value
//
// The 3rd argument is a Map<String, String> (values MUST be strings).
// Uri.https() handles encoding special characters automatically.
//
Future<List> fetchPostsByUser(int userId) async {
  // Builds: https://jsonplaceholder.typicode.com/posts?userId=1
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts', {
    'userId': userId.toString(), // query param values must be String
  });

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed: ${response.statusCode}');
  }

  return convert.jsonDecode(response.body) as List;
}

// =============================================================================
//  Fetch comments for a post
// =============================================================================
//
// Builds: https://jsonplaceholder.typicode.com/comments?postId=1
//
Future<List> fetchCommentsForPost(int postId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/comments', {
    'postId': postId.toString(),
  });

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed: ${response.statusCode}');
  }

  return convert.jsonDecode(response.body) as List;
}

// =============================================================================
//  Pagination with multiple query params
// =============================================================================
//
// _start and _limit are jsonplaceholder's pagination params.
// Builds: https://jsonplaceholder.typicode.com/posts?_start=3&_limit=3
//
// Multiple params are separated by & in the URL.
// Uri.https() adds the & automatically when you pass multiple keys.
//
Future<List> fetchPostsPaginated({required int page, required int perPage}) async {
  int start = (page - 1) * perPage;

  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts', {
    '_start': start.toString(),
    '_limit': perPage.toString(),
  });

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed: ${response.statusCode}');
  }

  return convert.jsonDecode(response.body) as List;
}
