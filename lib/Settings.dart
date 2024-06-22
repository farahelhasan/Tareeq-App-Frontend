import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/AboutTareeq.dart';
import 'package:hello_world/ApiService.dart';
import 'package:hello_world/HomePageMobile.dart';
import 'package:hello_world/HomePageUserMobile.dart';
import 'package:hello_world/HomePageUserWeb.dart';
import 'package:hello_world/HomePageWeb.dart';
import 'package:hello_world/LogIn.dart';
import 'package:hello_world/MapPageUser.dart';
import 'package:hello_world/Profile.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';


class SettingsWeb extends StatefulWidget {
  @override
  _SettingsWebState createState() => _SettingsWebState();
}

class _SettingsWebState extends State<SettingsWeb> {
  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      print("Initializing user...");
      print(profile.user_id);
      Map<String, dynamic> userData = await ApiService.getUserController(profile.user_id);
      print(userData);
      setState(() {
        profile.userEmail = userData['email'];
        profile.name = userData['name'];
        profile.username = userData['username'];
        profile.password = userData['password'];
        profile.profile_picture_url = userData['profile_picture_url'];
      });
    } catch (e) {
      print("Error initializing user: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (profile.isadmin) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>kIsWeb ? HomePageWeb() : Homepagemobile(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => kIsWeb ? Homepageuserweb() : Homepageusermobile(),
                ),
              );
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'الإعدادات',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: 800, 
          child: ListView(
            padding: EdgeInsets.all(2),
            children: [
              BigUserCard(
                backgroundColor: Color.fromARGB(79, 114, 100, 226),
                userName: profileinfo.username ,
                userProfilePic: NetworkImage(profile.profile_picture_url),
                cardActionWidget: SettingsItem(
                  icons: Icons.edit,
                  iconStyle: IconStyle(
                    withBackground: true,
                    borderRadius: 50,
                    backgroundColor: Colors.yellow[600],
                  ),
                  title: "حسابك",
                  titleStyle: TextStyle(
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: "اضغط هنا لتعديل بياناتك",
                  subtitleStyle: TextStyle(
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () {
                    profile.name = profileinfo.name;
                    profile.userEmail = profileinfo.userEmail;
                    profile.username = profileinfo.username;
                    profile.user_id = profileinfo.user_id;
                    profile.profile_picture_url = profileinfo.profile_picture_url;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => kIsWeb ? ProfileWeb() : Profile()),
                    );
                  },
                ),
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.notifications_active_outlined,
                    iconStyle: IconStyle(),
                    title: 'الاشعارات',
                    titleStyle: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                    ),
                    trailing: Switch.adaptive(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.red,
                    ),
                    title: 'الوضع داكن',
                    titleStyle: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                    ),
                    trailing: Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.location_on_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                    title: 'الموقع',
                    titleStyle: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                    ),
                    trailing: Switch.adaptive(
                      value: profileinfo.Location,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => kIsWeb ? AboutPageWeb() : AboutPage()),
                      );
                    },
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'حول تطبيق طريق',
                    titleStyle: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: "اعرف المزيد عن تطبيقنا ",
                    subtitleStyle: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SettingsGroup(
                settingsGroupTitle: "الحساب",
                settingsGroupTitleStyle: TextStyle(
                  color: Colors.indigo[900],
                  fontWeight: FontWeight.bold,
                ),
                items: [
                  SettingsItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => kIsWeb ? loginweb() : login()),
                      );
                    },
                    icons: Icons.exit_to_app_rounded,
                    title: "تسجيل خروج",
                    titleStyle: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: CupertinoIcons.delete_solid,
                    title: "حذف الحساب",
                    titleStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  
  }
  
}

class ThemeModel with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeModel({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: Colors.indigo[900],
  appBar: AppBar(
  backgroundColor: Colors.indigo[900],
  elevation: 0,
  leading: IconButton(
  onPressed: () {
  if (profile.isadmin){
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => Homepagemobile()),
  );
    }else{
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => Homepageusermobile()),
  );

    }
  
  },
  icon: Icon(
  Icons.arrow_back_ios_new_rounded,
  size: 30,
  color: Colors.white,
  ),

  ),
  title: Align(
  alignment: Alignment.centerRight,
  child: Padding(
  padding: const EdgeInsets.all(15.0),
  child: Text('الإعدادات' , style: 
  TextStyle(
  color:Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 30
  ),
  textAlign: TextAlign.right,),
  ),
  ),

  ),
  body: ListView(
  padding: EdgeInsets.all(15),
  children: [
  BigUserCard(
  userName: profileinfo.username,
  userProfilePic: AssetImage(profileinfo.profile_picture_url),
  cardActionWidget: SettingsItem(
  icons: Icons.edit,
  iconStyle: IconStyle(
  withBackground: true,
  borderRadius: 50,
  backgroundColor: Colors.yellow[600],
  ),
  title: "حسابك",
  titleStyle: TextStyle(
  color:Colors.indigo[900],
  fontWeight: FontWeight.bold,
  ),
  subtitle: "اضغط هنا لتعديل بياناتك",
  subtitleStyle: TextStyle(
  color:Colors.indigo[900],
  fontWeight: FontWeight.bold,
  ),
  onTap: () {
  profile.name =  profileinfo.name;
  profile.userEmail =  profileinfo.userEmail;
  profile.username =  profileinfo.username;
  profile.user_id =  profileinfo.user_id;
  profile.profile_picture_url =  profileinfo.profile_picture_url;
  print("OK");
  Navigator.push(

  context,
  MaterialPageRoute(builder: (context) => Profile()),
  );
  },
  ),
  ),
  SettingsGroup(
  items: [
  SettingsItem(
  onTap: () {},
  icons: Icons.notifications_active_outlined,
  iconStyle: IconStyle(),
  title: 'الاشعارات',
  titleStyle: TextStyle(
  color:Colors.indigo[900],
  fontWeight: FontWeight.bold,
  ),
  trailing: Switch.adaptive(
  value: true,
  onChanged: (value) {
  },
  ),
  ),
  SettingsItem(
  onTap: () {},
  icons: Icons.dark_mode_rounded,
  iconStyle: IconStyle(
  iconsColor: Colors.white,
  withBackground: true,
  backgroundColor: Colors.red,
  ),
  title: 'الوضع داكن',
  titleStyle: TextStyle(
  color:Colors.indigo[900],
  fontWeight: FontWeight.bold,
  ),
  trailing: Switch.adaptive(
  value: false,
  onChanged: (value) {},
  ),
  ),
  SettingsItem(
  onTap: () {},
  icons: Icons.location_on_rounded,
  iconStyle: IconStyle(
  iconsColor: Colors.white,
  withBackground: true,
  backgroundColor: Colors.lightBlueAccent,
  ),
  title: 'الموقع',
  titleStyle: TextStyle(
  color:Colors.indigo[900],
  fontWeight: FontWeight.bold,
  ),
  trailing: Switch.adaptive(
  value:profileinfo.Location,
  onChanged: (value) {
  },
  ),
  ),
  ],
  ),
  SettingsGroup(
  items: [
  SettingsItem(
  onTap: () {},
  icons: Icons.info_rounded,
  iconStyle: IconStyle(
  backgroundColor: Colors.purple,
  ),
  title: 'حول تطبيق طريق',
  titleStyle: TextStyle(
  color:Colors.indigo[900],
  fontWeight: FontWeight.bold,
  ),
  subtitle: "اعرف المزيد عن تطبيقنا ",
  subtitleStyle: TextStyle(
  color:Colors.indigo[900],
  fontWeight: FontWeight.bold,
  ),
  ),
  ],
  ),
  SettingsGroup(
  settingsGroupTitle: "الحساب",
  settingsGroupTitleStyle: TextStyle(
  color:Colors.indigo[900],
  fontWeight: FontWeight.bold,
  ),
  items: [
  SettingsItem(
  onTap: () {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => login()),
  );
  },
  icons: Icons.exit_to_app_rounded,
  title: "تسجيل خروج",
  titleStyle: TextStyle(
  color:Colors.indigo[900],
  fontWeight: FontWeight.bold,
  ),
  ),
  SettingsItem(
  onTap: () {
  },
  icons: CupertinoIcons.delete_solid,
  title: "حذف الحساب",
  titleStyle: TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  ),
  ),
  ],
  ),
  ],
  ),
  );
  }
  }
  
class profile {
  static bool isadmin = Globals.ifadmin;
  static int user_id = Globals.userId;
  static String userEmail = Globals.userEmail;
  static String name = Globals.name;
  static String username = Globals.username;
  static String password = Globals.password;
  static String profile_picture_url = Globals.profile_picture_url;
  }
