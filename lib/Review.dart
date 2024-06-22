import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hello_world/ApiService.dart'; // Replace with your ApiService import

class FeedbackMain extends StatefulWidget {
  const FeedbackMain({Key? key}) : super(key: key);

  @override
  State<FeedbackMain> createState() => _FeedbackMainState();
}

class _FeedbackMainState extends State<FeedbackMain> {
  List<Map<String, dynamic>> feedbackArray = [
  ];

  
  @override
  void initState() {
    super.initState();
    _initializeUsers();
  }


Future<void> _initializeUsers() async {
  try {
    print("Initializing users...");

    List<int> userIds = [2, 3, 4];

    for (int userId in userIds) {
      Map<String, dynamic> userData = await ApiService.getUserController(userId);
      print("User data for user $userId: $userData");

      if (userData['data'] != null && userData['data'] is Map<String, dynamic>) {
        var userDataMap = userData['data'];

        // Add specific feedback data
        feedbackArray.addAll([
          {
            'feedbackcomment':
                'سهل علينا الوصول للمعلومات وكان ممتاز جدا وساعدنا احنا الفلسطينين على الوصول لافضل المعلومات عن الحواجز',
            'feedback': 'رائع',
            'profileimage': userDataMap['profile_picture_url'],
            'name': 'جنى حسن'
          },
          {
            'feedbackcomment': 'ممتاز جدا',
            'feedback': 'ممتاز',
            'profileimage': userDataMap['profile_picture_url'],
            'name': 'هديل الحسن'
          },
          {
            'feedbackcomment': 'تجربة مذهلة!',
            'feedback': 'رائع',
            'profileimage': userDataMap['profile_picture_url'],
            'name': 'فرح الحسن'
          },
        ]);

        // Optionally, you can use feedbackArray.add() for each feedback item instead of addAll() if needed
      } else {
        print("User data for user $userId is null or not a Map");
      }
    }

    setState(() {}); // Update the UI after fetching data
  } catch (e) {
    print("Error: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: feedbackArray.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: kIsWeb ? 620 : 340,
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
                            height: kIsWeb ? 320 : 300,
                            width: kIsWeb ? 420 : 350,
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
                                Text(
                                  feedbackArray[index]["feedbackcomment"],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  feedbackArray[index]["feedback"],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                               CircleAvatar(
  radius: 30.0,
  backgroundImage: NetworkImage(
    feedbackArray[index]["profileimage"],
  ),
),

                                Text(
                                  feedbackArray[index]["name"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
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
