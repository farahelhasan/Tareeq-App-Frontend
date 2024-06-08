import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LiveQuestions(),
  ));
}

class LiveQuestions extends StatefulWidget {
  @override
  _LiveQuestionsState createState() => _LiveQuestionsState();
}

class _LiveQuestionsState extends State<LiveQuestions> {
  TextEditingController _questionController = TextEditingController();
  List<PostCard> _questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('انشاء سؤال', style: TextStyle(fontSize: 20)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 254, 254, 254),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('اطرح سؤالك'),
                      content: TextFormField(
                        controller: _questionController,
                        maxLines: 5,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'اسأل عن الطريق التي تريد',
                          hintStyle: TextStyle(fontSize: 20),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              String questionText = _questionController.text;
                              if (questionText.isNotEmpty) {
                                _questions.add(
                                  PostCard(
                                    userName: 'Alaa Hasan',
                                    question: questionText,
                                    comments: [],
                                  ),
                                );
                              }
                              _questionController.clear();
                              Navigator.of(context).pop();
                            });
                          },
                          child:  Text(
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
              },
              child:
              Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  for (var question in _questions) question,
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final String userName;
  final String question;
  final List<String> comments;

  PostCard({required this.userName, required this.question, required this.comments});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  TextEditingController _commentController = TextEditingController();

  void _addComment() {
    setState(() {
      String newComment = _commentController.text;
      if (newComment.isNotEmpty) {
        widget.comments.add(newComment);
        _commentController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 10),
                Text(
                  widget.userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.question),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.comments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(widget.comments[index]),
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
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: '....اضافة تعليق',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addComment,
                  child: Text('اضافة'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
