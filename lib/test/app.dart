import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 64, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        title: Align(
         alignment: Alignment.centerRight,
          child: Text(
            "!طريق",
            textAlign: TextAlign.center,
            style: TextStyle(
             color: Colors.black,
             fontWeight: FontWeight.bold,
             fontSize: 30,
             ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 211, 194, 237),
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        "images/alaa.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Alaa Hasan"),
                      Text("alaahas345@gmail."),
                    ],
                  ),
                ],
              ),
              Container(
               height: 20,
              ),
              ListTile(
                title: Text("الصفحة الرئيسية"),
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: Text("حسابك "),
                leading: Icon(Icons.account_box),
              ),
              ListTile(
                title: Text("اسأل عن الطريق التي تريد"),
                leading: Icon(Icons.question_answer),
              ),
               ListTile(
                title: Text("تحدث معنا"),
                leading: Icon(Icons.email),
              ),
               ListTile(
                title: Text("تقييم"),
                leading: Icon(Icons.feedback),
              ),
               ListTile(
                title: Text("اضافة حاجز طيار"),
                leading: Icon(Icons.add),
              ),
              ListTile(
                title: Text("حول تطبيق طريق"),
                leading: Icon(Icons.help),
              ),

              Container(
                height: 15,
              ),
              Container(
             child:  
      Image.asset("images/zatara.jpg"),
  ), 
  Container(
    height: 10,
  ),
  Container(
  child:    Center(
    child: Text("لا نمتلك الحرية" ,
    style: TextStyle(fontSize: 28 , color:Colors.black, fontWeight: FontWeight.bold),),
  ),
)
            ],
          ),
        ),
      ),
      body: Container(
        // Body contents...
      ),
    );
  }
}
