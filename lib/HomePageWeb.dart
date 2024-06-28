import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/AboutTareeq.dart';
import 'package:hello_world/AddCheckpoint.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/CheckpointListUpdate.dart';
import 'package:hello_world/FavoriteList.dart';
import 'package:hello_world/GetChekpoints.dart';
import 'package:hello_world/MapPageAdminWeb.dart';
import 'package:hello_world/PathQuestions.dart';
import 'package:hello_world/LogIn.dart';
import 'package:hello_world/MapPage.dart';
import 'package:hello_world/Profile.dart';
import 'package:hello_world/Review.dart';
import 'package:hello_world/Settings.dart';
import 'package:reviews_slider/reviews_slider.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePageWeb(),
  ));
}


class HomePageWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  
  
  @override
  void initState() {
    super.initState();
    fetchData();
    filteredData = List.from(data);
    _initializeUser();

  }
Future<void> _initializeUser() async {
  try {
  print("Initializing user...");
  print(profile.user_id);
  Map<String, dynamic> userNameData = await ApiService.getUserController(profile.user_id);
  print(userNameData);
  if (userNameData['data'] != null) {
  if (userNameData['data'] is Map<String, dynamic>) {
  var userData = userNameData['data'];
  profile.userEmail = userData['email'];
  profile.name = userData['name'];
  profile.username = userData['username'];
  profile.password = userData['password'];
  profile.profile_picture_url =userData['profile_picture_url'];
    } else {
  print("Data is not a Map");
  }
  }
  } catch (e) {
  print("Error: $e");
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      key: _scaffoldKey,
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
                    child: 
                   CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage( profile.profile_picture_url),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Globals.name, style: TextStyle(color: Colors.white)),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageWeb()));
                },
              ),
              ListTile(
                title: Text("حسابك", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.account_box, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileWeb()));
                },
              ),
              // ListTile(
              //   title: Text("اسأل عن الطريق التي تريد", style: TextStyle(color: Colors.white)),
              //   leading: Icon(Icons.question_answer, color: Colors.white),
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => LiveQuestionsWeb()));
              //   },
              // ),
              ListTile(
                title: Text("متابعة تقيمات طريق", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.feedback, color: Colors.white),
                onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackMain()));
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
              //  ListTile(
              //   title: Text("الحواجز المفضلة", style: TextStyle(color: Colors.white)),
              //   leading: Icon(Icons.favorite, color: Colors.white),
              //   onTap: () {
              //    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppFav()));
              //   },
              // ),
              ListTile(
                title: Text("حول تطبيق طريق", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.help, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPageWeb()));
                },
              ),
              ListTile(
                title: Text("تسجيل خروج", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.logout, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => loginweb()));
                },
              ),
              Container(
                height: 120,
                width: 120,
                child: Image.asset("images/gpssystem.png")),
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
            key: Key(filteredData[index]['checkpoint_id'].toString()), 
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
          if (filteredData[index]['complete_flag'] == 0 || filteredData[index]['complete_flag'] == null)
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

                  kIsWeb ? MapAppWeb() : MyMapApp(),
                  
                  AddCheckpointPage(),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: buildBottomNavigationBar(context),
    
    );
  }

  
// Bottom navigation bar builder
BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
  int selectedindex = 1;
  return BottomNavigationBar(
    backgroundColor: Colors.orange.shade50,
    onTap: (val) {
      switch (val) {
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (context) => kIsWeb ? LiveQuestionsWeb() : LiveQuestions()));
          selectedindex = 1;
          break;
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyMapApp()));
          selectedindex = 1;
          break;
        case 2:
          profileinfo.name = Globals.name;
          profileinfo.userEmail = Globals.userEmail;
          profileinfo.username = Globals.username;
          profileinfo.user_id = Globals.userId;
          profileinfo.profile_picture_url = Globals.profile_picture_url;
          Navigator.push(context, MaterialPageRoute(builder: (context) =>SettingsWeb()));
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
        icon: Icon(Icons.question_answer),
        label: "الاسئلة المباشرة",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "الصفحة الاساسية",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "الاعدادات",
      ),
    ],
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
 
 void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ReviewDialog()
    );
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

class CheckpointSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> data;
  final Function(String) filterCallback;

  CheckpointSearchDelegate(this.data, this.filterCallback);

  @override
  String get searchFieldLabel => 'ابحث هنا...';

  @override
  TextStyle get searchFieldStyle => TextStyle(fontSize: 18, color: Colors.indigo[900]);

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

class ReviewDialog extends StatefulWidget {
  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  String _review = '';
  List<String> list = ["سيء جداً" ,"سيء","جيد","ممتاز", "رائع"];

  String selectedValue = "جيد"; 

  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Review: $_review');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text('تقييم التطبيق', style: TextStyle(color: Colors.indigo[900])),
        content: SingleChildScrollView(
          child: Container(
            width: double.maxFinite, // Ensure the content area takes full width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'تعليقك',
                      labelStyle: TextStyle(color: Colors.indigo[900]),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء إدخال تعليقك';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _review = value!;
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ReviewSlider(
                    initialValue: 2, // Set an initial index based on your list
                    options: list,
                    onChange: (int value) {
                      setState(() {
                        selectedValue = list[value];
                      });
                    },
                  ),
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
        contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0), // Adjust content padding
        actionsPadding: EdgeInsets.symmetric(horizontal: 12.0), // Adjust actions padding
        buttonPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('إلغاء', style: TextStyle(color: Colors.indigo[900])),
          ),
          ElevatedButton(
            onPressed: _submitReview,
            child: Text('إرسال', style: TextStyle(color: Colors.indigo[900])),
          ),
        ],
      ),
    );
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePageWeb()));
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePageWeb()));
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
        title: Align(
          alignment: Alignment.centerRight,
          child: Text("استكمال معلومات الحاجز" , style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 26, 35, 126), 
          ),
            )
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
