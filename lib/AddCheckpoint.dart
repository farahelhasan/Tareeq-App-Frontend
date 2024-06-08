import 'package:flutter/material.dart';
import 'package:hello_world/ApiService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCheckpointPage extends StatefulWidget {
  @override
  _AddCheckpointPageState createState() => _AddCheckpointPageState();
}

class _AddCheckpointPageState extends State<AddCheckpointPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _xController = TextEditingController();
  final _yController = TextEditingController();

  final _xSignInController = TextEditingController();
  final _ySignInController = TextEditingController();
  final _statmentInController = TextEditingController();

  final _xSignOutController = TextEditingController();
  final _ySignOutController = TextEditingController();
  final _statmentOutController = TextEditingController();

  // Future<void> _addCheckpoint(String name, double x, double y) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://yourapiurl.com/checkpoint'),
  //       body: json.encode({
  //         'name': name,
  //         'x': x,
  //         'y': y,
  //       }),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 201) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Checkpoint added successfully')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to add checkpoint')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to add checkpoint')),
  //     );
  //   }
  // }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'اضافة حاجز',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 26, 35, 126),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.add,
                        size: 30,
                        color: const Color.fromARGB(255, 26, 35, 126),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'معلومات الحاجز',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 26, 35, 126),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0), // Add margin between text fields
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'اسم الحاجز',
                      labelStyle: TextStyle(fontSize: 15), // Increase font size of the label
                      contentPadding: EdgeInsets.only(left: 285), // Add padding to the right
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال اسم الحاجز';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0), // Add margin between text fields
                  child: TextFormField(
                    controller: _xController,
                    decoration: InputDecoration(
                      labelText: 'الاحداثي السيني',
                      labelStyle: TextStyle(fontSize: 15), // Increase font size of the label
                      contentPadding: EdgeInsets.only(left: 250.0), // Add padding to the right
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال الاحداث السيني';
                      }
                      if (double.tryParse(value) == null) {
                        return 'الرجاء ادخال رقم ';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0), // Add margin between text fields
                  child: TextFormField(
                    controller: _yController,
                    decoration: InputDecoration(
                      labelText: 'الاحداثي الصادي',
                      labelStyle: TextStyle(fontSize: 15), // Increase font size of the label
                      contentPadding: EdgeInsets.only(left: 250.0), // Add padding to the right
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال الاحداثي الصادي';
                      }
                      if (double.tryParse(value) == null) {
                        return 'الرجاء ادخال رقم ';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'تحديد الاتجاهات',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 26, 35, 126),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        ' الدخول',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 82, 92, 196),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0), // Add margin between text fields
                  child: TextFormField(
                    controller: _xSignInController,
                    decoration: InputDecoration(
                      labelText: 'اشارة الاحداثي السيني',
                      labelStyle: TextStyle(fontSize: 15), // Increase font size of the label
                      contentPadding: EdgeInsets.only(left: 220.0), // Add padding to the right
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                    //keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال اشارة الاحداث السيني';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0), // Add margin between text fields
                  child: TextFormField(
                    controller: _ySignInController,
                    decoration: InputDecoration(
                      labelText: 'اشارة الاحداثي الصادي',
                      labelStyle: TextStyle(fontSize: 15), // Increase font size of the label
                      contentPadding: EdgeInsets.only(left: 220.0), // Add padding to the right
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                //    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال اشارة الاحداثي الصادي';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0), // Add margin between text fields
                  child: TextFormField(
                    controller: _statmentInController,
                    decoration: InputDecoration(
                      labelText: 'اضافة وصف',
                      labelStyle: TextStyle(fontSize: 15), // Increase font size of the label
                      contentPadding: EdgeInsets.only(left: 280.0), // Add padding to the right
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء اضافة وصف';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        ' الخروج',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 82, 92, 196),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0), // Add margin between text fields
                  child: TextFormField(
                    controller: _xSignOutController,
                    decoration: InputDecoration(
                      labelText: 'اشارة الاحداثي السيني',
                      labelStyle: TextStyle(fontSize: 15), // Increase font size of the label
                      contentPadding: EdgeInsets.only(left: 220.0), // Add padding to the right
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                 //   keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال اشارة الاحداث السيني';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0), // Add margin between text fields
                  child: TextFormField(
                    controller: _ySignOutController,
                    decoration: InputDecoration(
                      labelText: 'اشارة الاحداثي الصادي',
                      labelStyle: TextStyle(fontSize: 15), // Increase font size of the label
                      contentPadding: EdgeInsets.only(left: 220.0), // Add padding to the right
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                  //  keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال اشارة الاحداثي الصادي';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0), // Add margin between text fields
                  child: TextFormField(
                    controller: _statmentOutController,
                    decoration: InputDecoration(
                      labelText: 'اضافة وصف',
                      labelStyle: TextStyle(fontSize: 15), // Increase font size of the label
                      contentPadding: EdgeInsets.only(left: 280.0), // Add padding to the right
                    ),
                    textAlign: TextAlign.right, // Align text to the right
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء اضافة وصف';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: ()  async {
                    if (_formKey.currentState!.validate()) {
                    // add data to checkpoint table.
                     ApiService.addCheckpointController(_nameController.text, double.parse(_xController.text), double.parse(_yController.text));
                     // add data to lookup table.
                     Map<String, dynamic> response = await ApiService.searchByNmae(_nameController.text);
                     int checkpoint_id = response['data']['checkpoint_id'];
                     ApiService.insertIntoLookupController(_xSignInController.text, _ySignInController.text, checkpoint_id, "in", _statmentInController.text);
                     ApiService.insertIntoLookupController(_xSignOutController.text, _ySignOutController.text, checkpoint_id, "out", _statmentOutController.text);
                     }
                  },
                  child: Text('اضافة'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AddCheckpointPage(),
  ));
}
