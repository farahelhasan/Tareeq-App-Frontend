import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/AboutTareeq.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/FavoriteList.dart';
import 'package:hello_world/MapPageUser.dart';
import 'package:hello_world/Profile.dart';
import 'package:hello_world/LogIn.dart';
import 'package:hello_world/PathQuestions.dart';
import 'package:hello_world/Settings.dart';
import 'package:hello_world/GetChekpoints.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reviews_slider/reviews_slider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepageuserweb(),
  ));
}


class Homepageuserweb extends StatefulWidget {
  @override
  _MapAppWebState createState() => _MapAppWebState();
}

class _MapAppWebState extends State<Homepageuserweb> {
  
  StreamSubscription<Position>? positionStream;
  GoogleMapController? gmc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Marker> markers = [];
  List<Marker> filteredMarkers = []; 
  TextEditingController searchController = TextEditingController();
  int selectedindex = 1;
  String? image; 

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(32.153844, 35.266756),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    initialStream();
    _initializeUser();
    _loadMarkers();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

    Future<void> _initializeUser() async {
    try {
      print("Initializing user...");
      print(profile.user_id);
      Map<String, dynamic> userData = await ApiService.getUserController(profile.user_id);
      print(userData);
      setState(() {
        profile.userEmail = userData['email'];
        profile.name = userData['name'];
        profile.username = userData['username'];
        profile.password = userData['password'];
        profile.profile_picture_url = userData['profile_picture_url'];
      });
    } catch (e) {
      print("Error initializing user: $e");
    }
  }

  Future<void> initialStream() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showMyDialog('الموقع ليس مفعلاً', 'يجب تفعيل الموقع حتى يعمل التطبيق بشكل مناسب');
      throw Exception('الموقع لم يتم تفعيله');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        profileinfo.Location = false;
        await _showMyDialog('الموقع ليس مفعلاً', 'يجب تفعيل الموقع حتى يعمل التطبيق بشكل مناسب');
        throw Exception('الموقع لم يتم تفعيله');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      profileinfo.Location = false;
      await _showMyDialog('تم الغاء تفعيل الموقع', 'يجب تفعيل الموقع حتى يعمل التطبيق بشكل مناسب');
      throw Exception('تم الغاء تفعيل الموقع يجب تفعيله');
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      profileinfo.Location = true;
      positionStream = Geolocator.getPositionStream().listen(
  (Position? position) {
    markers.add(
      Marker(
        markerId: MarkerId("ME"),
        position: LatLng(position!.latitude, position.longitude),
      ),
    
    );
      filteredMarkers.add(
      Marker(
        markerId: MarkerId("ME"),
        position: LatLng(position.latitude, position.longitude),
      ),
      );
    profileinfo.x_position = position.latitude;
    profileinfo.y_position = position.longitude;
    if (gmc != null) {
      gmc!.animateCamera(CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
    }
    setState(() {});
  },
);

    }
  }

Future<void> _showMyDialog(String title, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK!'),
            onPressed: () {
              Navigator.of(context).pop(); // Changed to Navigator.of(context)
            },
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
  bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.orange.shade50,
  onTap: (val) {
  setState(() {
  selectedindex = val;
  });
  switch (val) {
  case 0:
  Navigator.push(context, MaterialPageRoute(builder: (context) => LiveQuestionsWeb()));
  selectedindex = 1;
  break;
  case 1:
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyMapAppUser()));
  selectedindex = 1;
  break;
  case 2:
  profileinfo.name = Globals.name;
  profileinfo.userEmail = Globals.userEmail;
  profileinfo.username = Globals.username;
  profileinfo.user_id = Globals.userId;
  profileinfo.profile_picture_url = Globals.profile_picture_url;
    var name = profileinfo.name;
    var id = Globals.userId;
   
   print('User ID in map: $id');
   print('Name map: $name'); 
  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsWeb()));
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
  label: "السؤال عن مسار",
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
  ),


  appBar:AppBar(
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

actions: 
   [     
    Padding(
      padding: EdgeInsets.all(5),
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          icon: Icon(Icons.menu, size: 45, color: Colors.indigo[900]),
          onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
        ),
      ),
    ),
         IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MarkerSearchDelegate(filteredMarkers, filterMarkers),
              );
            },
            icon: Icon(Icons.search , size: 45, color: Colors.indigo[900]),
          ),
        ],
  ),
  endDrawer: Drawer(
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
  child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage(profile.profile_picture_url),
                    ),
  ),
  SizedBox(width: 10),
  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(profileinfo.username, style: TextStyle(color: Colors.white)),
  Text(profileinfo.userEmail, style: TextStyle(color: Colors.white)),
  ],
  ),
  ],
  ),
              Container(height: 20),
              ListTile(
                title: Text("الصفحة الرئيسية", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.home, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyMapAppUser()));
                },
              ),
              ListTile(
                title: Text("حسابك", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.account_box, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => kIsWeb ? ProfileWeb() : Profile()));
                },
              ),
              ListTile(
                title: Text(" اسأل عن المسار الذي تريد ان تسلكه", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.question_answer, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => kIsWeb ? LiveQuestionsWeb() : LiveQuestions()));
                },
              ),
              ListTile(
                title: Text(" تقييم التطبيق", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.feedback, color: Colors.white),
                onTap: () {
                  _showReviewDialog(context);
                },
              ),
              ListTile(
                title: Text("اضافة حاجز طيار", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.add, color: Colors.white),
                onTap: () {
                  _showAddBarrierDialog(context);
                },
              ),
              ListTile(
                title: Text("ازالة حاجز طيار", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.remove, color: Colors.white),
                onTap: () {
                  _showRemoveBarrierDialog(context);
                },
              ),
              ListTile(
                title: Text("الحواجز المفضلة", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.favorite, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppFav()));
                },
              ),
              ListTile(
                title: Text("حول تطبيق طريق", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.help, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => kIsWeb ? AboutPageWeb() : AboutPage()));
                },
              ),
              ListTile(
                title: Text("تسجيل خروج", style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.logout, color: Colors.white),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => loginweb()));
                },
              ),
              Container(height: 10),
              Container(child: Image.asset("images/gpssystem.png" , height: 120, width: 120,)),
              Container(height: 10),
  ],
  ),
  ),
  ),
  
  
  
  body: Container(
  child: Column(
  children: [
  Expanded(
  child: Stack(
  children: [
  GoogleMap(
  initialCameraPosition: cameraPosition,
  mapType: MapType.normal,
  onMapCreated: (controller) {
  gmc = controller;
  },
  zoomControlsEnabled: false,
  zoomGesturesEnabled: true,
  markers: Set.from(filteredMarkers),
  ),
  Positioned(
  bottom: 16.0,
  right: 16.0,
  child: Column(
  children: [
  FloatingActionButton(
  backgroundColor: Colors.orange.shade50,
  mini: true,
  onPressed: () {
  gmc!.animateCamera(CameraUpdate.zoomIn()); 
  },
  child: Icon(Icons.add, color: Colors.indigo[900]),
  ),
  SizedBox(height: 5),
  FloatingActionButton(
  backgroundColor: Colors.orange.shade50,
  mini: true,
  onPressed: () {
  gmc!.animateCamera(CameraUpdate.zoomOut());
  },
  child: Icon(Icons.remove, color: Colors.indigo[900]),
  ),
  ],
  ),
  ),
  ],
  ),
  ),
  ],
  ),
  ),
  );
  }

  
    Future<void> _loadMarkers() async {
    List<Marker> checkpointMarkers = await convertToMarkers(context);
    setState(() {
      markers = checkpointMarkers;
      filteredMarkers = List.from(markers); // Ensure filteredMarkers starts with all markers
    });
  }

  void filterMarkers(String query) {
    List<Marker> filteredList = markers.where((marker) {
      return marker.infoWindow.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredMarkers = filteredList;
    });
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
  
  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ReviewDialog()
    );
  }

}

class MarkerSearchDelegate extends SearchDelegate<String> {
 final List<Marker> markers;
 final Function(String) filterCallback;

  MarkerSearchDelegate(this.markers, this.filterCallback);

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
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
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
 List<Marker> suggestionList = query.isEmpty
    ? markers
    : markers.where((marker) =>
        marker.infoWindow != null &&
        marker.infoWindow.title != null &&
        marker.infoWindow.title!.toLowerCase().contains(query.toLowerCase())
    ).toList();


  return ListView.builder(
    itemCount: suggestionList.length,
    itemBuilder: (context, index) {
      Marker marker = suggestionList[index];
      return ListTile(
        title: Text(marker.infoWindow!.title!),
        onTap: () {
          filterCallback(marker.infoWindow!.title!); // Apply filter
          close(context, marker.infoWindow!.title!); // Close search and pass result
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
  List<String> list = ['سيء جداً', 'سيء', 'جيد', 'ممتاز', 'رائع'];
  //List<String> list = ['رائع' ,'ممتاز' ,'جيد' , 'سيء' 'سيء جداً' ];
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
      textDirection: TextDirection.ltr,
      child: AlertDialog(
        title: Text('تقييم التطبيق', style: TextStyle(color: Colors.indigo[900])),
        content: SingleChildScrollView(
          child: Container(
            width: 400.0, // Set your desired width here
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
                    // Replace with your desired initial value
                    initialValue: 2,
                    // Replace with your list of review options
                    options: list,
                    // Replace with your onChange callback
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
        contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
        actionsPadding: EdgeInsets.symmetric(horizontal: 12.0),
        buttonPadding: EdgeInsets.symmetric(horizontal: 16.0),
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyMapAppUser()));} 
              else {
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
                    Map<String, dynamic>? selectedCheckpoint = checkpoints.firstWhere((checkpoint) => checkpoint['name'] == selectedBarrierName);
                    String checkpointName = selectedCheckpoint['name'];
                    Navigator.of(context).pop(selectedBarrierName); // Pass the barrier name back to the caller
                    ApiService.deleteRequestController(checkpointName);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyMapAppUser()));
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