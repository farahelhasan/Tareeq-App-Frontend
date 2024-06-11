import 'package:flutter/material.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/CheckpointList.dart';
import 'package:hello_world/GetChekpoints.dart';
import 'package:hello_world/LiveQuestionsCheckpoints.dart';
import 'package:hello_world/CheckpointsChat.dart';
import 'package:hello_world/MapPageUser.dart';
import 'package:hello_world/Settings.dart';

void main() {
  runApp(MaterialApp(
    home: CheckpointDetailsBody(),
  ));
}

class CheckpointDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              if (question.isadmin) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyMapAppUser()),
                );
              }
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
              color: Colors.indigo[900],
            ),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              checkpointinfo.name,
              style: TextStyle(
                color: Colors.indigo[900],
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            // TabBar
            TabBar(
              tabs: [
                Tab(text: 'معلومات الحاجز'),
                Tab(text: 'السؤال عن الحاجز'),
                Tab(text: 'اخر التحديثات'),
              ],
              labelColor: Colors.indigo[900],
              indicatorColor: Colors.indigo[900],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(
                    children: [
                      // First tab view
                      _buildTabView(),
                      // Second tab view
                      LiveQuestionsCheckpoints(),
                      // Third tab view
                      Comments(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabView() {
    return ListView(
      children: [
        // Title
        Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'معلومات الحاجز',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        _buildAttributeRow(checkpointinfo.name, '  :الاسم'),
        _buildAttributeRow(checkpointinfo.status_in, '  :الداخل'),
        _buildAttributeRow(checkpointinfo.average_time_in.toString(), ' : الوقت المتوقع للانتظار'),
        _buildAttributeRow(checkpointinfo.status_out, ' :الخارج'),
        _buildAttributeRow(checkpointinfo.average_time_out.toString(), ' : الوقت المتوقع للانتظار'),
        _buildAttributeRow(checkpointinfo.updatedAt, " "),
        _buildSmallerAttributeRow("", "اضافة الى المفضلة")
      ],
    );
  }

  Widget _buildAttributeRow(String value, String label) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(26, 35, 126, 1),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallerAttributeRow(String value, String label) {
    return _SmallerAttributeRow(value: value, label: label);
  }
}

class _SmallerAttributeRow extends StatefulWidget {
  final String value;
  final String label;

  _SmallerAttributeRow({required this.value, required this.label});

  @override
  __SmallerAttributeRowState createState() => __SmallerAttributeRowState();
}

class __SmallerAttributeRowState extends State<_SmallerAttributeRow> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    try {
      bool status = await ApiService.checkFavoriteController(
          pathinfo.user_id, checkpointinfo.checkpointid);
      setState(() {
        isFavorite = status;
      });
    } catch (e) {
      print('Failed to load favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color:Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromRGBO(26, 35, 126, 1),
            width: 3,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.indigo[900],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () async {
                setState(() {
                  isFavorite = !isFavorite;
                });
                try {
                  if (isFavorite) {
                    await ApiService.setFavoriteController(
                        profileinfo.user_id, checkpointinfo.checkpointid);
                  } else {
                    await ApiService.removeFavorite(
                        checkpointinfo.checkpointid, profileinfo.user_id);
                  }
                } catch (e) {
                  print('Failed to update favorite status: $e');
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class question {
  static int user_id = profileinfo.user_id;
  static String name = profileinfo.name;
  static bool isadmin = profile.isadmin;
  static String username = profileinfo.username;
  static int checkpointid = checkpointinfo.checkpointid;
}
