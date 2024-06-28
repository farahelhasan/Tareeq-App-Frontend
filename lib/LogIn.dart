//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hello_world/HomePageUserMobile.dart';
import 'package:hello_world/HomePageWeb.dart';
import 'package:hello_world/MapPageUser.dart';
import 'package:hello_world/Signup.dart';
import 'package:hello_world/Welcom.dart';
import 'package:hello_world/ApiService.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  kIsWeb ? loginweb() : login(),
    );
  }
}


class SharedComponents {
  static Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text('ليس موجود'),
            ],
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ربما البريد الالكتروني او كلمة السر خاطئة'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('حسنا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// ignore: must_be_immutable
class loginweb extends StatelessWidget {
  loginweb({super.key});
  final GlobalKey<FormState> emailstate = GlobalKey();
  final GlobalKey<FormState> passwordstate = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Center(
        child: Container(
          width: 600,
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "البريد الالكتروني",
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Form(
                      key: emailstate,
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الحقل فارغ";
                                }
                                if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
                                  return 'البريد الإلكتروني غير صحيح';
                                } else {
                                  email = value.toString();
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.indigo[900],
                                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.email, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "كلمة المرور",
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Form(
                      key: passwordstate,
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الحقل فارغ";
                                }
                                if (value.length < 8) {
                                  return "لا يجب ان تكون كلمة المرور اقل من 8 ";
                                } else {
                                  password = value.toString();
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.indigo[900],
                                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.lock, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            if (emailstate.currentState!.validate() & passwordstate.currentState!.validate()) {
                              ApiService.loginController(email.toString(), password.toString()).then((response) {
                                if (response['success']) {
                                  var userData = response['data'];
                                  Globals.userId = userData['user_id'];
                                  Globals.userEmail = userData['email'];
                                  Globals.name = userData['name'];
                                  Globals.password = userData['password'];
                                  Globals.username = userData['username'];
                                  Globals.profile_picture_url = userData['profile_picture_url'];

                                  if (userData['user_id'] == 1) {
                                    Globals.ifadmin=true;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePageWeb()),
                                    );
                                  } else {
                                    Globals.ifadmin=false;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyMapAppUser()),
                                    );
                                  }
                                } else {
                                  SharedComponents.showMyDialog(context);
                                }
                              }).catchError((error) {
                                print('Error: $error');
                                SharedComponents.showMyDialog(context);
                              });
                            } else {
                              SharedComponents.showMyDialog(context);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 45,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.indigo[900],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'تسجيل الدخول',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              ":تسجيل الدخول بواسطة",
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    'images/facebook_logo.png',
                                    width: 35,
                                    height: 35,
                                    color: Colors.indigo[900],
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    'images/google_logo.png',
                                    width: 35,
                                    height: 35,
                                    color: Colors.indigo[900],
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    'images/instagram_logo.png',
                                    width: 35,
                                    height: 35,
                                    color: Colors.indigo[900],
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    'images/linkedin_logo.png',
                                    width: 35,
                                    height: 35,
                                    color: Colors.indigo[900],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            " ليس لديك حساب ؟",
                            style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 20,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupWeb()),
                              );
                              emailController.clear();
                              passwordController.clear();
                            },
                            child: Column(
                              children: [
                                Text(
                                  "انشاء حساب",
                                  style: TextStyle(
                                    color: Colors.indigo[900],
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 0.1),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[900],
                                  ),
                                  child: SizedBox(width: 80, height: 1),
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
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class login extends StatelessWidget {
login({super.key});
GlobalKey<FormState> emailstate = GlobalKey();
GlobalKey<FormState> passwordstate = GlobalKey();

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

String? email;
String? password;

@override
Widget build(BuildContext context) {
 Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red), 
            SizedBox(width: 8), 
            Text('ليس موجود'),
          ],
        ),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('ربما البريد الالكتروني او كلمة السر خاطئة' ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('حسنا'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

return Scaffold(
backgroundColor: Colors.indigo[900],
body: Container(
child: ListView(
children: [
//icon arrow back 
Padding(
padding: const EdgeInsets.all(10.0),
child: Align(
alignment: Alignment.centerLeft,
child: Container(
width: 50,
height: 50,
child: IconButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => Welcome()),
);
},
icon: Icon(
Icons.arrow_back_ios_new_rounded,
size: 30,
color: Colors.white,
),
),
),
),
),
//space 
Container(
height: 200,
alignment:Alignment.center
,
child:  Image.asset("images/gpssystem.png", width: 300),
),
//container with information
Container(
height: 600,
//decoration for info container-----------------------------------
decoration: BoxDecoration(
color: Color.fromARGB(255, 255, 255, 255),
borderRadius: BorderRadius.only(
topLeft: Radius.circular(50),
topRight: Radius.circular(50),
),
),
//----------------------------------------------------------------         
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
//log in page(تسجيل الدخول)--------------------------------------      
Container(
padding: EdgeInsets.all(15),
child:
Row(
mainAxisAlignment: MainAxisAlignment.end,
children: [
Text(
"تسجيل الدخول",
style: TextStyle(
color: Colors.indigo[900],
fontSize: 30,
fontWeight: FontWeight.bold,
),
)
],
),
),
//-------------------------------------------------------------

//log in page(البريد الالكتروني)----------------------------------     
Center(
child: Container(
padding: const EdgeInsets.only(top: 5, bottom: 10,right: 20),
child: 
Row(
mainAxisAlignment: MainAxisAlignment.end,
children: [
Text(
"البريد الالكتروني",
style: TextStyle(
color: Colors.indigo[900],
fontSize: 20,
fontWeight: FontWeight.bold,
),
)
],
),
),
),
//----------------------------------------------------------------      
Form(
key: emailstate,
child: Center(
child: Align(
alignment: Alignment.centerRight,
child: Padding(
padding: const EdgeInsets.only(top: 5, bottom: 15, right: 15, left: 15),
child: TextFormField(
controller: emailController,
validator: (value){
if(value!.isEmpty){
return "الحقل فارغ";
}
if (!RegExp( r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
return 'البريد الإلكتروني غير صحيح';
}
else{
email = value.toString();
return null;
}
},
style: TextStyle(color: Colors.white),
decoration: InputDecoration(
filled: true,
fillColor: Colors.indigo[900],
contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(50),
borderSide: BorderSide.none,
),
suffixIcon: Padding(
padding: const EdgeInsets.all(8.0),
child: Icon(Icons.email, color: Colors.white),
),
),
),
),
),
),
),
//----------------------------------------------------------------------
//log in page( كلمة المرور)--------------------------------------
Center(
child: Container(
padding: const EdgeInsets.only(top: 5, bottom: 10,right: 20),
child: Row(
mainAxisAlignment: MainAxisAlignment.end,
children: [
Text(
"كلمة المرور",
style: TextStyle(
color: Colors.indigo[900],
fontSize: 20,
fontWeight: FontWeight.bold,
),
)
],
),
),
),
//----------------------------------------------------------------
//
Form(
key: passwordstate,
child: Center(
child: Align(
alignment: Alignment.centerRight,
child: Padding(
padding: const EdgeInsets.only(top: 5, bottom: 15, right: 15, left: 15),
child: TextFormField(
obscureText: true,
controller: passwordController,
validator: (value){
if(value!.isEmpty){
return "الحقل فارغ";
}
if (value.length < 8) {
return "لا يجب ان تكون كلمة المرور اقل من 8 ";
}
else{
password = value.toString();
return null;
}
},
style: TextStyle(color: Colors.white),
decoration: InputDecoration(
filled: true,
fillColor: Colors.indigo[900],
contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(50),
borderSide: BorderSide.none,
),
suffixIcon: Padding(
padding: const EdgeInsets.all(8.0),
child: Icon(Icons.lock, color: Colors.white),
),
),
),
),
),
),
),     


Container(
height: 10,
),

//login  
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
MaterialButton(
onPressed: () async {
if(emailstate.currentState!.validate()&passwordstate.currentState!.validate()){ 
ApiService.loginController(email.toString(), password.toString()).then((response) {
  if (response['success']) {
    var message = response['message'];
    var userData = response['data'];
    print('Message: $message');
    print('User Data: $userData'); 

    var userId = userData['user_id'];
    var name = userData['name'];
    var email = userData['email'];
    var password = userData['password'];
    var username = userData['username'];
    var profile_picture_url = userData['profile_picture_url'];
    
    Globals.userId = userId;
    Globals.userEmail = email;
    Globals.name = name;
    Globals.password = password;
    Globals.username = username;
    Globals.profile_picture_url = profile_picture_url;
    print('User ID: $userId');
    print('Name: $name'); 

    print('Email: $email');  
    print('picture: $profile_picture_url');  
    if (userId == 1) {
    Globals.ifadmin = true;
    }else{
    Globals.ifadmin = false;
    }
    if(Globals.ifadmin){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Homepageusermobile()),
    );
    }
    else{  
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyMapAppUser()),
    );
    }

  }
  else {
    _showMyDialog();
    var errorMessage = response['message'];
    print('Error Message: $errorMessage');
  }


}).catchError((error) {
  print('Error: $error');
    _showMyDialog();
});
}else{
_showMyDialog();
print("not valid");
}
},
child: Container(
padding: EdgeInsets.all(10),
height: 45,
width: 160,
decoration: BoxDecoration(
color: Colors.indigo[900],
borderRadius: BorderRadius.circular(30),
),
child: Text(
'تسجيل الدخول',
textAlign: TextAlign.center,
style: TextStyle(
color: Colors.white,
fontSize: 18,
),
),
),
),
],
),

Padding(
padding: EdgeInsets.only(top: 15, bottom: 10),
child: Column(
children: [
SizedBox(height: 0.1),
Center(
child: DecoratedBox(
decoration: BoxDecoration(
color: Colors.indigo[900], 
),
child: SizedBox(width: 350, height: 1), 
),
),
],
),
),

//-----------------تسجيل الدخول بواسطة:---------------------------
Center(
child: 
Padding(
padding: const EdgeInsets.all(8.0),
child: Container(    
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Padding(
padding: const EdgeInsets.all(8.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
":تسجيل الدخول بواسطة",
style: TextStyle(
color: Colors.indigo[900],
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
],
),
),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
GestureDetector(
onTap: () {},
child: Image.asset(
'images/facebook_logo.png',
width: 35,
height: 35,
color: Colors.indigo[900],
),
),
SizedBox(width: 15),
GestureDetector(
onTap: () {},
child: Image.asset(
'images/google_logo.png',
width: 35,
height: 35,
color: Colors.indigo[900],
),
),
SizedBox(width: 15),
GestureDetector(
onTap: () {},
child: Image.asset(
'images/instagram_logo.png',
width: 35,
height: 35,
color: Colors.indigo[900],
),
),
SizedBox(width: 15),
GestureDetector(
onTap: () {},
child: Image.asset(
'images/linkedin_logo.png',
width: 35,
height: 35,
color: Colors.indigo[900],
),
),
SizedBox(width: 15),
],
),
],
),
),
),
),

//---------------------------------------------------------------- 
//----------------------------------------------------------------
//ليس لديك حساب--------------------------------------------------
Padding(
padding: const EdgeInsets.all(4.0),
child: Container(
child: 
Align(
alignment: Alignment.center,
child: Column(
children: [
Text(" ليس لديك حساب ؟", 
style: TextStyle(
color: Colors.indigo[900], 
fontSize: 16)),

GestureDetector(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => Signup()),
);
emailController.clear();
passwordController.clear();

},
child: Column(
children: [
Text(
"انشاء حساب",
style: TextStyle(
color: Colors.indigo[900],
fontSize: 16,
),
),
SizedBox(height: 0.1),
DecoratedBox(
decoration: BoxDecoration(
color: Colors.indigo[900],
),
child: SizedBox(width: 80, height: 1),
),
],
),
),




],
),
),
),
)
],
),
),
//---------------------------------------------------------------
],
),
),
);
}
}


class Globals {
  static int userId = 0;
  static String userEmail = ''; 
  static String name = '';
  static String username = ''; 
  static String password = '';
  static String profile_picture_url = '';
  static bool ifadmin = false; 
}
