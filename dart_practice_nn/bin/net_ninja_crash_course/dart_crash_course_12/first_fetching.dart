// 'jsonplaceholder.typicode.com', '/posts/2'

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() async {
  var data = await fetchPost();
  print(data.userId);
  print(data.title);
}

Future<Post> fetchPost() async {
  var uri = Uri.http('jsonplaceholder.typicode.com', '/posts/3');
  final response = await http.get(uri);
  Map<String,dynamic> data = convert.jsonDecode(response.body);

  return Post(userId: data["userId"], title: data["title"]);

}
class Post {
  int userId;
  String title;

  Post({required this.userId, required this.title});
}




// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// void main() async {
//   final post = await fetchPost();
//   print('Title: ${post.title}');
//   print('UserId: ${post.userId}');
// }

// Future<Post> fetchPost() async {
//   var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/1');

//   final response = await http.get(uri, headers: {'Accept': 'application/json'});

//   if (response.statusCode != 200) {
//     throw Exception('Failed to fetch post: ${response.statusCode}');
//   }

//   Map<String, dynamic> data = convert.jsonDecode(response.body);

//   return Post(data["title"], data["userId"]);
// }

// class Post {
//   String title;
//   int userId;

//   Post(this.title, this.userId);
// }
