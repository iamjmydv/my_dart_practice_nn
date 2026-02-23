import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async{
  fetchData();
}

Future<void> fetchData() async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/2');
 final response = await http.get(uri, headers: {'Accept': 'application/json'});
  try {
   
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['userId']);
      print(data['title']);
      print(data['body']);
    }

  } catch (e) {
    print('Invalid get response with status code ${response.statusCode}');
  }
}