import 'package:flutter/material.dart';
import 'package:hello_world/Welcom.dart';
import 'package:hello_world/SignUp.dart';



void main() {
  runApp(MaterialApp(
    home: login(),
  ));
}
// ignore: must_be_immutable
class login extends StatelessWidget {
  login({super.key});

  final GlobalKey<FormState> framstate = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 64, 251),
      body: Container(
        child: ListView(
          children: [
            //arrow back icon-------------------------------------------------
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
            //----------------------------------------------------------------
            //space-----------------------------------------------------------
            Container(
              height: 200,
              alignment:Alignment.center
              ,
              child:  Image.asset("images/gpssystem.png", width: 300),
            ),
            //----------------------------------------------------------------
            //log information-------------------------------------------------
            Container(
              height: 600,
            //decoration for info container-----------------------------------
              decoration: BoxDecoration(
                color: const Color.fromARGB(134, 255, 255, 255),
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
                            color: Color.fromARGB(255, 89, 29, 179),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
            //----------------------------------------------------------------      
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
                              color: Color.fromARGB(255, 89, 29, 179),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            //----------------------------------------------------------------      
            //log in page(ادخال البريد الالكتروني)--------------------------- 
                  Center(
  child: Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15, right: 15 ,left: 15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 139, 64, 251),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.email, color: Colors.white),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Stack(
                children: [

                  TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'برجاء إدخال البريد الإلكتروني';
                }
                if (!RegExp(
                        r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                    .hasMatch(value)) {
                  return 'البريد الإلكتروني غير صحيح';
                }
                return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'ادخل البريد الإلكتروني',
              ),
              onSaved: (value) {
                email = value;
              },
            ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),
            //----------------------------------------------------------------                  
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
                              color: Color.fromARGB(255, 89, 29, 179),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            //----------------------------------------------------------------      
            //log in page(ادخال كلمة المرور)--------------------------------               
                  Center(
  child: Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15, right: 15 ,left: 15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 139, 64, 251),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.lock, color: Colors.white),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Stack(
                children: [
                  TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'ادخل كلمة المرور',
              ),
              onSaved: (value) {
                password = value;
              },
            ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),
            //----------------------------------------------------------------   

            Form(
                key: framstate,
  child: Center(
    child: Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 15, right: 15, left: 15),
        child: TextFormField(
          validator: (value){
            if(value!.isEmpty){
              return "الحقل فارغ";
      }
       if (!RegExp( r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
                  return 'البريد الإلكتروني غير صحيح';
                }
                return null;  
    },
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 139, 64, 251),
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

           Container(
              height: 10,
            ),
          
            //login  
       Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
MaterialButton(
                onPressed: () {
                  if (framstate.currentState!.validate()) {
                    framstate.currentState!.save();
                  } else {
                    print("Form is not valid");
                  }
                },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 45,
        width: 160,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 139, 64, 251),
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
                       color: Color.fromARGB(255, 139, 64, 251), 
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
                    color: Color.fromARGB(255, 139, 64, 251),
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
                  color: Color.fromARGB(255, 139, 64, 251),
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'images/google_logo.png',
                  width: 35,
                  height: 35,
                  color: Color.fromRGBO(139, 64, 251, 1),
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'images/instagram_logo.png',
                  width: 35,
                  height: 35,
                  color: Color.fromARGB(255, 139, 64, 251),
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'images/linkedin_logo.png',
                  width: 35,
                  height: 35,
                  color: Color.fromARGB(255, 139, 64, 251),
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
                          color: Color.fromARGB(255, 139, 64, 251), 
                          fontSize: 16)),
            
                            GestureDetector(
  onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
      );
  },
  child: Column(
    children: [
      Text(
        "انشاء حساب",
        style: TextStyle(
          color: Color.fromARGB(255, 139, 64, 251),
          fontSize: 16,
        ),
      ),
      SizedBox(height: 0.1),
      DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 139, 64, 251),
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
  void _submitForm(BuildContext context) {
    if (framstate.currentState!.validate()) {
      framstate.currentState!.save();
      print('Email: $email');
      print('Password: $password');
    }
  }
}
