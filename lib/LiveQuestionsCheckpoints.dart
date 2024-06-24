import 'package:flutter/material.dart';
import 'package:hello_world/MapPage.dart';
import 'PostCardState.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/GetChekpoints.dart';
//import 'package:hello_world/MapPageUser.dart';

void main() {
  runApp(MaterialApp(
    title: 'Live Questions',
    home: LiveQuestionsCheckpoints(),
  ));
}

class LiveQuestionsCheckpoints extends StatefulWidget {
  @override
  _LiveQuestionsCheckpointsState createState() => _LiveQuestionsCheckpointsState();
}

class _LiveQuestionsCheckpointsState extends State<LiveQuestionsCheckpoints> {
  TextEditingController _questionController = TextEditingController();
  List<PostCard> _questions = [];

  @override
  void initState() {
    super.initState();
    _initializeQuestions();
  }

  Future<void> _initializeQuestions() async {
    try {
      Map<String, dynamic>? questionListData = await ApiService.questionListController(checkpointinfo.checkpointid);
      if (questionListData['data'] != null) {
        List<PostCard> questionData = [];
        for (var questionDataItem in questionListData['data']) {
          Map<String, dynamic> questionReplayListData = await ApiService.questionReplayListController(questionDataItem['question_id']);
          List<Comment> comments = [];
          if (questionReplayListData['data'] != null) {
            for (var reply in questionReplayListData['data']) {
              Map<String, dynamic> userNameData = await ApiService.getUserController(reply['user_id']);
              if (userNameData['data'] != null && userNameData['data'] is Map<String, dynamic>) {
                var userData = userNameData['data'];
                profileinfo.name = userData['name'];
                comments.add(Comment(
                  name: profileinfo.name,
                  comment: reply['replay_description'],
                  timestamp: DateTime.parse(reply['updatedAt']),
                  commentNumber: reply['replay_id'],
                  userId: reply['user_id'],
                ));
              }
            }
          }
          Map<String, dynamic> NameData = await ApiService.getUserController(questionDataItem['user_id']);
          if (NameData['data'] != null && NameData['data'] is Map<String, dynamic>) {
            var userData = NameData['data'];
            profileinfo.name = userData['name'];
          }
          bool isCurrentUser = profileinfo.user_id == questionDataItem['user_id'];
          questionData.add(PostCard(
            name: profileinfo.name,
            question: questionDataItem['question_description'],
            comments: comments,
            questionId: questionDataItem['question_id'],
            userIsOwner: isCurrentUser,
          ));
        }
        setState(() {
          _questions = questionData;
        });
      } else {
        print('No data found');
      }
    } catch (e) {
      print("Error in questionListData: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _questions.length,
            itemBuilder: (context, index) {
              return _questions[index];
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              height: 40,
              width: 80,
              color: Color.fromARGB(255, 40, 43, 152),
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
                padding: EdgeInsets.only(left: 50),
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
                padding: const EdgeInsets.all(2.0),
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
                  controller: _questionController,
                  maxLines: 5,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 40, 43, 152)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'اسأل عن حالة الحاجز',
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
                 Navigator.of(context).pop();
                _postQuestion();
                
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

void _postQuestion() async {
  String questionText = _questionController.text;
  if (questionText.isNotEmpty) {
    try {
      int questionId = DateTime.now().millisecondsSinceEpoch.toInt();
      setState(() {
        _questions.add(PostCard(
          name: profileinfo.username,
          question: questionText,
          comments: [],
          questionId: questionId,
          userIsOwner: true,
        ));
      });
      _questionController.clear();
      ApiService.addLiveQuestionController(checkpointinfo.checkpointid, questionText, profileinfo.user_id);
      await _initializeQuestions();

    } catch (e) {
      print('Error posting question: $e');
    }
  }
}
}
