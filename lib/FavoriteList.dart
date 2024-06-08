import 'package:flutter/material.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/Settings.dart';
import 'package:hello_world/CheckpointsInfo.dart'; 
import 'package:hello_world/GetChekpoints.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> fetchedData = await ApiService.getFavoriteController(profile.user_id);
      setState(() {
        data = fetchedData;
        print('data: $data');
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 35, 126),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "طريق",
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ' الحواجز المفضلة',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 26, 35, 126),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 26, 35, 126)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Stack( // Use a Stack to position the delete icon to the left
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // Call the function to remove the item from the database
                            try {
                              await ApiService.deleteCheckpointController(data[index]['checkpoint_id']);
                            } catch (error) {
                              print('Error removing checkpoint from database: $error');
                              // Handle any errors that occur during database removal
                              return;
                            }
                            setState(() {
                              data.removeAt(index);
                            });
                            // Implement your database deletion logic here
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5), // Add padding to the delete icon
                            child: CircleAvatar(
                              radius: 17,
                              backgroundImage: AssetImage('images/favorite.png'),
                            ),
                          ),
                        ),
                        Positioned( // Position the text to the right of the delete icon
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                               // 'heloo',
                                data[index]['name'],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 26, 35, 126),
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(width: 10),
                              Container(
                                child:  Align(
                                  alignment: Alignment.centerLeft, // Align the CircleAvatar to the left
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundImage: AssetImage('images/locationDesignIcon.png'),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color.fromARGB(255, 243, 193, 1)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                   onTap: () async {
                     
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckpointDetailsBody()),
                      );
                      checkpointinfo.checkpointid = data[index]['checkpoint_id'];
                      checkpointinfo.name = data[index]['name'];
                      checkpointinfo.x_position = data[index]['x_position'];
                      checkpointinfo.y_position = data[index]['y_position'];
                      checkpointinfo.status_in = data[index]['status_in'];
                      checkpointinfo.status_out= data[index]['status_out'];
                      checkpointinfo.updatedAt = data[index]['updatedAt'];
                      checkpointinfo.average_time_in = data[index]['average_time_in'];
                      checkpointinfo.average_time_out = data[index]['average_time_out'];
                   },
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

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  DetailPage(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
      ),
      body: Center(
        child: Text(data['description']),
      ),
    );
  }
}

// class checkpointinfo{
//   static int checkpointid = 0;
//   static String name='hh';
//   static String status_in='';
//   static String status_out='';
//   static double x_position =0.0;
//   static double y_position =0.0;
//   static String updatedAt ='';
 

// }
