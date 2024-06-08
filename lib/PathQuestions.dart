import 'package:flutter/material.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/CheckpointList.dart';
import 'package:hello_world/MapPageUser.dart';
import 'package:hello_world/PostCardPath.dart';
import 'package:hello_world/Settings.dart';

void main() {
  runApp(MaterialApp(
    title: 'Live Questions',
    home: LiveQuestions(),
  ));
}

class LiveQuestions extends StatefulWidget {
  @override
  _LiveQuestionsState createState() => _LiveQuestionsState();
}

class _LiveQuestionsState extends State<LiveQuestions> {
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  List<PostCard> _path = [];

  @override
  void initState() {
    super.initState();
    _initializeQuestions();
  }

  Future<void> _initializeQuestions() async {
    
    try {
      Map<String, dynamic>? allPathData = await ApiService.allPathController();
      if (allPathData['data'] != null) {
        List<PostCard> allPathDataList = [];
        for (var allPathDataItem in allPathData['data']) {
          List<Comment> comments = [];
          Map<String, dynamic> pathReplayListData = await ApiService.pathReplayListController(allPathDataItem['path_id']);
          if (pathReplayListData['data'] != null) {
            for (var reply in pathReplayListData['data']) {
              String name = await _getUserName(reply['user_id']);
              //bool isCurrentUser = Profile.user_id == postCard.user_id;
              comments.add(
             Comment(
                name: name,
                comment: reply['replay_description'] ?? '',
                timestamp: DateTime.parse(reply['updatedAt'] ?? ''),
                commentNumber: reply['replay_id'] ?? '',
                userId: reply['user_id'] != null ? reply['user_id'] as int : 0,
              ),
              );
            }
          }
          bool isCurrentUser = profile.user_id == allPathDataItem['user_id'];
          String pathOwner = await _getUserName(allPathDataItem['user_id']);
          allPathDataList.add(
            PostCard(
              pathId: allPathDataItem['path_id'],
              name: pathOwner,
              pathquestion: ' من ${allPathDataItem['start']} إلى ${allPathDataItem['end']}',
              comments: comments.toList(),
              userIsOwner: isCurrentUser,
            ),
          );
        }
        setState(() {
          _path = allPathDataList;
      });
    }
    } catch (e) {
      print("Error in fetching questions: $e");
    }
  }

  Future<String> _getUserName(int userId) async {
    try {
      Map<String, dynamic> nameData = await ApiService.getUserController(userId);
      if (nameData['data'] != null) {
        return nameData['data']['name'];
      }
    } catch (e) {
      print("Error fetching username for user ID $userId: $e");
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'إنشاء سؤال',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.question_answer_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
          leading: IconButton(
  onPressed: () {
  if (profile.isadmin){
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => MyHomePage()),
  );
    }else{
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => MyMapAppUser()),
  );
    }
  },
  icon: Icon(
  Icons.arrow_back_ios_new_rounded,
  size: 30,
  color: Colors.white,
  ),

  ),
      ),
    
      body: Stack(   
        children: [
          ListView.builder(
            itemCount: _path.length,
            itemBuilder: (context, index) {
              return _path[index];
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Color.fromARGB(255, 40, 43, 152),
                  width: 2,
                ),
                color: Colors.white,
              ),
              child: ElevatedButton(
                onPressed: _showQuestionDialog,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Icon(Icons.add, size: 30, color: Colors.indigo[900]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showQuestionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromRGBO(26, 35, 126, 1),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.indigo[900],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(width: 20),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  'اطرح سؤالك',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.question_answer_sharp,
                  color: Colors.indigo[900],
                ),
              )
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _fromController,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 40, 43, 152),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'من',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.indigo[900]),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _toController,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 40, 43, 152),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'إلى',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.indigo[900]),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
            int pathId = Pathinfo.path_id;
            int userId = Pathinfo.user_id;
            bool isCurrentUser = profile.user_id == userId; 
            _postQuestion(pathId, userId, isCurrentUser);
            Navigator.pop(context);
          },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Color.fromARGB(255, 40, 43, 152)),
                ),
              ),
              child: Text(
                'نشر',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

void _postQuestion(int pathId, int userId, bool isCurrentUser) {
  String from = _fromController.text;
  String to = _toController.text;
  if (from.isNotEmpty && to.isNotEmpty) {
    setState(() {
      _path.add(
        PostCard(
          pathId: pathId,
          name: profile.name,
          pathquestion: 'من $from إلى $to',
          comments: [],
          userIsOwner: isCurrentUser,
        ),
      );
    });
    ApiService.addPathQuestionController(from, to, profile.user_id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => LiveQuestions()));
  }
  _fromController.clear();
  _toController.clear();
}

}

class Pathinfo {
  static int path_id = 0;
  static String start = '';
  static String end = '';
  static int user_id = 0;
  static String updatedAt = '';
  static String startedat = '';
  static String username = '';
}
