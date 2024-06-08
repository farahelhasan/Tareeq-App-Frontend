import 'package:flutter/material.dart';
import 'package:hello_world/CheckpointList.dart';
import 'package:hello_world/GetChekpoints.dart';
import 'package:hello_world/ApiService.dart';

void main() {
  runApp(MaterialApp(
    home: CheckpointDetails(),
  ));
}

class CheckpointDetails extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "طريق",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(width: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.location_on_rounded,
                      size: 35,
                      color: Colors.indigo[900],
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      body: CheckpointDetailsBody(),
    );
  }
}

class CheckpointDetailsBody extends StatefulWidget {
  @override
  _CheckpointDetailsBodyState createState() => _CheckpointDetailsBodyState();
}

class _CheckpointDetailsBodyState extends State<CheckpointDetailsBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> fetchedData = await ApiService.checkpointsListController();
      setState(() {
       fetchedData;
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _updateCheckpointInfo() async {
    try {
      await ApiService.editCheckpointController(
        checkpointId: checkpointinfo.checkpointid,
        name: checkpointinfo.name,
        x_position: checkpointinfo.average_time_in,
        y_position: checkpointinfo.average_time_out,
        status_in: checkpointinfo.status_in,
        status_out: checkpointinfo.status_out,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      
      _showDialog('Success', 'تم تحديث معلومات الحاجز بنجاح');
    } catch (error) {
      _showDialog('Error', 'خطأ في تحديث معلومات الحاجز: $error');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('حسناً'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                checkpointInfoTitle,
                style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _buildAttributeRow(
            label: checkpointInfoNameLabel,
            value: checkpointinfo.name,
            onChanged: (newValue) {
              setState(() {
                checkpointinfo.name = newValue;
              });
            },
          ),
          _buildAttributeRow(
            label: checkpointInfoStatusLabelIn,
            value: checkpointinfo.status_in,
            onChanged: (newValue) {
              setState(() {
                checkpointinfo.status_in = newValue;
              });
            },
          ),
          _buildAttributeRow(
            label: checkpointInfoWaitTimeLabelIn,
            value: checkpointinfo.average_time_in.toString(),
            onChanged: (newValue) {
              setState(() {
                checkpointinfo.average_time_in = double.tryParse(newValue) ?? 0.0;
              });
            },
          ),
          _buildAttributeRow(
            label: checkpointInfoStatusLabelOut,
            value: checkpointinfo.status_out,
            onChanged: (newValue) {
              setState(() {
                checkpointinfo.status_out = newValue;
              });
            },
          ),
          _buildAttributeRow(
            label: checkpointInfoWaitTimeLabelOut,
            value: checkpointinfo.average_time_out.toString(),
            onChanged: (newValue) {
              setState(() {
                checkpointinfo.average_time_out = double.tryParse(newValue) ?? 0.0;
              });
            },
          ),
          _buildAttributeRow(
            label: 'تم التحديث في',
            value: checkpointinfo.updatedAt,
            onChanged: (newValue) {
              setState(() {
                checkpointinfo.updatedAt = newValue;
              });
            },
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _updateCheckpointInfo,
              child: Text(
                'تحديث المعلومات',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[900],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttributeRow({
    required String label,
    required String value,
    required void Function(String) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(26, 35, 126, 1),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: TextField(
                onChanged: onChanged,
                style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: value,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 3, bottom: 7, right: 20),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String checkpointInfoTitle = ':تعديل معلومات الحاجز';
const String checkpointInfoNameLabel = '  :الاسم';
const String checkpointInfoStatusLabelIn = '  :الداخل';
const String checkpointInfoStatusLabelOut = ' :الخارج';
const String checkpointInfoWaitTimeLabelIn = ' : الوقت المتوقع للانتظار (داخل)';
const String checkpointInfoWaitTimeLabelOut = ' : الوقت المتوقع للانتظار (خارج)';

Map<String, dynamic> checkpointInfo = {
  'name': checkpointinfo.name,
  'status_in': checkpointinfo.status_in,
  'status_out': checkpointinfo.status_out,
  'average_time_in': checkpointinfo.average_time_in.toString(),
  'average_time_out': checkpointinfo.average_time_out.toString(),
  'updatedAt': checkpointinfo.updatedAt,
};
