//------------------------------------------------------------------------------
// F E T C H I N G   D A T A  —  S A M P L E  8
//------------------------------------------------------------------------------
//
// TOPIC: Fetching Multiple Resources in Parallel
//
// Often you need data from SEVERAL endpoints at once.
// Example: A profile page needs the user, their posts, AND their albums.
//
// SLOW way: Fetch user → wait → fetch posts → wait → fetch albums → wait
// FAST way: Fetch all 3 at the SAME TIME with Future.wait()
//
// This is just like Sample 4 from dart_crash_course_11 (Futures),
// but now with REAL HTTP calls instead of fake delays.
//
// API: https://jsonplaceholder.typicode.com
//
//------------------------------------------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  int userId = 1;

  // ===  PARALLEL — all at once (FAST) ===
  print('--- Fetching user, posts, and albums in parallel ---');
  Stopwatch sw = Stopwatch()..start();

  // Future.wait() runs all 3 HTTP calls at the SAME TIME
  // and waits for ALL of them to finish.
  var results = await Future.wait([
    fetchUser(userId),
    fetchUserPosts(userId),
    fetchUserAlbums(userId),
  ]);

  sw.stop();

  Map<String, dynamic> user = results[0] as Map<String, dynamic>;
  List posts = results[1] as List;
  List albums = results[2] as List;

  print('  User: ${user['name']} (${user['email']})');
  print('  Posts: ${posts.length} posts');
  print('  Albums: ${albums.length} albums');
  print('  Time: ${sw.elapsed.inMilliseconds}ms');
  print('');
  print('  (All 3 calls ran at the same time — much faster than one by one!)');
}

// =============================================================================
//  Helper functions — each makes one HTTP call
// =============================================================================

Future<Map<String, dynamic>> fetchUser(int userId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/users/$userId');
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch user: ${response.statusCode}');
  }

  return convert.jsonDecode(response.body) as Map<String, dynamic>;
}

Future<List> fetchUserPosts(int userId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts', {
    'userId': userId.toString(),
  });
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch posts: ${response.statusCode}');
  }

  return convert.jsonDecode(response.body) as List;
}

Future<List> fetchUserAlbums(int userId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/albums', {
    'userId': userId.toString(),
  });
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch albums: ${response.statusCode}');
  }

  return convert.jsonDecode(response.body) as List;
}
