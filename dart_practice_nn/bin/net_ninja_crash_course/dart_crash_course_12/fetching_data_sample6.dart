//------------------------------------------------------------------------------
// F E T C H I N G   D A T A  —  S A M P L E  6
//------------------------------------------------------------------------------
//
// TOPIC: DELETE Request — Removing Data from the Server
//
// DELETE = "Remove this resource from the server"
//
// Think of it like deleting a social media post or removing
// an item from your shopping cart.
//
// API: https://jsonplaceholder.typicode.com/posts/1
//
//------------------------------------------------------------------------------

import 'package:http/http.dart' as http;

void main() async {
  // === 1. Delete a post ===
  print('--- Deleting post #1 ---');
  bool success = await deletePost(1);
  print('  Deleted: $success');

  print('');

  // === 2. Try to delete with error handling ===
  print('--- Deleting with error handling ---');
  try {
    bool result = await deletePost(1);
    if (result) {
      print('  Post deleted successfully!');
    }
  } catch (e) {
    print('  Failed to delete: $e');
  }
}

// =============================================================================
//  DELETE — Remove a resource from the server
// =============================================================================
//
// http.delete() sends a DELETE request to the server.
//
// Key points:
//   - No body needed (you're just saying "delete this")
//   - The URL specifies WHICH resource to delete (/posts/1 = post #1)
//   - Server responds with 200 (OK) or 204 (No Content) on success
//   - The response body is usually empty or contains the deleted resource
//
// DELETE /posts/1 means: "Delete post #1 from the server."
//
Future<bool> deletePost(int postId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/$postId');

  // DELETE request — no body needed, just the URL
  final response = await http.delete(uri);

  // 200 = OK (deleted, response may contain the deleted data)
  // 204 = No Content (deleted, nothing to send back)
  if (response.statusCode == 200 || response.statusCode == 204) {
    return true;
  }

  throw Exception('Failed to delete post #$postId: ${response.statusCode}');
}
