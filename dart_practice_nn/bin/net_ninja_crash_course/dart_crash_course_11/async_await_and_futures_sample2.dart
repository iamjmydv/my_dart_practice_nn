//------------------------------------------------------------------------------
// F U T U R E - A S Y N C - A W A I T
//------------------------------------------------------------------------------

// Futures --> like promises in JavaScript
// it can have uncompleted or completed state.
//------------------------------------------------------------------------------

void main() async {
  final post = await fetchPost();
  print(post.title);
  print(post.userId);
}

//RUNS 3 second before pass the value on .then() function.
Future<Post> fetchPost() {
  final delay = Duration(seconds: 3);
  return Future.delayed(delay, (){
    return Post("My Post", 123);
  });
}

//Act's as Model/DTO
class Post {
  String title;
  int userId;

  Post(this.title, this.userId);
}