import 'package:flutter/material.dart';
import 'package:hello_world/LogIn.dart';

  void main() {
  runApp(MaterialApp(home: Welcome(),
    debugShowCheckedModeBanner: false,

  ));
  }

  class Welcomweb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: ListView(
        children: [
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.only(right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "اهلا وسهلا بكم في",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "!طريق",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/gpssystem.png", fit: BoxFit.fill, width: 270),
            ],
          ),
          Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "لا يمكن للاحتلال ان يضعف من قوتنا",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    "في مواجهة هذه الحواجز ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    "!!اللاشرعية",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'ابدأ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
  
  class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: Colors.indigo[900],
  body: ListView(
  children: [
  SizedBox(height: 100),
  Padding(
  padding: EdgeInsets.only(right: 20),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
  Text(
  "اهلا وسهلا بكم في",
  style: TextStyle(
  color: Colors.white,
  fontSize: 30,
  ),
  )
  ],
  ),
  Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
  Text(
  "!طريق",
  style: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 35,
  ),
  )
  ],
  )
  ],
  ),
  ),
    SizedBox(height : 35),
  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Image.asset("images/gpssystem.png", fit: BoxFit.fill, width: 300),
  ],
  ),
  Container(
  height: 150,
  child: Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  Text(
  "لا يمكن للاحتلال ان يضعف من قوتنا",
  style: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18,
  ),
  ),
  Text(
  "في مواجهة هذه الحواجز ",
  style: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18,
  ),
  ),
  Text(
  "!!اللاشرعية",
  style: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18,
  ),
  ),
  ],
  ),
  ),
  ),
  SizedBox(height: 30),
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  GestureDetector(
  onTap: () {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => login()),
  );
  },
  child: Container(
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  width: 150,
  height: 50,
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(30),
  ),
  child: Text(
  'ابدأ',
  textAlign: TextAlign.center,
  style: TextStyle(
  color: Colors.indigo[900],
  fontSize: 25,
  fontWeight: FontWeight.bold,
  ),
  ),
  ),
  ),
  ],
  ),
  ],
  ),
  );
  }
  }


