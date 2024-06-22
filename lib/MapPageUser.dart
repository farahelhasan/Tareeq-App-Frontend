import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/HomePageUserMobile.dart';
import 'package:hello_world/HomePageUserWeb.dart';
import 'package:hello_world/LogIn.dart';

  void main() {
  runApp(MyMapAppUser());
  }

  class MyMapAppUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
      debugShowCheckedModeBanner: false,

  home: kIsWeb ?  Homepageuserweb() : Homepageusermobile(),
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
  static bool Location= true;
  }

class pathinfo {
  static int user_id = profileinfo.user_id;
  static String name = profileinfo.name;
  static String username = profileinfo.username;
  }
