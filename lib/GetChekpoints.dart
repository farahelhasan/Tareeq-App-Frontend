import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/CheckpointsInfo.dart'; 
import 'package:hello_world/Settings.dart';

StreamSubscription<Position>? positionStream;

Future<List<Marker>> convertToMarkers(BuildContext context) async {
  try {
    List<Map<String, dynamic>> checkpointsData = await ApiService.checkpointsListController();
    List<Marker> markers = [];
    // the first for loop is to make the ceckpoints list appear in the map as a markers.
    for (var checkpointData in checkpointsData) {
      markers.add(
        Marker(
          markerId: MarkerId(checkpointData['checkpoint_id'].toString()),
          position: LatLng(
            checkpointData['x_position'],
            checkpointData['y_position'],
          ),
          infoWindow: InfoWindow(
            title: checkpointData['name'],
            snippet: checkpointData['status_in'],
            anchor: Offset(0.5, 0.5),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckpointDetailsBody()),
              );
              checkpointinfo.checkpointid = checkpointData['checkpoint_id'];
              checkpointinfo.name = checkpointData['name'];
              checkpointinfo.x_position = checkpointData['x_position'];
              checkpointinfo.y_position = checkpointData['y_position'];
              checkpointinfo.status_in = checkpointData['status_in'];
              checkpointinfo.status_out= checkpointData['status_out'];
              checkpointinfo.average_time_in= checkpointData['average_time_in'];
              checkpointinfo.average_time_out= checkpointData['average_time_out'];
              checkpointinfo.updatedAt = checkpointData['updatedAt'];
              //+ avarage time in and out
              // //هون بصير كل ما يرجع حاجز يحسب معه
              print('hiiiiiiii -------------------------------');

             // startTrackingPosition();
           
            },
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    }
    // the secound for loop is to loop in all checkpoint to calculate waiting time when the user start tracking.
    for (var checkpointData in checkpointsData) {
      checkpointinfo.x_position = checkpointData['x_position'];
      checkpointinfo.y_position = checkpointData['y_position'];
      checkpointinfo.checkpointid = checkpointData['checkpoint_id'];
    //  startTrackingPosition();

    }
    startTrackingPosition();
    return markers;
  } catch (e) {
    print("Error in convertToMarkers: $e");
    return [];
  }
}



 void startTrackingPosition() {
        checkpointinfo.waitingTime = 0.0; // Reset avgtime
        checkpointinfo.y_start =0.0;
        checkpointinfo.x_start =0.0;
  positionStream?.cancel();
  positionStream = Geolocator.getPositionStream().listen((Position position) {
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      checkpointinfo.x_position,
      checkpointinfo.y_position,
    );
                
    if(distanceInMeters <= 1000) {
        // to know the direction later.
        if((checkpointinfo.y_start == 0.0 )&&( checkpointinfo.x_start == 0.0)){
          checkpointinfo.y_start =  position.longitude;
          checkpointinfo.x_start =  position.latitude;
             //  double g = checkpointinfo.x_start;
              //  print('x start: $g' );
              //    print(checkpointinfo.y_start);
          checkpointinfo.startTime = DateTime.now();
                DateTime? t = checkpointinfo.startTime ;
                print('x s1 $t');
        }

        
           //     print(checkpointinfo.startTime );
           //     print('distance: $distanceInMeters.abs()');
       if ((distanceInMeters).abs() < 10 ) {
            //            print("finish--------" );
     
    //    print('x sfinsh $h');
        // y increase 
        if( (position.longitude - checkpointinfo.y_start) > 0 ){
          checkpointinfo.y_sign = '+';
        }else { //y decrease
          checkpointinfo.y_sign = '-';
        }
        // x increass
        if( (position.latitude - checkpointinfo.x_start) > 0 ){
          checkpointinfo.x_sign = '+';
        }else { // x decrease
          checkpointinfo.x_sign = '-';
        }
         String d = checkpointinfo.x_sign;
         String r = checkpointinfo.y_sign;
               

      //  print('x sign: $d y sign: $r');


        ///////////////////////////////////////////////
        DateTime arrivalTime = DateTime.now();

          print('x s2 $arrivalTime');
        Duration timeDifference = arrivalTime.difference(checkpointinfo.startTime!);
        int minutes = timeDifference.inMinutes;
        int seconds = timeDifference.inSeconds % 60;
     //   print('Time taken after arrival: $minutes minutes and $seconds seconds');
        double totalTimeInMinutes = minutes + (seconds / 60);
        ///////////////////////////////////////////////
        checkpointinfo.waitingTime = totalTimeInMinutes; ////////////
        print('x s $totalTimeInMinutes' );
        print('x sign: $d y sign: $r');
       // print('x s  ')

        // call the function to make request.
      ApiService.setWaitingTime(checkpointinfo.checkpointid, checkpointinfo.waitingTime, profile.user_id, checkpointinfo.x_sign, checkpointinfo.y_sign)
      .then((value) => {
       print('response: $value')
       }
      ) ;
      }
    } else if(distanceInMeters > 1000){
        checkpointinfo.waitingTime = 0.0; // Reset avgtime
        checkpointinfo.y_start =0.0;
        checkpointinfo.x_start =0.0;

    } else {
        print('Timer off');
    }
  }); // listen 
}

class checkpointinfo{
  static int checkpointid = 0;
  static String name='';
  static String status_in='';
  static String status_out='';
  static double x_position =0.0;
  static double y_position =0.0;
  static String updatedAt ='';
  static double waitingTime=0.0;
  static DateTime? startTime;
  static double x_start=0.0;
  static double y_start=0.0;
  static String x_sign='';
  static String y_sign='';
  static double average_time_in=0.0;
  static double average_time_out=0.0;

}
