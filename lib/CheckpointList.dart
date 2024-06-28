import 'package:flutter/material.dart';
import 'package:hello_world/AboutTareeq.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/CheckpointListUpdate.dart';
import 'package:hello_world/GetChekpoints.dart';
import 'package:hello_world/PathQuestions.dart';
import 'package:hello_world/LogIn.dart';
import 'package:hello_world/MapPage.dart';
import 'package:hello_world/Profile.dart';
import 'package:hello_world/AddCheckpoint.dart';
import 'package:hello_world/SettingAdmin.dart';

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
  List<Map<String, dynamic>> filteredData = [];
  String filterQuery = ''; 
  int selectedindex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchData();
    filteredData = List.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.orange.shade50,
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.orange.shade50,
  onTap: (val) {
  setState(() {
  selectedindex = val;
  });
  switch (val) {
  case 0:
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  selectedindex = 0;
  break;
  case 1:
  profileinfo.name = Globals.name;
  profileinfo.userEmail = Globals.userEmail;
  profileinfo.username = Globals.username;
  profileinfo.user_id = Globals.userId;
  profileinfo.profile_picture_url = Globals.profile_picture_url;
  Navigator.push(context, MaterialPageRoute(builder: (context) => settings()));
  selectedindex = 1;
  break;
  }
  },
  currentIndex: selectedindex,
  selectedItemColor: Color.fromARGB(255, 135, 145, 237),
  unselectedItemColor: Colors.indigo[900],
  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
  items: [
  BottomNavigationBarItem(
  icon: Icon(Icons.home),
  label: "الصفحة الاساسية",
  ),
  BottomNavigationBarItem(
  icon: Icon(Icons.settings),
  label: "الاعدادات",
  ),
  ],
  ),
      appBar: AppBar(
        backgroundColor: Colors.orange.shade50,
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: IconButton(
            icon: Icon(Icons.menu, size: 40, color: Colors.indigo[900]),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search , size: 40, color: Colors.indigo[900]),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CheckpointSearchDelegate(data, filterMarkers),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.indigo[900],
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        Globals.profile_picture_url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Globals.username, style: TextStyle(color: Colors.white)),
                      Text(Globals.userEmail, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              Container(height: 20),
              ListTile(
                title: Text("الصفحة الرئيسية", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.home, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
              ListTile(
                title: Text("حسابك", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.account_box, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
              // ListTile(
              //   title: Text("اسأل عن الطريق التي تريد", style: TextStyle(color: Colors.white)),
              //   leading: Icon(Icons.question_answer, color: Colors.white),
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => LiveQuestions()));
              //   },
              // ),
              ListTile(
                title: Text("متابعة تقييمات طريق!", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.feedback, color: Colors.white),
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => InAppReviewExampleApp()));
                },
              ),
              // ListTile(
              //   title: Text("اضافة حاجز طيار", style: TextStyle(color: Colors.white)),
              //   leading: Icon(Icons.add, color: Colors.white),
              //   onTap: () {
              //     _showAddBarrierDialog(context);
              //   },
              // ),
              // ListTile(
              //   title: Text("ازالة حاجز طيار", style: TextStyle(color: Colors.white)),
              //   leading: Icon(Icons.remove, color: Colors.white),
              //   onTap: () {
              //     _showRemoveBarrierDialog(context);
              //   },
              // ),
              ListTile(
                title: Text("حول تطبيق طريق", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.help, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                },
              ),
              ListTile(
                title: Text("تسجيل خروج", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.logout, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
                },
              ),
              Container(height: 20),
              Container(child: Image.asset("images/gpssystem.png")),
              Container(height: 10),
            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.orange.shade50,
              child: TabBar(
                labelColor: const Color.fromARGB(255, 26, 35, 126),
                tabs: [
                  Tab(text: 'عرض القائمة'),
                  Tab(text: 'عرض الخريطة'),
                  Tab(text: 'إضافة حاجز'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                           itemCount: filteredData.length,
        itemBuilder: (BuildContext context, int index) {
          if (index >= filteredData.length) {
            return Container();
          }

                      
                       print("Building item at index $index: ${filteredData[index]}");
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 26, 35, 126)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ListTile(
            key: Key(filteredData[index]['checkpoint_id'].toString()), // Unique key for each ListTile
            title: Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    print("Removing item at index $index: ${filteredData[index]['checkpoint_id']}");
                    try {
                      await ApiService.deleteCheckpointController(filteredData[index]['checkpoint_id']);
                    } catch (error) {
                      print('Error removing checkpoint from database: $error');
                      return;
                    }
                    setState(() {
                      // Remove item from filteredData using List.removeWhere
                      filteredData.removeWhere((item) => item['checkpoint_id'] == filteredData[index]['checkpoint_id']);
                    });
                  },
                  child: Container(
                    child: CircleAvatar(
                      radius: 17,
                      backgroundImage: AssetImage('images/removeIcon.png'),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        filteredData[index]['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 26, 35, 126),
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage('images/locationDesignIcon.png'),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromARGB(255, 26, 35, 126)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () async {
              print("Tapped item at index $index: ${filteredData[index]}");
              checkpointinfo.checkpointid = filteredData[index]['checkpoint_id'];
              checkpointinfo.name = filteredData[index]['name'];
              checkpointinfo.x_position = filteredData[index]['x_position'];
              checkpointinfo.y_position = filteredData[index]['y_position'];
              checkpointinfo.status_in = filteredData[index]['status_in'];
              checkpointinfo.status_out = filteredData[index]['status_out'];
              checkpointinfo.updatedAt = filteredData[index]['updatedAt'];
              checkpointinfo.average_time_in = filteredData[index]['average_time_in'];
              checkpointinfo.average_time_out = filteredData[index]['average_time_out'];
              print("tapppp");

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckpointDetails()),
              );
            },
          ),
          if (filteredData[index]['complete_flag'] == false || filteredData[index]['complete_flag'] == null)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarrierDetailsPage(checkpointId: filteredData[index]['checkpoint_id'])),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  border: Border.all(color: const Color.fromARGB(255, 26, 35, 126)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "استكمال معلومات الحاجز",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 26, 35, 126),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  },
       
                  ),

                  MapApp(),
                  
                  AddCheckpointPage(),
                ],
              ),
            ),
          ],
        ),
      ),
      
    
    
    );
  }

  void _showAddBarrierDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AddBarrierDialog(),
    ).then((barrierName) {
      if (barrierName != null) {
        print('Barrier added: $barrierName');
      }
    });
  }

  void _showRemoveBarrierDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => RemoveBarrierDialog(),
    ).then((barrierName) {
      if (barrierName != null) {
        print('Barrier removed: $barrierName');
      }
    });
  }

     Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> fetchedData = await ApiService.checkpointsListController();
      setState(() {
      data = List.from(fetchedData);
      filteredData = List.from(data); // Start with all data shown
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
  void filterMarkers(String query) {
    setState(() {
      filterQuery = query;
      if (query.isEmpty) {
        filteredData = List.from(data); 
      } else {
        filteredData = data.where((item) {
          return item['name'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }
}

class AddBarrierDialog extends StatefulWidget {
  @override
  _AddBarrierDialogState createState() => _AddBarrierDialogState();
}

class _AddBarrierDialogState extends State<AddBarrierDialog> {
  TextEditingController barrierNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'تبليغ عن إضافة حاجز طيار',
        textAlign: TextAlign.right,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.indigo[900],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: barrierNameController,
            decoration: InputDecoration(labelText: 'ادخل اسم الحاجز الطيار'),
            textAlign: TextAlign.right,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: Text(
            'إلغاء',
            style: TextStyle(
              fontSize: 16,
              color: Colors.indigo[900],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            String barrierName = barrierNameController.text.trim();
            if (barrierName.isNotEmpty) {
              Navigator.of(context).pop(barrierName); // Pass the barrier name back to the caller
              ApiService.addRequestController(barrierName, profileinfo.x_position, profileinfo.y_position);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('الرجاء إدخال اسم الحاجز الطيار'),
                ),
              );
            }
          },
          child: Text(
            'إضافة',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo[900],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    barrierNameController.dispose();
    super.dispose();
  }
  

}


class CheckpointSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> data;
  final Function(String) filterCallback;

  CheckpointSearchDelegate(this.data, this.filterCallback);

  @override
  String get searchFieldLabel => 'ابحث هنا...';

  @override
  TextStyle get searchFieldStyle =>
  TextStyle(fontSize: 18, color: Colors.indigo[900]);


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          filterCallback(''); // Clear filter
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Close search without passing a result
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement if needed
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<String, dynamic>> suggestionList = query.isEmpty
        ? data
        : data.where((item) {
            return item['name'].toLowerCase().contains(query.toLowerCase());
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        // Build suggestion list UI here
        return ListTile(
          title: Text(suggestionList[index]['name']),
          onTap: () {
            filterCallback(suggestionList[index]['name']); // Apply filter
            close(context, suggestionList[index]['name']); // Close search and pass result
          },
        );
      },
    );
  }
}

class RemoveBarrierDialog extends StatefulWidget {
  @override
  _RemoveBarrierDialogState createState() => _RemoveBarrierDialogState();
}

class _RemoveBarrierDialogState extends State<RemoveBarrierDialog> {
  String selectedBarrierName = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ApiService.checkpointsListController(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else {
          List<Map<String, dynamic>> checkpoints = snapshot.data!;
          return AlertDialog(
            title: Text(
              'تبليغ عن إزالة حاجز طيار',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.indigo[900],
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedBarrierName.isNotEmpty ? selectedBarrierName : null,
                  items: checkpoints.map((checkpoint) {
                    return DropdownMenuItem<String>(
                      value: checkpoint['name'],
                      child: Text(checkpoint['name'], textAlign: TextAlign.right),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBarrierName = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'اختر اسم الحاجز الطيار'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text(
                  'إلغاء',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.indigo[900],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedBarrierName.isNotEmpty) {
                    // Map<String, dynamic>? selectedCheckpoint = checkpoints.firstWhere((checkpoint) => checkpoint['name'] == selectedBarrierName);
                    // int checkpointId = selectedCheckpoint['checkpoint_id'];
                    // Navigator.of(context).pop(selectedBarrierName); // Pass the barrier name back to the caller
                    ApiService.deleteRequestController(selectedBarrierName);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('الرجاء اختيار اسم الحاجز الطيار'),
                      ),
                    );
                  }
                },
                child: Text(
                  'حذف',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[900],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class BarrierDetailsPage extends StatelessWidget {
  final int checkpointId;
  final _formKey = GlobalKey<FormState>();


  final _xSignInController = TextEditingController();
  final _ySignInController = TextEditingController();
  final _statmentInController = TextEditingController();

  final _xSignOutController = TextEditingController();
  final _ySignOutController = TextEditingController();
  final _statmentOutController = TextEditingController();
  BarrierDetailsPage({required this.checkpointId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
                     backgroundColor: Colors.orange.shade50,

        title: Text("استكمال معلومات الحاجز"),
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
                        'استكمال معلومات الحاجز',
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
                     // add data to lookup table.
                     ApiService.insertIntoLookupController(_xSignInController.text, _ySignInController.text, checkpointId, "in", _statmentInController.text);
                     ApiService.insertIntoLookupController(_xSignOutController.text, _ySignOutController.text, checkpointId, "out", _statmentOutController.text);
                     // set the complete flag = true.
                     
                     // clear the text field.
                     _xSignInController.clear();
                     _ySignInController.clear();
                     _statmentInController.clear();
                     _xSignOutController.clear();
                     _ySignOutController.clear();
                     _statmentOutController.clear();


                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));

                     }
                  },
                  child: Text('اضافة',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[900],
              ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

