import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:hello_world/GetChekpoints.dart';
import 'package:hello_world/MapPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MapAppWeb(),
  ));
}

class MapAppWeb extends StatefulWidget {
  const MapAppWeb({Key? key}) : super(key: key);

  @override
  State<MapAppWeb> createState() => _MapAppWebState();
}

class _MapAppWebState extends State<MapAppWeb> {

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
      backgroundColor: Colors.orange.shade50,
      key: _scaffoldKey,
      appBar: AppBar(
         backgroundColor: Colors.orange.shade50,
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
  markers: filteredMarkers.toSet(), // Display filtered markers
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

  print('Filtered List: $filteredList'); // Check filtered list before setState

  setState(() {
    filteredMarkers = filteredList;
  });

  print('Filtered Markers: $filteredMarkers'); // Check filteredMarkers after setState
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

//   String htmlId = "7";
  
//   late gmaps.GMap map;
//   StreamSubscription<Position>? positionStream;
//   CameraPosition cameraPosition = CameraPosition(
//     target: gmaps_flutter.LatLng(profileinfo.x_position, profileinfo.y_position),
//     zoom: 12,
//   );
  
//   gmaps_flutter.GoogleMapController? gmc;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int selectedindex = 1;
//   List<gmaps_flutter.Marker> markers = [];

//   Future<void> initialStream() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       _showMyDialog();
//       throw Exception('الموقع لم يتم تفعيله');
//     } else {
//       permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           profileinfo.Location = false;
//           _showMyDialog();
//           throw Exception('الموقع لم يتم تفعيله');
//         }
//       }
//       if (permission == LocationPermission.deniedForever) {
//         profileinfo.Location = false;
//         _showMyDialog();
//         throw Exception('تم الغاء تفعيل الموقع يجب تفعيله');
//       }
//       if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
//         profileinfo.Location = true;
//         positionStream = Geolocator.getPositionStream().listen(
//           (Position? position) {
//             markers.add(
//               gmaps_flutter.Marker(
//                 markerId: gmaps_flutter.MarkerId("ME"),
//                 position: gmaps_flutter.LatLng(position!.latitude, position.longitude),
//               ),
//             );
//             profileinfo.x_position = position.latitude;
//             profileinfo.y_position = position.longitude;
//                addMarker(
//                  gmaps.LatLng(profileinfo.x_position , profileinfo.y_position),
//                  'Me',
//                  '',
//                );

//             setState(() {});
//           },
//         );
//       }
//     }
//   }

//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Row(
//             children: [
//               Icon(Icons.warning, color: Colors.red),
//               SizedBox(width: 8),
//               Text('الموقع ليس مفعلاً'),
//             ],
//           ),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('يجب تفعيل الموقع حتى يعمل التطبيق بشكل مناسب'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK!'),
//               onPressed: () {
//                 flutter_nav.Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     initialStream();
//     _loadMarkers();

//     // Register the custom view
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
//       final latLng = gmaps.LatLng(profileinfo.x_position, profileinfo.y_position);
//       final mapOptions = gmaps.MapOptions()
//         ..zoom = 12
//         ..center = latLng;

//       final element = DivElement()
//         ..id = htmlId
//         ..style.width = "100%"
//         ..style.height = "100%"
//         ..style.border = 'none';

//       map = gmaps.GMap(element as HTMLElement?, mapOptions);
//       return element;
//     });
//   }

//   Future<void> _loadMarkers() async {
//     try {
//       List<gmaps_flutter.Marker> checkpointMarkers = await convertToMarkers(context);
//       setState(() {
//         markers = checkpointMarkers;
//       });

//       for (var marker in checkpointMarkers) {
//         addMarker(
//           gmaps.LatLng(marker.position.latitude, marker.position.longitude),
//           marker.infoWindow.title ?? '',
//           marker.infoWindow.snippet ?? '',
//         );
//       }
//     } catch (e) {
//       print("Error loading markers: $e");
//     }
//   }

//   void addMarker(gmaps.LatLng position, String title, String snippet) {
//     final marker = gmaps.Marker(gmaps.MarkerOptions()
//       ..position = position
//       ..map = map
//       ..title = title);

//     final infoWindow = gmaps.InfoWindow(gmaps.InfoWindowOptions()
//       ..content = '<div><strong>$title</strong><br>$snippet</div>');

//     marker.onClick.listen((_) {
//       infoWindow.open(map, marker);
//     });
//   }

//   @override
//   void dispose() {
//     positionStream?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: HtmlElementView(viewType: htmlId),
//     );
//   }
// }

