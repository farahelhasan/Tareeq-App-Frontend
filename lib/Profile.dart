import 'package:flutter/material.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/MapPageUser.dart';
import 'package:hello_world/Settings.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:hello_world/ApiService.dart';
void main() {
  runApp(MaterialApp(
    home: Profile(),
  ));
}
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState(); 
}
class _ProfileState extends State<Profile> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController profilepictureControllere = TextEditingController();

  bool _obscurePassword = true;
  String? email;
  String? password;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? profile_picture_url;
  String? originalEmail;

  GlobalKey<FormState> usernameKey = GlobalKey<FormState>();
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  Future<void> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);
  if (pickedFile != null) {
  setState(() {
  //_pickedImage = File(pickedFile.path);
  });
  } else {
  print('No image selected.');
  }
  }

  @override
  void initState() {
  super.initState();
  _initializeUser();
  originalEmail = profile.userEmail;
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
  backgroundColor:Colors.indigo[900],
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
  MaterialPageRoute(builder: (context) => settings()),
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
  alignment: Alignment.center,
  child: Stack(
  alignment: Alignment.center,
  children: [
  CircleAvatar(
  radius: 80.0,
  backgroundImage:
  //_pickedImage != null
  //     ? FileImage(_pickedImage!):
  AssetImage(profile.profile_picture_url) as ImageProvider,
  ),
  Positioned(
  right: 3,
  bottom: -10,
  child: Container(
  child: IconButton(
  icon: Icon(
  Icons.camera_alt,
  size: 35,
  color: Colors.white,
  ),
  onPressed: () {
  pickImage();
  },
  ),
  ),
  ),
  ],
  ),
  ),

  //attributes
  Container(
  height: 650,
  //decoration for info container-----------------------------------
  decoration: BoxDecoration(
  color: Color.fromARGB(255, 255, 255, 255),
  borderRadius: BorderRadius.only(
  topLeft: Radius.circular(50),
  topRight: Radius.circular(50),
  ),
  ),
  //----------------------------------------------------------------
  child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Container(
  padding: EdgeInsets.all(15),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
  Text(
  ":الحساب الشخصي",
  style: TextStyle(
  color: Colors.indigo[900],
  fontSize: 30,
  fontWeight: FontWeight.bold,
  ),
  )
  ],
  ),
  ),
  // Username field
  Form(
  key: usernameKey,
  child: Align(
  alignment: Alignment.centerRight,
  child: Padding(
  padding: const EdgeInsets.only(
  top: 5, bottom: 15, right: 15, left: 15),
  child: TextFormField(
  controller: usernameController,
  validator: (value) {
  username =value;
  return null;              
  },
  decoration: InputDecoration(
  labelText: "اسم المستخدم",
  labelStyle: TextStyle(
  color: Colors.indigo[900],
  fontSize: 20.0,
  height: 0.8,
  ),
  hintText: profile.username ,
  floatingLabelBehavior:
  FloatingLabelBehavior.always,
  prefixIcon: Icon(Icons.person , color: Colors.indigo[900]),
  ),
  ),
  ),
  ),
  ),
  //--------------------------------
  SizedBox(height: 10.0),
  //-------------------------------
  Form(
  key: nameKey,
  child: Align(
  alignment: Alignment.centerRight,
  child: Padding(
  padding: const EdgeInsets.only(
  top: 5, bottom: 15, right: 15, left: 15),
  child: TextFormField(
  controller: nameController,
  validator: (value) {
  name = value;
  return null;
  },
  decoration: InputDecoration(
  labelText: "الاسم",
  labelStyle: TextStyle(
  color: Colors.indigo[900],
  fontSize: 20.0,
  height: 0.8,
  ),
  hintText: profile.name,
  floatingLabelBehavior:
  FloatingLabelBehavior.always,
  prefixIcon: Icon(Icons.person , color: Colors.indigo[900]),
  ),
  ),
  ),
  ),
  ),
  SizedBox(height: 10.0),
  // Email field

Form(
  key: emailKey,
  child: Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15, right: 15, left: 15),
      child: TextFormField(
        controller: emailController,
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            if (!RegExp(
                    r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                .hasMatch(value)) {
              return 'البريد الإلكتروني غير صحيح';
            }
          }
          return null; 
        },
        decoration: InputDecoration(
          labelText: "البريد الإلكتروني",
          labelStyle: TextStyle(
            color: Colors.indigo[900],
            fontSize: 20.0,
            height: 0.8,
          ),
          hintText: profile.userEmail,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(Icons.email , color: Colors.indigo[900]),
        ),
      ),
    ),
  ),
),

  SizedBox(height: 10.0),
  // Password field
  Form(
  key: passwordKey,
  child: Align(
  alignment: Alignment.centerRight,
  child: Padding(
  padding: const EdgeInsets.only(
  top: 5, bottom: 15, right: 15, left: 15),
  child: TextFormField(
  controller: passwordController,
  validator: (value) {
  if (value != null && value.isNotEmpty) {
  if (value.length < 8) {
  return "لا يجب ان تكون كلمة المرور اقل من 8 ";
  }
  }
  return null; 
  },
  obscureText: _obscurePassword,
  decoration: InputDecoration(
  labelText: "كلمة السر",
  labelStyle: TextStyle(
  color: Colors.indigo[900],
  fontSize: 20.0,
  height: 0.8,
  ),
  hintText: "أدخل كلمة المرور",
  floatingLabelBehavior:
  FloatingLabelBehavior.always,
  prefixIcon: Icon(Icons.lock , color: Colors.indigo[900]),
  suffixIcon: IconButton(
  icon: Icon(
  _obscurePassword
  ? Icons.visibility
  : Icons.visibility_off,
  color: Colors.white,
  ),
  onPressed: () {
  setState(() {
  _obscurePassword = !_obscurePassword;
  });
  },
  ),
  ),
  ),
  ),
  ),
  ),

  SizedBox(height: 15.0),
  // Save button
  Align(
  alignment: Alignment.center,
  child: Padding(
  padding: const EdgeInsets.only(
  top: 5, bottom: 15, right: 15, left: 15),
  child: ElevatedButton(
  onPressed: () async {
  if (usernameKey.currentState!.validate() &&
  nameKey.currentState!.validate() &&
  emailKey.currentState!.validate() &&
  passwordKey.currentState!.validate()) {
  String? updatedUsername = usernameController.text.isNotEmpty? usernameController.text: profile.username;
  String? updatedName =nameController.text.isNotEmpty ? nameController.text : profile.name;
  String? updatedEmail = emailController.text.isNotEmpty? emailController.text: profile.userEmail;
  String? updatedPassword = passwordController.text.isNotEmpty? passwordController.text: profile.password;
  try {
  await ApiService.editUserController(
  userId: profile.user_id,
  name: updatedName,
  username: updatedUsername,
  email: updatedEmail,
  password: updatedPassword);
  profile.name = updatedName;
  profile.username = updatedUsername;
  profile.userEmail = updatedEmail;
  profile.password = updatedPassword;
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => Profile()),
  );
  
  } catch (e) {
  print("Error: $e");
  }
  }
  },
  style: ElevatedButton.styleFrom(
  foregroundColor: Color.fromARGB(255, 1, 5, 33), backgroundColor: Colors.indigo[900],
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(
  50),
  ),
  ),
  child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
  Icon(Icons.save , color: Colors.white),
  SizedBox(width: 10),
  Text(
  'حفظ التعديلات',
  style: TextStyle(fontSize: 18,
  color:Colors.white),
  ),
  ],
  ),
  ),
  ),
  ),
  )
  ],
  ),
  ),
  )
  ],
  ),
  ),
  );
  }
  }
