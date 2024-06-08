import 'package:flutter/material.dart';
import 'package:hello_world/CheckpointList.dart';
import 'package:hello_world/MapPageUser.dart';
import 'package:hello_world/Settings.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        elevation: 0,
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
        title: Align(
        alignment: Alignment.centerRight,
        child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text('حول تطبيق طريق' , style: 
        TextStyle(
        color:Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22
        ),
        textAlign: TextAlign.right,),
        ),
        ),
),
      body: Container(
        color: Colors.indigo[900],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Container(
                 decoration: BoxDecoration(
                   border: Border.all(
                     color: Colors.white,
                     width: 2,
                   ),
                   borderRadius: BorderRadius.circular(10),
                 ),
                 padding: EdgeInsets.all(5),
                 child: Text(
                   ' تطبيق يسمح للمستخدمين بمعرفة مواقع الحواجز على الطرق الفلسطينية وطرح الأسئلة أو إضافة تعليقات عن هذه الحواجز. يمكن للمستخدمين أيضًا الاستفسار عن الطرق التي يسلكونها ومعرفة وضع الحواجز عليها. بالإضافة إلى ذلك، يمكن للمستخدمين إضافة حواجز جديدة إلى التطبيق لمشاركتها مع المجتمع الفلسطيني',
                   style: TextStyle(
                     fontSize: 22,
                     color: Colors.white,
                   ),
                   textAlign: TextAlign.center,
                 ),
               ),
             ),

              SizedBox(height: 20),
           Text(
  ':المطورون',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
),
SizedBox(height: 20),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    DeveloperAvatar(
      imagePath: 'images/alaa.png',
      developerName: 'الاء حسن',
    ),
    SizedBox(width: 20),
    DeveloperAvatar(
      imagePath: 'images/farah.jpg',
      developerName: 'فرح الحسن',
    ),
  ],
),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DeveloperAvatar extends StatelessWidget {
  final String imagePath;
  final String developerName;

  DeveloperAvatar({required this.imagePath, required this.developerName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _showInfoDialog(context, developerName, 'طالبة هندسة حاسوب سنة رابعة');
          },
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
        SizedBox(height: 8),
        Text(
          developerName,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context, String name, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }
}
