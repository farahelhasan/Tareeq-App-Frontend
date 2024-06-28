import 'package:flutter/material.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/LiveQuestionsCheckpoints.dart';
import 'package:hello_world/Settings.dart';
import 'package:intl/intl.dart';
import 'package:hello_world/CheckpointsInfo.dart';

class PostCard extends StatefulWidget {
  final int questionId;
  final String name;
  late final String question;
  final List<Comment> comments;
  final bool userIsOwner;

  PostCard({
    required this.questionId,
    required this.name,
    required this.question,
    required this.comments,
    required this.userIsOwner,
  });
  
  

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  TextEditingController replaycontroller = TextEditingController();
  int _replayCounter = 1;
    
  void _addReplays() {
    setState(() async {
      String newComment = replaycontroller.text;
      if (newComment.isNotEmpty) {
        widget.comments.add(
          Comment(
            name: profile.name,
            comment: newComment,
            timestamp: DateTime.now(),
            commentNumber: _replayCounter,
            userId: profile.user_id,
          ),
        );
        ApiService.addQuestionReplayController(widget.questionId, newComment, profile.user_id);
        //send notification
        //first: get the userId (who make the question) from question id.
        int userId = await ApiService.getuserId(widget.questionId);
        print("faraaaaaaaaaaaaaah $userId");
        //second: get the token for user who make the question.
        String token = await ApiService.getToken(userId);
                print("faraaaaaaaaaaaaaah $token");
        //send notification.
        await ApiService.sendNotification(token,  profile.name, newComment);
        Navigator.push(context, MaterialPageRoute(builder: (context) => CheckpointDetailsBody()));
        _replayCounter++;
        replaycontroller.clear();
      }
    });
  }
  
  void _deleteQuestion() {
  print('Question ID: ${widget.questionId}');
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('حذف السؤال'),
        content: Text('هل انت متأكد من حذفك لهذا السؤال؟'),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await ApiService.deleteQuestionController(widget.questionId);
                Navigator.pop(context); 
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CheckpointDetailsBody()),
                );
              } catch (error) {
                Navigator.pop(context); 
                _showErrorDialog(context, 'خطأ في حذف السؤال: $error');
                print('Error deleting question: $error');
              }
            },
            child: Text('حذف'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
            },
            child: Text('الغاء'),
          ),
        ],
      );
    },
  );
}
  
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خطأ'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text('موافق'),
            ),
          ],
        );
      },
    );
  }

  void _editQuestion() {
  String updatedQuestion = widget.question;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('تعديل السؤال'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                updatedQuestion = value; 
              },
              controller: TextEditingController(text: widget.question), 
              decoration: InputDecoration(
                hintText: 'ضع هنا السؤال الجديد',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('الغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              ApiService.editQuestionController(widget.questionId , updatedQuestion);
              Navigator.pop(context); 
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CheckpointDetailsBody()),
              );
            },
            child: Text('حفظ'),
          ),
        ],
      );
    },
  );
}

  void _editReplay(Comment comment) {
  String updatedComment = comment.comment;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('تعديل الرد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                updatedComment = value; 
              },
              controller: TextEditingController(text: comment.comment),
              decoration: InputDecoration(
                hintText: 'ضع هنا الرد الذي تريده',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('الغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              print("hoiooooooooo");
              _editComment(comment.commentNumber, updatedComment);
              Navigator.pop(context);
          
            },
            child: Text('حفظ'),
          ),
        ],
      );
    },
  );
}

  Future<void> _editComment(int replay_id, String updatedComment) async {
  try {
    await ApiService.editReplayController(replay_id, updatedComment);
      setState(() {
        final commentIndex = widget.comments.indexWhere((comment) => comment.commentNumber == replay_id);
        if (commentIndex != -1) {
          widget.comments[commentIndex] = Comment(
            name: widget.comments[commentIndex].name,
            comment: updatedComment,
            timestamp: widget.comments[commentIndex].timestamp,
            commentNumber: widget.comments[commentIndex].commentNumber,
            userId: widget.comments[commentIndex].userId,
          );
          print('Comment updated locally');
          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckpointDetailsBody()));
        } else {
          print('Comment with ID $replay_id not found in local state');
        }
      });

  } catch (e) {
    print('Error editing comment: $e');
  }
}


  void _deleteReplay(Comment comment) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('حذف الرد'),
        content: Text('هل انت متأكد من حذف الرد الخاص بك؟'),
        actions: [
          TextButton(
            onPressed: () {
            
              setState(() {
                widget.comments.remove(comment);
               ApiService.deleteReplayController(comment.commentNumber);             
                });
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (context) => CheckpointDetailsBody()),);
            },
            child: Text('حذف'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('الغاء'),
          ),
        ],
      );
    },
  );
}
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: widget.userIsOwner,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete , color: Colors.indigo[900],),
                            onPressed: () {
                              print("Delete button pressed");
                              _deleteQuestion();
                            },
                          ),

                          IconButton(
                            icon: Icon(Icons.edit , color: Colors.indigo[900],),
                            onPressed: () {
                              print("edit button pressed");
                              _editQuestion();
                            },
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      widget.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 , color: Colors.indigo[900]),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      child: Icon(Icons.person , color: Colors.indigo[900],),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(widget.question , style: TextStyle(color: Colors.indigo[900] , fontSize: 18, fontWeight: FontWeight.bold) ),
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ':التعليقات',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24 , color: Colors.indigo[900]),
                    ),
                  ),
                  SizedBox(height: 5),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.comments.length,
                    itemBuilder: (context, index) {
                      Comment comment = widget.comments[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  '${comment.name}',
                                  style: TextStyle(fontFamily: 'Courier', fontSize: 18, fontWeight: FontWeight.bold , color: Colors.indigo[900]),
                                ),
                              ),
                            ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Visibility(
                                    visible: profile.user_id == comment.userId,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit , color: Colors.indigo[900],),
                                          onPressed: () {
                                            print("Edit button pressed");
                                            _editReplay(comment);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete , color: Colors.indigo[900],),
                                          onPressed: () {
                                            print("Delete button pressed");
                                            _deleteReplay(comment);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4),
                                    Text(
                                      '${isArabic(comment.comment) ? '  ${comment.comment}' : ' ${comment.comment} '}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: const Color.fromARGB(255, 1, 7, 42) , fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${DateFormat('dd/MM/yyyy HH:mm').format(comment.timestamp)}',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
            ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: replaycontroller,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: '....إضافة تعليق',
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addReplays,
                    child: Text('إضافة'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Comment {
  final String name;
  late final String comment; 
  final DateTime timestamp;
  final int commentNumber;
  final int userId;
 
  Comment({
    required this.name,
    required this.comment,
    required this.timestamp,
    required this.commentNumber,
    required this.userId,
  });
}

bool isArabic(String str) {
  final arabicPattern = RegExp(r'[\u0600-\u06FF\u0750-\u077F\uFB50-\uFDFF\uFE70-\uFEFF]');
  return arabicPattern.hasMatch(str);
}