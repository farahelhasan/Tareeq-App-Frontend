// import 'dart:async';
// import 'package:flutter/material.dart';
// //import 'package:hello_world/AboutTareeq.dart';
// import 'package:hello_world/ApiService.dart';
// //import 'package:hello_world/Profile.dart';
// import 'package:hello_world/LogIn.dart';
// import 'package:hello_world/PathQuestions.dart';
// import 'package:hello_world/Settings.dart';
// import 'package:hello_world/GetChekpoints.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

//   void main() {
//   runApp(MyMapApp());
//   ApiService.checkpointsListController();
//   }

//   class MyMapApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//   return MaterialApp(
//   home: MapApp(),
//   );
//   }
//   }

//   class MapApp extends StatefulWidget {
//   const MapApp({Key? key}) : super(key: key);

//   @override
//   State<MapApp> createState() => _MapAppState();
//   }
//   class _MapAppState extends State<MapApp> {
//   StreamSubscription<Position>? positionStream;
//   CameraPosition cameraPosition = CameraPosition(
//   target: LatLng(32.153844, 35.266756),
//   zoom: 12,
//   );
//   GoogleMapController? gmc;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int selectedindex = 1;
//   List<Marker> markers = [];

//   Future<void> initialStream() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//   throw Exception('الموقع لم يتم تفعيله');
//   } else {
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//   permission = await Geolocator.requestPermission();
//   if (permission == LocationPermission.denied) {
//   profileinfo.Location = false;
//   throw Exception('الموقع لم يتم تفعيله');
//   }
//   }
//   if (permission == LocationPermission.deniedForever) {
//   profileinfo.Location = false;
//   throw Exception('تم الغاء تفعيل الموقع يجب تفعيله');
//   }
//   if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
//   profileinfo.Location = true;
//   positionStream = Geolocator.getPositionStream().listen(
//   (Position? position) {
//   markers.add(
//   Marker(
//   markerId: MarkerId("ME"),
//   position: LatLng(position!.latitude, position.longitude),
//   ),
//   );
//   profileinfo.x_position = position.latitude;
//   profileinfo.y_position = position.longitude;
//   // if (gmc != null) {
//   // gmc!.animateCamera(CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
//   // }
//   setState(() {});
//   },
//   );
//   }
//   }
//   }

//   Future<void> _showMyDialog() async {
//   return showDialog<void>(
//   context: context,
//   barrierDismissible: false,
//   builder: (BuildContext context) {
//   return AlertDialog(
//   title: Row(
//   children: [
//   Icon(Icons.warning, color: Colors.red), 
//   SizedBox(width: 8), 
//   Text('الموقع ليس مفعلاً'),
//   ],
//   ),
//   content: const SingleChildScrollView(
//   child: ListBody(
//   children: <Widget>[
//   Text('يجب تفعيل الموقع حتى يعمل التطبيق بشكل مناسب'),
//   ],
//   ),
//   ),
//   actions: <Widget>[
//   TextButton(
//   child: const Text('OK!'),
//   onPressed: () {
//   Navigator.of(context).pop();
//   },
//   ),
//   ],
//   );
//   },
//   );
//   }

//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//   key: _scaffoldKey,
//   bottomNavigationBar: BottomNavigationBar(
//   backgroundColor: Colors.orange.shade50,
//   onTap: (val) {
//   setState(() {
//   selectedindex = val;
//   });
//   switch (val) {
//   case 0:
//   Navigator.push(context, MaterialPageRoute(builder: (context) => LiveQuestions()));
//   selectedindex = 1;
//   break;
//   case 1:
//   Navigator.push(context, MaterialPageRoute(builder: (context) => MyMapApp()));
//   selectedindex = 1;
//   break;
//   case 2:
//   profileinfo.name = Globals.name;
//   profileinfo.userEmail = Globals.userEmail;
//   profileinfo.username = Globals.username;
//   profileinfo.user_id = Globals.userId;
//   profileinfo.profile_picture_url = Globals.profile_picture_url;
//   Navigator.push(context, MaterialPageRoute(builder: (context) => settings()));
//   selectedindex = 1;
//   break;
//   }
//   },
//   currentIndex: selectedindex,
//   selectedItemColor: Color.fromARGB(255, 135, 145, 237),
//   unselectedItemColor: Colors.indigo[900],
//   selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//   items: [
//   BottomNavigationBarItem(
//   icon: Icon(Icons.question_answer),
//   label: "الاسئلة المباشرة",
//   ),
//   BottomNavigationBarItem(
//   icon: Icon(Icons.home),
//   label: "الصفحة الاساسية",
//   ),
//   BottomNavigationBarItem(
//   icon: Icon(Icons.settings),
//   label: "الاعدادات",
//   ),
//   ],
//   ),
//     appBar: profileinfo.user_id != 1
//           ? AppBar(
//               backgroundColor: Colors.orange.shade50,
//               title: Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Align(
//                   child: Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           "طريق",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.indigo[900],
//                             fontWeight: FontWeight.bold,
//                             fontSize: 35,
//                           ),
//                         ),
//                         SizedBox(width: 5),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Icon(
//                             Icons.location_on_rounded,
//                             size: 35,
//                             color: Colors.indigo[900],
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               // leading: Padding(
//               //   padding: const EdgeInsets.only(left: 10, top: 10),
//               //   child: IconButton(
//               //     icon: Icon(Icons.menu, size: 40, color: Colors.indigo[900]),
//               //     onPressed: () => _scaffoldKey.currentState!.openDrawer(),
//               //   ),
//               // ),
//             )
//           : null,
//   // drawer: Drawer(
//   // backgroundColor: Colors.indigo[900],
//   // child: Container(
//   // padding: EdgeInsets.all(20),
//   // child: ListView(
//   // children: [
//   // Row(
//   // children: [
//   // Container(
//   // height: 60,
//   // width: 60,
//   // child: ClipRRect(
//   // borderRadius: BorderRadius.circular(60),
//   // child: Image.asset(
//   // Globals.profile_picture_url,
//   // fit: BoxFit.cover,
//   // ),
//   // ),
//   // ),
//   // SizedBox(width: 10),
//   // Column(
//   // crossAxisAlignment: CrossAxisAlignment.start,
//   // children: [
//   // Text(Globals.username, style: TextStyle(color: Colors.white)),
//   // Text(Globals.userEmail, style: TextStyle(color: Colors.white)),
//   // ],
//   // ),
//   // ],
//   // ),
//   //Container(height: 20),
//   // ListTile(
//   // title: Text("الصفحة الرئيسية", style: TextStyle(color: Colors.white)),
//   // leading: Icon(Icons.home, color: Colors.white),
//   // onTap: () {
//   // Navigator.push(context, MaterialPageRoute(builder: (context) => MapApp()));
//   // },
//   // ),
//   // ListTile(
//   // title: Text("حسابك", style: TextStyle(color: Colors.white)),
//   // leading: Icon(Icons.account_box, color: Colors.white),
//   // onTap: () {
//   // Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
//   // },
//   // ),
//   // ListTile(
//   // title: Text("اسأل عن الطريق التي تريد", style: TextStyle(color: Colors.white)),
//   // leading: Icon(Icons.question_answer, color: Colors.white),
//   // onTap: () {
//   // Navigator.push(context, MaterialPageRoute(builder: (context) => LiveQuestions()));
//   // },
//   // ),
//   // ListTile(
//   // title: Text("تقييم", style: TextStyle(color: Colors.white)),
//   // leading: Icon(Icons.feedback, color: Colors.white),
//   // onTap: () {
//   // //Navigator.push(context, MaterialPageRoute(builder: (context) => InAppReviewExampleApp()));
//   // },
//   // ),
//   // ListTile(
//   // title: Text("اضافة حاجز طيار", style: TextStyle(color: Colors.white)),
//   // leading: Icon(Icons.add, color: Colors.white),
//   // onTap: () {},
//   // ),
//   // ListTile(
//   // title: Text("حول تطبيق طريق", style: TextStyle(color: Colors.white)),
//   // leading: Icon(Icons.help, color: Colors.white),
//   // onTap: () {
//   // Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
//   // },
//   // ),
//   // ListTile(
//   // title: Text("تسجيل خروج", style: TextStyle(color: Colors.white)),
//   // leading: Icon(Icons.logout, color: Colors.white),
//   // onTap: () {
//   // Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
//   // },
//   // ),
//   // Container(height: 20),
//   // Container(child: Image.asset("images/gpssystem.png")),
//   // Container(height: 10),
//   // ],
//   // ),
//   // ),
//   // ),
//   body: Container(
//   child: Column(
//   children: [
//   Expanded(
//   child: Stack(
//   children: [
//   GoogleMap(
//   initialCameraPosition: cameraPosition,
//   mapType: MapType.normal,
//   onMapCreated: (controller) {
//   gmc = controller;
//   },
//   zoomControlsEnabled: false,
//   zoomGesturesEnabled: true,
//   markers: markers.toSet(),
//   ),
//   Positioned(
//   bottom: 16.0,
//   right: 16.0,
//   child: Column(
//   children: [
//   FloatingActionButton(
//   backgroundColor: Colors.orange.shade50,
//   mini: true,
//   onPressed: () {
//   gmc!.animateCamera(CameraUpdate.zoomIn());
//   },
//   child: Icon(Icons.add, color: Colors.indigo[900]),
//   ),
//   SizedBox(height: 5),
//   FloatingActionButton(
//   backgroundColor: Colors.orange.shade50,
//   mini: true,
//   onPressed: () {
//   gmc!.animateCamera(CameraUpdate.zoomOut());
//   },
//   child: Icon(Icons.remove, color: Colors.indigo[900]),
//   ),
//   ],
//   ),
//   ),
//   ],
//   ),
//   ),
//   ],
//   ),
//   ),
//   );
//   }

//   @override
//   void initState() {
//   initialStream();
//   _loadMarkers();
//   super.initState();
//   }

//   @override
//   void dispose(){
//   positionStream!.cancel();
//   super.dispose();
//   }
//   Future<void> _loadMarkers() async {
//   List<Marker> checkpointMarkers = await convertToMarkers(context);
//   setState(() {
//   markers = checkpointMarkers;
//   });
//   }
//   }

//   class profileinfo {
//   static int user_id = Globals.userId;
//   static String userEmail = Globals.userEmail;
//   static String name = Globals.name;
//   static String username = Globals.username;
//   static String password = Globals.password;
//   static String profile_picture_url = Globals.profile_picture_url;
//   static double x_position = 0.0;
//   static double y_position = 0.0;
//   static bool Location= true;
//   }

//   class pathinfo {
//   static int user_id = profileinfo.user_id;
//   static String name = profileinfo.name;
//   static String username = profileinfo.username;
//   static int p = checkpointinfo.checkpointid;
//   }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hello_world/GetChekpoints.dart';
import 'package:hello_world/LogIn.dart';

void main() {
  runApp(MyMapApp());
}

class MyMapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

      home: MapApp(),
    );
  }
}

class MapApp extends StatefulWidget {
  const MapApp({Key? key}) : super(key: key);

  @override
  State<MapApp> createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  StreamSubscription<Position>? positionStream;
  GoogleMapController? gmc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Marker> markers = [];
  List<Marker> filteredMarkers = []; // For filtered markers
  TextEditingController searchController = TextEditingController();

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(32.153844, 35.266756),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    initialStream();
    _loadMarkers();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
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
                Navigator.of(context).pop();
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
            // Handle navigation logic here
            // You may need to adjust how you navigate based on the selected index
            // For example, use Navigator.push or manipulate selectedindex
          });
        },
        currentIndex: 1,
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
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MarkerSearchDelegate(filteredMarkers, filterMarkers),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
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
                    markers: filteredMarkers.toSet(),
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
    // Assuming convertToMarkers is defined elsewhere to load markers
    List<Marker> checkpointMarkers = await convertToMarkers(context);
    setState(() {
      markers = checkpointMarkers;
      filteredMarkers = markers; // Initialize filtered markers with all markers
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
}

class MarkerSearchDelegate extends SearchDelegate<String> {
  final List<Marker> markers;
  final Function(String) filterCallback;

  MarkerSearchDelegate(this.markers, this.filterCallback);

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
        : markers.where((marker) {
            return marker.infoWindow.title!.toLowerCase().contains(query.toLowerCase());
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        Marker marker = suggestionList[index];
        return ListTile(
          title: Text(marker.infoWindow.title!),
          onTap: () {
            filterCallback(marker.infoWindow.title!); // Apply filter
            close(context, marker.infoWindow.title!); // Close search and pass result
          },
        );
      },
    );
  }
}

class profileinfo {
  static int user_id = Globals.userId;
  static String userEmail = Globals.userEmail;
  static String name = Globals.name;
  static String username = Globals.username;
  static String password = Globals.password;
  static String profile_picture_url = Globals.profile_picture_url;
  static double x_position = 0.0;
  static double y_position = 0.0;
  static bool Location = true;
}

class pathinfo {
  static int user_id = profileinfo.user_id;
  static String name = profileinfo.name;
  static String username = profileinfo.username;
}
