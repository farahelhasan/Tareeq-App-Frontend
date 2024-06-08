import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Maps Launcher'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              _launchGoogleMaps("32.2263,35.2218"); // Pass your location here or fetch it from somewhere
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.black12,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 30, color: Colors.black),
                  SizedBox(height: 5),
                  Text(
                    "Location",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

Future<void> _launchGoogleMaps(String location) async {
  final locationn = location.isNotEmpty ? location : "32.2263,35.2218";
  final url = 'https://www.google.com/maps/search/?api=1&query=$locationn';
  try {
    await launch(url);
  } catch (e) {
    throw 'Could not launch $url: $e';
  }
}

}


  // late StreamSubscription<Position> positionStream;
  // late Future<Position> _currentPosition;

  // @override
  // void initState() {
  //   super.initState();
  //   _currentPosition = _determinePosition();
  // }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     throw Exception('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       throw Exception('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     throw Exception(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   if (permission == LocationPermission.whileInUse) {
  //     positionStream = Geolocator.getPositionStream().listen((Position position) {
  //       print("----------------------------------------------");
  //       print(position!.latitude);
  //       print(position!.longitude);
  //       print("----------------------------------------------");

  //     });
  //     return await Geolocator.getCurrentPosition();
  //   }
  //   throw Exception('Location permissions not granted');
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: Text('Geolocator Example'),
  //       ),
  //       body: Center(
  //         child: FutureBuilder<Position>(
  //           future: _currentPosition,
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return CircularProgressIndicator();
  //             } else if (snapshot.hasError) {
  //               return Text('Error: ${snapshot.error}');
  //             } else {
  //               final position = snapshot.data!;
  //               return Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text('Latitude: ${position.latitude}'),
  //                   Text('Longitude: ${position.longitude}'),
  //                 ],
  //               );
  //             }
  //           },
    //       ),
    //     ),
    //   ),
    // );
  // }

//   @override
//   void dispose() {
//     super.dispose();
//     positionStream.cancel();
//   }
// }
