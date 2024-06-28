import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/CheckpointsInfo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/Settings.dart';
import 'package:hello_world/GetChekpoints.dart';
import 'package:hello_world/cloud_api.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Comments(),
  ));
}

class Comments extends StatefulWidget {
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController _commentController = TextEditingController();
  String _comment = '';
  File? _image;
  Uint8List? _imageBytes;
  late String _imageName;
  List<Map<String, dynamic>> _commentsList = [];
  late Future<CloudApi> _apiFuture;

  @override
  void initState() {
    super.initState();
    _apiFuture = _initializeApi();
    _initializeComments();
  }

  Future<CloudApi> _initializeApi() async {
    final json = await rootBundle.loadString('assets/credentials.json');
    return CloudApi(json);
  }

  Future<void> _initializeComments() async {
    try {
      Map<String, dynamic>? commentListData = await ApiService.allCommentController(checkpointinfo.checkpointid);
      if (commentListData['data'] != null) {
        List<Map<String, dynamic>> fetchedComments = [];
        for (var commentDataItem in commentListData['data']) {
          int userId = commentDataItem['user_id'];
          String name = await _getUserName(userId);
          int comment_id = commentDataItem['comment_id'];
          fetchedComments.add({
            'commentId': comment_id,
            'comment': commentDataItem['comment_description'],
            'image': commentDataItem['image_url'],
            'user_id': userId,
            'name': name,
          });
        }
        setState(() {
          _commentsList = fetchedComments;
        });
      } else {
        print('No comments found');
      }
    } catch (e) {
      print("Error fetching comments: $e");
    }
  }
  Future<String> _getUserName(int userId) async {
    try {
      Map<String, dynamic> userData = await ApiService.getUserController(userId);
      if (userData['data'] != null && userData['data'] is Map<String, dynamic>) {
        var name = userData['data'];
        return name['name'] ?? 'Unknown User';
        
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return 'Unknown User';
  }

  Future<void> _addComment(int checkpointId, String commentDescription, File? image, int userId) async {
          print("farah before");

    try {
      String imageUrl = '';
      if (image != null && _imageBytes != null) {
        final api = await _apiFuture;
        final response = await api.save(_imageName, _imageBytes!);
        print('responssssss $response');
        imageUrl = await response.downloadLink.toString();
                print('responssssss $imageUrl');

      }
      print('farah after $imageUrl');

      await ApiService.addCommentController(checkpointId, commentDescription, imageUrl, userId);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckpointDetailsBody()));
    } catch (e) {
      print("Error adding comment: $e");
    }
  }

  Future<void> _editComment(int commentId, String updatedComment, File? updatedImage) async {
    try {
      String imageUrl = '';
      if (updatedImage != null && _imageBytes != null) {
        final api = await _apiFuture;
        
        final response = await api.save(_imageName, _imageBytes!);
        imageUrl = response.downloadLink as String;
      }
      await ApiService.editCommentController(commentId, updatedComment, imageUrl);

    } catch (e) {
      print("Error editing comment: $e");
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckpointDetailsBody()));

  }

  Future<void> _deleteComment(int commentId) async {
    try {
      print(commentId);
      await ApiService.deleteCommentController(commentId);
    } catch (e) {
      print("Error deleting comment: $e");
    }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckpointDetailsBody()));

  }

  Future<void> _getImage() async {
    print("farah get before");

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imageBytes = _image?.readAsBytesSync();
        _imageName = _image!.path.split('/').last;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckpointDetailsBody()));
      });
                print("farah get inside get $_imageName hhh $_imageBytes hhh--------------- $_image");

    }
              print("farah get after");
              return;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _commentsList.length,
              itemBuilder: (context, index) {
                int? commentId = _commentsList[index]['commentId'];
                int userId = _commentsList[index]['user_id'];
                String userName = _commentsList[index]['name'];
                String comment = _commentsList[index]['comment'] ?? '';
                String? imageUrl = _commentsList[index]['image'];

                bool isCurrentUser = userId == profile.user_id;
                var id = profile.user_id;
                print("comment $id");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                userName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              if (isCurrentUser)
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _showEditCommentDialog(commentId, comment, imageUrl);
                                  },
                                ),
                              if (isCurrentUser)
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _showDeleteCommentDialog(commentId);
                                  },
                                ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(comment),
                          if (imageUrl != null && imageUrl.isNotEmpty)
                            Image.network(
                              imageUrl,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'اضافة تعليق',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.indigo[900]),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    _getImage();
                  },
                ),
           IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              print("on press");
              _comment = _commentController.text;
              _commentController.clear();
              int userId = profile.user_id;
              String userName = await _getUserName(userId);
              File? imageToAdd = _image;
              String imageUrl = '';

              if (imageToAdd != null && _imageBytes != null) {
                final api = await _apiFuture;
                final response = await api.save(_imageName, _imageBytes!);
                imageUrl = response.downloadLink.toString(); // Ensure downloadLink is a string
                print("image URL: $imageUrl");
              }

              setState(() {
                _commentsList.add({
                  'comment': _comment,
                  'image': imageUrl,
                  'user_id': userId,
                  'name': userName,
                });
                _image = null;
              });
              print("before call add");
              await _addComment(checkpointinfo.checkpointid, _comment, imageToAdd, userId);
            

            },
          )



              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditCommentDialog(int? commentId, String oldComment, String? oldImageUrl) async {
    String updatedComment = oldComment;
    File? updatedImage = oldImageUrl != null ? File(oldImageUrl) : null;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تعديل التعليق'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => updatedComment = value,
              controller: TextEditingController()..text = oldComment,
              decoration: InputDecoration(
                hintText: 'تعديل التعليق الخاص بك',
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: updatedImage != null ? 'الصورة' : ''),
                    decoration: InputDecoration(
                      hintText: 'لم يتم اختيار صورة',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () async {
                    await _getImage();
                    setState(() {
                      updatedImage = _image;
                    });
                  },
                ),
              ],
            ),
            if (updatedImage == null)
              Text('لم يتم اختيار صورة'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('الغاء'),
          ),
          TextButton(
            onPressed: () async {
              await _editComment(commentId!, updatedComment, updatedImage);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckpointDetailsBody()));
              Navigator.of(context).pop();
            },
            child: Text('حفظ'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteCommentDialog(int? commentId) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('حذف التعليق؟'),
        content: Text('هل انت متأكد'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('الغاء'),
          ),
          TextButton(
            onPressed: () async {
              await _deleteComment(commentId!);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckpointDetailsBody()));
              Navigator.of(context).pop();
            },
            child: Text(
              'حذف',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
