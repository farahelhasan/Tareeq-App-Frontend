import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hello_world/LogIn.dart';
import 'package:hello_world/ApiService.dart';
import 'package:image_picker/image_picker.dart';


// class SharedComponents {
//   static Future<void> showMyDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Row(
//             children: [
//               Icon(Icons.warning, color: Colors.red),
//               SizedBox(width: 8),
//               Text('ليس موجود'),
//             ],
//           ),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('يبدو ان هذا البريد الالكتروني موجود مسبقاً'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('حسنا'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// // ignore: must_be_immutable
// class SignupWeb extends StatelessWidget {
//   SignupWeb({Key? key}) : super(key: key);

//   final GlobalKey<FormState> namestate = GlobalKey<FormState>();
//   final GlobalKey<FormState> emailstate = GlobalKey<FormState>();
//   final GlobalKey<FormState> passwordstate = GlobalKey<FormState>();
//   final GlobalKey<FormState> usernamestate = GlobalKey<FormState>();

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController profilepictureController = TextEditingController();

//   String? lastName;
//   String? firstName;
//   String? name;
//   String? username;
//   String? email;
//   String? password;
//   String? profile_picture_url;

//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       profilepictureController.text = pickedFile.path;
//       profile_picture_url = profilepictureController.text;
//     } else {
//       print('No image selected.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo[900],
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(20),
//           child: Container(
//             width: 600,
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 50),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         "انشاء حساب",
//                         style: TextStyle(
//                           color: Colors.indigo[900],
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 buildTextField(
//                   context,
//                   "الاسم",
//                   namestate,
//                   nameController,
//                   (value) {
//                     if (value!.isEmpty) {
//                       return "الحقل فارغ";
//                     } else {
//                       List<String> parts = value.split(' ');
//                       if (parts.length < 2) {
//                         return "يجب ادخال الاسم الاول والاسم الاخير";
//                       } else {
//                         firstName = parts[0];
//                         lastName = parts[parts.length - 1];
//                         name = value;
//                         return null;
//                       }
//                     }
//                   },
//                   Icons.supervised_user_circle,
//                 ),
//                 buildTextField(
//                   context,
//                   "اسم المستخدم",
//                   usernamestate,
//                   usernameController,
//                   (value) {
//                     if (value!.isEmpty) {
//                       return "الحقل فارغ";
//                     } else {
//                       username = value;
//                       return null;
//                     }
//                   },
//                   Icons.person,
//                 ),
//                 buildTextField(
//                   context,
//                   "البريد الالكتروني",
//                   emailstate,
//                   emailController,
//                   (value) {
//                     if (value!.isEmpty) {
//                       return "الحقل فارغ";
//                     }
//                     if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
//                       return 'البريد الإلكتروني غير صحيح';
//                     } else {
//                       email = value;
//                       return null;
//                     }
//                   },
//                   Icons.email,
//                 ),
//                 buildTextField(
//                   context,
//                   "كلمة المرور",
//                   passwordstate,
//                   passwordController,
//                   (value) {
//                     if (value!.isEmpty) {
//                       return "الحقل فارغ";
//                     }
//                     if (value.length < 8) {
//                       return "لا يجب ان تكون كلمة المرور اقل من 8 ";
//                     } else {
//                       password = value;
//                       return null;
//                     }
//                   },
//                   Icons.lock,
//                   obscureText: true,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.indigo[900],
//                       ),
//                       child: IconButton(
//                         onPressed: pickImage,
//                         icon: Icon(Icons.image, color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Text(
//                         ":الصورة الشخصية",
//                         style: TextStyle(
//                           color: Colors.indigo[900],
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: MaterialButton(
//                     onPressed: () async {
//                       if (namestate.currentState!.validate() &&
//                           usernamestate.currentState!.validate() &&
//                           emailstate.currentState!.validate() &&
//                           passwordstate.currentState!.validate()) {
//                         try {
//                           final response = await ApiService.signupController(
//                             email!,
//                             password!,
//                             username!,
//                             name!,
//                             profile_picture_url!,
//                           );
//                           print(response);
//                           print(name);
//                           print(username);
//                           print(password);
//                           print(email);
//                           print(profile_picture_url);
//                           print("valid");
//                           passwordController.clear();
//                           nameController.clear();
//                           emailController.clear();
//                           usernameController.clear();
//                           profilepictureController.clear();
//                         } catch (e) {
//                           print('Error: $e');
//                           SharedComponents.showMyDialog(context);
//                         }
//                       } else {
//                         print('not valid');
//                       }
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(5),
//                       height: 45,
//                       width: 160,
//                       decoration: BoxDecoration(
//                         color: Colors.indigo[900],
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Text(
//                         'انشاء حساب',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => kIsWeb ? loginweb() : login()),
//                           );
//                         },
//                         child: Text(
//                           "تسجيل الدخول",
//                           style: TextStyle(
//                             color: Colors.indigo[900],
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         "لديك حساب بالفعل؟ ",
//                         style: TextStyle(
//                           color: Colors.indigo[900],
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(BuildContext context, String label, GlobalKey<FormState> key, TextEditingController controller, String? Function(String?) validator, IconData icon, {bool obscureText = false}) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.only(top: 2, bottom: 5, right: 20),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color: Colors.indigo[900],
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             Form(
//               key: key,
//               child: Center(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     child: TextFormField(
//                       controller: controller,
//                       validator: validator,
//                       obscureText: obscureText,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.indigo[900],
//                         contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(50),
//                           borderSide: BorderSide.none,
//                         ),
//                         suffixIcon: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Icon(icon, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class SignupMobile extends StatelessWidget {
//   SignupMobile({Key? key}) : super(key: key);

//   final GlobalKey<FormState> namestate = GlobalKey<FormState>();
//   final GlobalKey<FormState> emailstate = GlobalKey<FormState>();
//   final GlobalKey<FormState> passwordstate = GlobalKey<FormState>();
//   final GlobalKey<FormState> usernamestate = GlobalKey<FormState>();

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController profilepictureController = TextEditingController();

//   String? lastName;
//   String? firstName;
//   String? name;
//   String? username;
//   String? email;
//   String? password;
//   String? profile_picture_url;

//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       profilepictureController.text = pickedFile.path;
//       profile_picture_url = profilepictureController.text;
//     } else {
//       print('No image selected.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo[900],
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => login()),
//                       );
//                       emailController.clear();
//                       passwordController.clear();
//                       usernameController.clear();
//                       nameController.clear();
//                     },
//                     icon: Icon(
//                       Icons.arrow_back_ios_new_rounded,
//                       size: 30,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 50),
//             Container(
//               height: 150,
//               alignment: Alignment.center,
//               child: Image.asset("images/gpssystem.png", width: 300),
//             ),
//             Container(
//               padding: EdgeInsets.all(10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     "انشاء حساب",
//                     style: TextStyle(
//                       color: Colors.indigo[900],
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             buildTextField(
//               context,
//               "الاسم",
//               namestate,
//               nameController,
//               (value) {
//                 if (value!.isEmpty) {
//                   return "الحقل فارغ";
//                 } else {
//                   List<String> parts = value.split(' ');
//                   if (parts.length < 2) {
//                     return "يجب ادخال الاسم الاول والاسم الاخير";
//                   } else {
//                     firstName = parts[0];
//                     lastName = parts[parts.length - 1];
//                     name = value;
//                     return null;
//                   }
//                 }
//               },
//               Icons.supervised_user_circle,
//             ),
//             buildTextField(
//               context,
//               "اسم المستخدم",
//               usernamestate,
//               usernameController,
//               (value) {
//                 if (value!.isEmpty) {
//                   return "الحقل فارغ";
//                 } else {
//                   username = value;
//                   return null;
//                 }
//               },
//               Icons.person,
//             ),
//             buildTextField(
//               context,
//               "البريد الالكتروني",
//               emailstate,
//               emailController,
//               (value) {
//                 if (value!.isEmpty) {
//                   return "الحقل فارغ";
//                 }
//                 if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
//                   return 'البريد الإلكتروني غير صحيح';
//                 } else {
//                   email = value;
//                   return null;
//                 }
//               },
//               Icons.email,
//             ),
//             buildTextField(
//               context,
//               "كلمة المرور",
//               passwordstate,
//               passwordController,
//               (value) {
//                 if (value!.isEmpty) {
//                   return "الحقل فارغ";
//                 }
//                 if (value.length < 8) {
//                   return "لا يجب ان تكون كلمة المرور اقل من 8 ";
//                 } else {
//                   password = value;
//                   return null;
//                 }
//               },
//               Icons.lock,
//               obscureText: true,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.indigo[900],
//                   ),
//                   child: IconButton(
//                     onPressed: pickImage,
//                     icon: Icon(Icons.image, color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     ":الصورة الشخصية",
//                     style: TextStyle(
//                       color: Colors.indigo[900],
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: MaterialButton(
//                 onPressed: () async {
//                   if (namestate.currentState!.validate() &&
//                       usernamestate.currentState!.validate() &&
//                       emailstate.currentState!.validate() &&
//                       passwordstate.currentState!.validate()) {
//                     try {
//                       final response = await ApiService.signupController(
//                         email!,
//                         password!,
//                         username!,
//                         name!,
//                         profile_picture_url!,
//                       );
//                       print(response);
//                       print(name);
//                       print(username);
//                       print(password);
//                       print(email);
//                       print(profile_picture_url);
//                       print("valid");
//                       passwordController.clear();
//                       nameController.clear();
//                       emailController.clear();
//                       usernameController.clear();
//                       profilepictureController.clear();
//                     } catch (e) {
//                       print('Error: $e');
//                       SharedComponents.showMyDialog(context);
//                     }
//                   } else {
//                     print('not valid');
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   height: 45,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.indigo[900],
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Text(
//                     'تسجيل الدخول',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => login()),
//                       );
//                     },
//                     child: Text(
//                       "انشاء حساب",
//                       style: TextStyle(
//                         color: Colors.indigo[900],
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     "لديك حساب بالفعل؟ ",
//                     style: TextStyle(
//                       color: Colors.indigo[900],
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(BuildContext context, String label, GlobalKey<FormState> key, TextEditingController controller, String? Function(String?) validator, IconData icon, {bool obscureText = false}) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.only(top: 2, bottom: 5, right: 20),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color: Colors.indigo[900],
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             Form(
//               key: key,
//               child: Center(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     child: TextFormField(
//                       controller: controller,
//                       validator: validator,
//                       obscureText: obscureText,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.indigo[900],
//                         contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(50),
//                           borderSide: BorderSide.none,
//                         ),
//                         suffixIcon: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Icon(icon, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// ignore: must_be_immutable
class Signup extends StatelessWidget {
Signup({Key? key}) : super(key: key);

final GlobalKey<FormState> namestate = GlobalKey<FormState>();
final GlobalKey<FormState> emailstate = GlobalKey<FormState>();
final GlobalKey<FormState> passwordstate= GlobalKey<FormState>();
final GlobalKey<FormState> usernamestate= GlobalKey<FormState>();
final GlobalKey<FormState> profilepicturestate = GlobalKey<FormState>();

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController profilepictureControllere = TextEditingController();

String? lastName;
String? firstName;
String? name;
String? username;
String? email;
String? password;
String? profile_picture_url;

  Future<void> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);
  if (pickedFile != null) {
  profilepictureControllere.text = pickedFile.path;
  profile_picture_url = profilepictureControllere.text;

  } else {
  print('No image selected.');
  }
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: Colors.indigo[900],
  body: Container(
  child: ListView(
  children: [
  Padding(
  padding: const EdgeInsets.all(8.0),
  child: Align(
  alignment: Alignment.centerLeft,
  child: Container(
  width: 25,
  height: 25,
  child: IconButton(
  onPressed: () {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => login()),
  );
  emailController.clear();
  passwordController.clear();
  usernameController.clear();
  nameController.clear();
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

  // Logo
  Container(
  height: 120,
  alignment: Alignment.center,
  child: Image.asset("images/gpssystem.png", width: 300),
  ),
  // Sign-up information
  Container(
  height: 900,
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
  topLeft: Radius.circular(50),
  topRight: Radius.circular(50),
  ),
  ),


  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [   
  Container(
  padding: EdgeInsets.only(right: 15, bottom: 5, top: 10,),
  child:
  Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
  Text(
  "انشاء حساب",
  style: TextStyle(
  color: Colors.indigo[900],
  fontSize: 30,
  fontWeight: FontWeight.bold,
  ),
  )
  ],
  ),
  ),

  Center(
  child: Container(
  padding: const EdgeInsets.only(top: 2, bottom: 5,right: 20),
  color: Colors.white,
  child: 
  Column(
  children: [
  Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
  Text(
  "الاسم",
  style: TextStyle(
  color: Colors.indigo[900],
  fontSize: 20,
  fontWeight: FontWeight.bold,
  ),
  )
  ],
  ),
  ],
  ),
  ),
  ),
  Form(
  key: namestate,
  child: Center(
  child: Align(
  alignment: Alignment.centerRight,
  child: Padding(
  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
  child: TextFormField(
  controller:nameController,
  textAlign: TextAlign.right,
  validator: (value){
  if (value!.isEmpty) {
  return "الحقل فارغ";
  } else {
  // Split the input into parts
  List<String> parts = value.split(' ');
  if (parts.length < 2) {
  return "يجب ادخال الاسم الاول والاسم الاخير";
  } else {
  firstName = parts[0];
  lastName = parts[parts.length - 1];
  name = value;
  return null;
  }
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
  child: Icon(Icons.supervised_user_circle, color: Colors.white),
  ),
  ),
  ),
  ),
  ),
  ),
  ),

  Center(
  child: Container(
  padding: const EdgeInsets.only(top: 2, bottom: 5,right: 20),
  child: 
  Column(
  children: [
  Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
  Text(
  "اسم المستخدم",
  style: TextStyle(
  color: Colors.indigo[900],
  fontSize: 20,
  fontWeight: FontWeight.bold,
  ),
  )
  ],
  ),
  ],
  ),
  ),
  ),
  Form(
  key: usernamestate,
  child: Center(
  child: Align(
  alignment: Alignment.centerRight,
  child: Padding(
  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
  child: TextFormField(
  controller:usernameController,
    textAlign: TextAlign.right,
  validator: (value){
  if(value!.isEmpty){
  return "الحقل فارغ";
  }else{
  username = value.toString();
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
  child: Icon(Icons.person, color: Colors.white),
  ),
  ),
  ),
  ),
  ),
  ),
  ),


  Center(
  child: Container(
  padding: const EdgeInsets.only(top: 2, bottom: 5,right: 20),
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
  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
  child: TextFormField(
  controller:emailController,
  validator: (value){
  if(value!.isEmpty){
  return "الحقل فارغ";
  }
  if (!RegExp( r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
  return 'البريد الإلكتروني غير صحيح';
  }else{
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
  padding: const EdgeInsets.only(top: 2, bottom: 5,right: 20),
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
  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
  child: TextFormField(
  obscureText: true,
  controller:passwordController,
  validator: (value){

  if(value!.isEmpty){
  return "الحقل فارغ";
  }
  if (value.length < 8) {
  return "لا يجب ان تكون كلمة المرور اقل من 8 ";
  }else{
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

  // Profile Picture
  Center(
  child: Container(
  padding: const EdgeInsets.only(top: 2, bottom: 5, right: 20),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
  Container(
  decoration: BoxDecoration(
  shape: BoxShape.circle,
  color: Colors.indigo[900],
  ),
  child: IconButton(
  onPressed: pickImage,
  icon: Icon(Icons.image, color: Colors.white),
  ),
  ),
  SizedBox(width: 10),
  Padding(
  padding: const EdgeInsets.only(left: 10),
  child: Text(
  ":الصورة الشخصية",
  style: TextStyle(
  color: Colors.indigo[900],
  fontSize: 20,
  fontWeight: FontWeight.bold,
  ),
  ),
  ),
  ],
  ),
  ),
  ),


  Container(
  height: 3,
  ),

  //login  
  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  MaterialButton(
  onPressed: () async {
    
  // Function to show dialog for invalid email or password
Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red), 
            SizedBox(width: 8), 
            Text(' حدث خطأ'),
          ],
        ),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('يبدو ان هذا البريد الالكتروني موجود مسبقاً'),
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
if (namestate.currentState!.validate() &&
    usernamestate.currentState!.validate() &&
    emailstate.currentState!.validate() &&
    passwordstate.currentState!.validate()) {
  try {
    final response = await ApiService.signupController(
      email!,
      password!,
      username!,
      name!,
      profile_picture_url!,
    );
    print(response);
    print(name);
    print(username);
    print(password);
    print(email);
    print(profile_picture_url);
    print("valid");
    passwordController.clear();
    nameController.clear();
    emailController.clear();
    usernameController.clear();
    profilepictureControllere.clear();
    }
     catch (e) {
    print('Error: $e');
    _showMyDialog(context);
  }
} else {
  print('not valid');
}
  },
  child: Container(
  padding: EdgeInsets.all(5),
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


  Container(
  padding: EdgeInsets.symmetric(vertical: 20),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  GestureDetector(
  onTap: () {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => login()),
  );
  },
  child: Text(
  "تسجيل الدخول",
  style: TextStyle(
  color: Colors.indigo[900],
  fontSize: 16,
  fontWeight: FontWeight.bold,
  ),
  ),
  ),
  Text(
  "لديك حساب بالفعل؟ ",
  style: TextStyle(
  color: Colors.indigo[900],
  fontSize: 16,
  ),
  ),
  ],
  ),
  ),
  ],
  ),
  ),
  ])
  )
  );
  
  
  
  }

  
  }