//import 'package:hello_world/HomePageWeb.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
//static final String apiUrl = 'http://10.0.2.2:3000';   
static final String apiUrl = 'http://localhost:3000';   

static bool isvalid =true;

// static Future<List<Review>> fetchReviews() async {
//   final response = await http.get(Uri.parse('https://your-api-endpoint/reviews'));

//   if (response.statusCode == 200) {
//     List<dynamic> jsonList = json.decode(response.body);
//     return jsonList.map((json) => Review.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load reviews');
//   }
// }

//////// auth ////////
// login 
static Future<Map<String, dynamic>> loginController(String email, String password) async {
print("hello1-------------");
final response = await http.post(
Uri.parse('$apiUrl/auth/login'),
body: json.encode({
'email': email,
'password': password,
}), 
headers: {'Content-Type': 'application/json'},
);
  print("Response status code: ${response.statusCode}");
  print("Response body: ${response.body}");
  
if (response.statusCode == 200) {
return json.decode(response.body); // Login successful.
} else {
throw Exception('Failed to load data'); // Login failed.
}
}

// signup
static Future<Map<String, dynamic>> signupController(String email, String password, String username, String name, String profile_picture_url) async {
  print("hello1-------------");
  final response = await http.post(
    Uri.parse('$apiUrl/auth/signup'),
    body: json.encode({
      'email': email,
      'password': password,
      'username': username,
      'name': name,
      'profile_picture_url': profile_picture_url
    }),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 201) {
    isvalid = true;
    return json.decode(response.body); // signup successful.
  } else {
    isvalid = false;
    throw Exception('Failed to create user: ${response.reasonPhrase}');
  }
}



static Future<Map<String, dynamic>> userDetailsController(int checkpointId) async {
    final response = await http.get(
    Uri.parse('$apiUrl/auth/'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body); // get checkpoint successful.
    }
    else{
      throw Exception('Failed to load data'); // get checkpoint failed.
   }
}

//////// CHECKPOINT ////////
// get a list of all checkpoints.
static Future<List<Map<String, dynamic>>> checkpointsListController() async {
  final response = await http.get(
    Uri.parse('$apiUrl/checkpoint/list'), 
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
      final data = json.decode(response.body)["data"];
      return List<Map<String, dynamic>>.from(data);
    } else if (response.statusCode == 400) {
      return []; // handle error
    } else {
      throw Exception('Failed to load data'); // handle error
    }
}


// get specific checkpoint by checkpoint id pass in url.
static Future<Map<String, dynamic>> checkpointDetailsController(int checkpointId) async {
    final response = await http.get(
    Uri.parse('$apiUrl/checkpoint/details/$checkpointId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body); // get checkpoint successful.
    }
    else{
      throw Exception('Failed to load data'); // get checkpoint failed.
   }
}

// add new checkpoint.
static Future<Map<String, dynamic>> addCheckpointController(String name, double x_postion , double y_postion ) async {
    final response = await http.post(
    Uri.parse('$apiUrl/checkpoint/add'),
    body: json.encode({
    'name': name,
    'x_position': x_postion,
    'y_position' : y_postion,
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
    return json.decode(response.body); // add new checkpoint successful.
    } else {
    throw Exception('Failed to load data'); //  failed.
    }
}

// delete specific checkpoint by checkpoint id pass in url.
static Future<Map<String, dynamic>> deleteCheckpointController(int checkpointId) async {
    final response = await http.delete(
    Uri.parse('$apiUrl/checkpoint/delete/$checkpointId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // delete checkpoint successful.
    }
    else{
      throw Exception('Failed to load data'); // delete checkpoint failed.
   }
}
static Future<Map<String, dynamic>> setFavoriteController(int UserUserId, int CheckpointCheckpointId) async {
    final response = await http.post(
    Uri.parse('$apiUrl/checkpoint/favorite'),
    body: json.encode({
    'UserUserId': UserUserId,
    'CheckpointCheckpointId': CheckpointCheckpointId,
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
    return json.decode(response.body); // set successful.
    } else {
    throw Exception('Failed to load data'); // failed.
    }
}

// get favorite.
static Future<List<Map<String, dynamic>>> getFavoriteController(int userId) async {
    final response = await http.get(
    Uri.parse('$apiUrl/checkpoint/favorite/$userId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body)["data"];
      return List<Map<String, dynamic>>.from(data);
    } else if (response.statusCode == 400) {
      return []; // handle error
    } else {
      throw Exception('Failed to load data'); // handle error
    }
}

//remove from favorite.
static Future<Map<String, dynamic>> removeFavorite(int checkpointId, int userId) async {
  try {
    final response = await http.delete(
      Uri.parse('$apiUrl/checkpoint/favorite/remove/$checkpointId/$userId'), 
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // deletion successful
    } else {
      throw Exception('Failed to remove favorite: ${response.statusCode}');
    }
  } catch (error) {
    // Handle other exceptions like network errors
    print('Error removing favorite: $error');
    throw Exception('Failed to remove favorite');
  }
}

//insert in lookup table.
static Future<Map<String, dynamic>> insertIntoLookupController(String x_sign, String y_sign, int checkpoint_id, String  direction, String direction_statement ) async {
    final response = await http.post(
    Uri.parse('$apiUrl/lookupTable/insert'),
    body: json.encode({
    'checkpoint_id': checkpoint_id,
    'x_sign': x_sign,
    'y_sign' : y_sign,
    "direction": direction,
    "direction_statement":direction_statement,
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
    return json.decode(response.body); // add new checkpoint successful.
    } else {
    throw Exception('Failed to load data'); //  failed.
    }
}
// edit checkpoint info.
static Future<Map<String, dynamic>> editCheckpointController({
  required int checkpointId,
  String? name,
  double? x_position,
  double? y_position,
  String? status_in,
  String? status_out,

}) async {
  try {
    Map<String, dynamic> requestBody = {};
    
    // Check and add fields to the request body if they are provided
    if (name != null) {
      requestBody['name'] = name;
    }
    if (x_position != null) {
      requestBody['x_position'] = x_position;
    }
    if (y_position != null) {
      requestBody['y_position'] = y_position;
    }
    if (status_in != null) {
      requestBody['status_in'] = status_in;
    }
    if (status_out != null) {
      requestBody['status_out'] = status_out;
    }
    
    final response = await http.put(
      Uri.parse('$apiUrl/checkpoint/edit/$checkpointId'),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Edit checkpoint successful.
    } else {
      throw Exception('Failed to load data'); // Failed.
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}


///////REQUEST//////////
// add request(by x,y).
static Future<Map<String, dynamic>> addRequestController(String name, double x_postion , double y_postion ) async {
    final response = await http.post(
    Uri.parse('$apiUrl/request/add'),
    body: json.encode({
    'name': name,
    'x_position': x_postion,
    'y_position' : y_postion,
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
    return json.decode(response.body); // add new request successful.
    } else {
    throw Exception('Failed to load data'); //  failed.
    }
}

// delete request (by checkpoint name).
static Future<Map<String, dynamic>> deleteRequestController(String name) async {
    final response = await http.post(
    Uri.parse('$apiUrl/request/delete'),
    body: json.encode({
    'name': name,
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
    return json.decode(response.body); // add new equest successful.
    } else {
    throw Exception('Failed to load data'); //  failed.
    }
}


// search by checkpoint name.
static Future<Map<String, dynamic>> searchByNmae(String checkpointName) async {
    final response = await http.get(
    Uri.parse('$apiUrl/checkpoint/search/$checkpointName'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body); // get checkpoint successful.
    }
    else{
      throw Exception('Failed to load data'); // get checkpoint failed.
   }
}



//return if specific checkpoint is favorite or not.
static Future<bool> checkFavoriteController(int userId, int checkpointId) async {
  final response = await http.get(
    Uri.parse('$apiUrl/checkpoint/checkFavorite/$userId/$checkpointId'),
    headers: {'Content-Type': 'application/json'},
  );
  
  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    // Assuming the response is a map with a boolean value, adjust this as necessary
    return responseBody['success'] ?? false;
  } else {
    throw Exception('Failed to load data'); // handle error
  }
}

//////// COMMENT ////////
// get all comment for specific checkpoint by checkpoint id pass in url.
static Future<Map<String, dynamic>> allCommentController(int checkpointId) async {
    final response = await http.get(
    Uri.parse('$apiUrl/comment/$checkpointId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // get comments successful
    }
    else if (response.statusCode == 404){
      return json.decode(response.body); // no comments added yet.
    }
    else{
      throw Exception('Failed to load data'); // get comments failed.
   }
}

// add new comment to specific checkpoint by checkpoint id pass in url.
static Future<Map<String, dynamic>> addCommentController(int checkpointId, String commentDescription, String imageUrl, int userId) async {
  try {
    final response = await http.post(
      Uri.parse('$apiUrl/comment/add/toCheckpoint/$checkpointId'),
      body: json.encode({
        'comment_description': commentDescription,
        'image_url': imageUrl,
        'user_id': userId,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 201) {
      return json.decode(response.body); // add new comment successful.
    } else {
      throw Exception('Failed to add comment'); // failed.
    }
  } catch (e) {
    throw Exception('Failed to add comment: $e');
  }
}

// edit comment by comment id pass in url.
static Future<Map<String, dynamic>> editCommentController(int commentId, String comment_description, String imageUrl) async {
    final response = await http.put(
    Uri.parse('$apiUrl/comment/edit/$commentId'),
    body: json.encode({
    'comment_description': comment_description,
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
    return json.decode(response.body); // edit comment successful.
    } else {
    throw Exception('Failed to load data'); //  failed.
    }
}

// delete specific comment by comment id pass in url.
static Future<Map<String, dynamic>> deleteCommentController(int commentId) async {
    final response = await http.delete(
    Uri.parse('$apiUrl/comment/delete/$commentId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // delete comment successful.
    }
    else{
      throw Exception('Failed to load data'); // delete comment failed.
   }
}

//////// LIVE QUESTION ////////
// add live question in specific checkpoint by checkpoint id pass in url.
static Future<Map<String, dynamic>> addLiveQuestionController(int checkpointId, String question_description, int user_id ) async {
    final response = await http.post(
    Uri.parse('$apiUrl/liveQuestion/add/toCheckpoint/$checkpointId'),
    body: json.encode({
    'question_description': question_description,
    'user_id' : user_id,
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
    return json.decode(response.body); // add new question successful.
    } else {
    throw Exception('Failed to load data'); //  failed.
    }
}

// get a list of all live questions for specific checkpoint by checkpoint id pass in url.
static Future<Map<String, dynamic>> questionListController(int checkpointId) async {
    final response = await http.get(
    Uri.parse('$apiUrl/liveQuestion/list/forCheckpoint/$checkpointId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // get question list successful.
    }
    else{
      throw Exception('Failed to load data'); // get question list failed.
   }
}

// edit question by question id pass in url.
static Future<Map<String, dynamic>> editQuestionController(int questionId, String question_description) async {
    final response = await http.put(
    Uri.parse('$apiUrl/liveQuestion/edit/$questionId'),
    body: json.encode({
    'question_description': question_description,
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
    return json.decode(response.body); // edit question successful.
    } else {
    throw Exception('Failed to load data'); //  failed.
    }
}

// delete specific question by question id pass in url.
static Future<Map<String, dynamic>> deleteQuestionController(int questionId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/liveQuestion/delete/$questionId'), 
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // delete question successful.
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception('Failed to delete question: ${errorResponse['message'] ?? 'Unknown error'}');
    }
  }

//////// PATH ////////
// add new path.
static Future<Map<String, dynamic>> addPathQuestionController(String start, String end, int user_id ) async {
    final response = await http.post(
    Uri.parse('$apiUrl/path/add'),
    body: json.encode({
    'start': start,
    'end': end,
    'user_id' : user_id,
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
    return json.decode(response.body); // add new question successful.
    } else {
    throw Exception('Failed to load data'); //  failed.
    }
}

// get same question path by (start, end) pass in url.
static Future<Map<String, dynamic>> samePathController(String start, String end) async {
    final response = await http.get(
    Uri.parse('$apiUrl/path/same/$start/$end'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // get same path list successful.
    }
    else{
      throw Exception('Failed to load data'); // failed.
   }
}

// get all path questions for specific user by user id pass in url.
static Future<Map<String, dynamic>> userPathController(int userId) async {
    final response = await http.get(
    Uri.parse('$apiUrl/path/list/$userId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // get paths list successful.
    }
    else{
      throw Exception('Failed to load data'); // failed.
   }
}

// delete path question by path id pass in url.
static Future<Map<String, dynamic>> deletePathController(int pathId) async {
    final response = await http.delete(
    Uri.parse('$apiUrl/path/delete/$pathId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // delete  successful.
    }
    else{
      throw Exception('Failed to load data'); // delete  failed.
   }
}

// get all path questions.
static Future<Map<String, dynamic>> allPathController() async {
    final response = await http.get(
    Uri.parse('$apiUrl/path/all'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // get paths list successful.
    }
    else if(response.statusCode == 404){
      return json.decode(response.body); // there is no question added yet.
    }
    else{
      throw Exception('Failed to load data'); // failed.
   }
}

//////// REPLAY ////////
// get all replais for specific live question by question id pass in url.
static Future<Map<String, dynamic>> questionReplayListController(int questionId) async {
    final response = await http.get(
    Uri.parse('$apiUrl/replay/forLiveQuestion/$questionId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // get replay list successful.
    }
    else if (response.statusCode == 404) {
      return json.decode(response.body); // no replay added yet.
    }
    else{
      throw Exception('Failed to load data'); // get replay list failed.
   }
}

// get all replais for specific path by path id pass in url.
static Future<Map<String, dynamic>> pathReplayListController(int pathId) async {
    final response = await http.get(
    Uri.parse('$apiUrl/replay/forPath/$pathId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // get replay list successful.
    }
    else if (response.statusCode == 404) {
      return json.decode(response.body); // no replay added yet.
    }
    else{
      throw Exception('Failed to load data'); // get replay list failed.
   }
}

// add new replay to specific live question by question id pass in url.
static Future<Map<String, dynamic>> addQuestionReplayController(int questionId, String replay_description, int user_id  ) async {
    final response = await http.post(
    Uri.parse('$apiUrl/replay/add/toQuestiont/$questionId'),
    body: json.encode({
    'replay_description': replay_description,
    'user_id' : user_id,
    'type' : "liveQuestion"

    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
    return json.decode(response.body); // add new replay successful.
    } else {
    throw Exception('Failed to load data'); //  failed.
    }
}

// add new replay to specific path by path id pass in url.
static Future<Map<String, dynamic>> addPathReplayController(int pathId, String replayDescription, int userId) async {
  print("Adding path replay...");

  try {
    final response = await http.post(
      Uri.parse('$apiUrl/replay/add/toPath/$pathId'),
      body: json.encode({
        'replay_description': replayDescription,
        'user_id': userId,
        'type': "pathQuestion"
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print("Path replay added successfully");
      return json.decode(response.body); // add new replay successful.
    } else {
      print("Failed to add path replay. Status code: ${response.statusCode}");
      throw Exception('Failed to add path replay. Server error: ${response.body}');
    }
  } catch (e) {
    print("Error adding path replay: $e");
    throw Exception('Failed to load data. Error: $e');
  }
}

// edit replay by replay id pass in url.
static Future<Map<String, dynamic>> editReplayController(int replayId, String replay_description) async {
    final response = await http.put(
    Uri.parse('$apiUrl/replay/edit/$replayId'),
    body: json.encode({
    'replay_description': replay_description,
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
    return json.decode(response.body); // edit replay successful.
    } else {
    throw Exception('Failed to load data'); //  failed.
    }
}

// delete replay by replay id pass in url.
static Future<Map<String, dynamic>> deleteReplayController(int replayId) async {
    final response = await http.delete(
    Uri.parse('$apiUrl/replay/delete/$replayId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // delete  successful.
    }
    else{
      throw Exception('Failed to load data'); // delete  failed.
   }
}
///// USER //////
// get specific user by user id pass in url.
static Future<Map<String, dynamic>> getUserController(int userId) async {
    final response = await http.get(
    Uri.parse('$apiUrl/user/$userId'), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // get user successful.
    }
    else{
      throw Exception('Failed to load data'); // get user failed.
   }
}

// edit user information.
static Future<Map<String, dynamic>> editUserController({
  required int userId,
  String? name,
  String? username,
  String? email,
  String? password, 
  String? profile_picture_url,
}) async {
  try {
    Map<String, dynamic> requestBody = {};
    
    // Check and add fields to the request body if they are provided
    if (name != null) {
      requestBody['name'] = name;
    }
    if (username != null) {
      requestBody['username'] = username;
    }
    if (email != null) {
      requestBody['email'] = email;
    }
    if (password != null) {
      requestBody['password'] = password;
    }
    if (profile_picture_url != null) {
      requestBody['profile_picture_url'] = profile_picture_url;
    }

    
    final response = await http.put(
      Uri.parse('$apiUrl/user/edit/$userId'),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Edit user successful.
    } else {
      throw Exception('Failed to load data'); // Failed.
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
////// WAITING TIME //////
// set waiting time (in table waiting time).
static Future<Map<String, dynamic>> setWaitingTime(int checkpoint_id, double duration_time, int user_id, String x_sign, String y_sign ) async {
    final response = await http.post(
    Uri.parse('$apiUrl/waitingTime/set'),
    body: json.encode({
    'duration_time': duration_time,
    'user_id' : user_id,
    'checkpoint_id' : checkpoint_id,
    'x_sign': x_sign,
    'y_sign': y_sign
    }), 
    headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
    return json.decode(response.body); // set successful.
    } else {
    throw Exception('Failed to set data'); //  failed.
    }
}




}
