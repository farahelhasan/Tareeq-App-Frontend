import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hello_world/HomePageWeb.dart';
import 'package:reviews_slider/reviews_slider.dart';

class FeedbackMain extends StatefulWidget {
  const FeedbackMain({Key? key}) : super(key: key);

  @override
  State<FeedbackMain> createState() => _FeedbackMainState();
}

class _FeedbackMainState extends State<FeedbackMain> {
  List<String> list = ['سيء جداً', 'سيء', 'جيد', 'ممتاز', 'رائع'];
  List<Map<String, dynamic>> feedbackArray = [
    {
      'feedbackcomment':
          'سهل علينا الوصول للمعلومات وكان ممتاز جدا وساعدنا احنا الفلسطينين على الوصول لافضل المعلومات عن الحواجز',
      'feedback': 'رائع',
      'name': 'جنى حسن',
      'icon': Icons.person, // Specify the icon for the user
    },
    {
      'feedbackcomment': 'ممتاز جدا',
      'feedback': 'ممتاز',
      'name': 'هديل الحسن',
      'icon': Icons.person, // Specify the icon for the user
    },
    {
      'feedbackcomment': 'تجربة مذهلة!',
      'feedback': 'رائع',
      'name': 'فرح الحسن',
      'icon': Icons.person, // Specify the icon for the user
    },
  ];

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFFffffff),
     appBar: AppBar(
       leading: IconButton(
  onPressed: () {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => HomePageWeb()),
  );
  },
  icon: Icon(
  Icons.arrow_back_ios_new_rounded,
  size: 30,
  color: Colors.white,
  ),
  ),
     ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: feedbackArray.length,
            itemBuilder: (context, index) {
                String selectedValue = feedbackArray[index]["feedback"];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: kIsWeb ? 600 : 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            color: Colors.indigo[900],
                            height: kIsWeb ? 500 : 300,
                            width: kIsWeb ? 600 : 350,
                            child: Column(
                              children: [
                                Text(
                                  "،،",
                                  style: TextStyle(
                                    fontSize: 60,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "الاسم: ${feedbackArray[index]['name']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "التعليق: ${feedbackArray[index]["feedbackcomment"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15),
                                ReviewSlider(
                                  options: list, 
                                  onChange: (int index) { 
                                    selectedValue = list[index];
                                    selectedValue =  feedbackArray[index]["feedback"];
                                   },
                                ),
                                SizedBox(height: 16.0),
                                Center(
                                  child: Text(
                                    selectedValue,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                
              );
            },
          ),
        ),
      ],
    ),
  );
}
}
