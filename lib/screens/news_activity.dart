import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:recollection_app/controller/news_controller.dart';
import 'package:recollection_app/main.dart';
import 'package:recollection_app/screens/map_activity.dart';
import 'package:recollection_app/screens/country_news_activity.dart';
import 'package:recollection_app/screens/world_news_activity.dart';
import 'package:recollection_app/screens/login.dart';
import 'package:recollection_app/screens/vaccine_new_activity.dart';
import 'package:recollection_app/widgets/GoogleAuth.dart';
import 'package:recollection_app/widgets/country_news_tab.dart';
import 'package:recollection_app/widgets/search_news_tab.dart';
import 'package:recollection_app/widgets/world_news_tab.dart';

class NewsActivity extends StatefulWidget {
  @override
  _NewsActivityState createState() => _NewsActivityState();
}

class _NewsActivityState extends State<NewsActivity> {

  var bookmarkPressed = true;

  int tabIndex = 0;

  List<Widget> tabScreens;

  void initState() {
    super.initState();
    tabScreens = [
      WorldNewsTab(),
      CountryNewsTab(),
      SearchNewsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 News", style: TextStyle(fontFamily: 'QuickSand')),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      drawer: Drawer(
          child : ListView(
              padding : EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: name != null ? Text(name) : Text("Name"),
                  accountEmail: email != null ? Text(email) : Text("Email"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : AssetImage("assets/images/google.jpg"),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(6),
                  leading: CircleAvatar(
                    radius: 30,
                    child : Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text("M")
                      ),
                    ),
                  ),
                  title : Text("Map Activity"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => MapActivity()));
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(6),
                  leading: CircleAvatar(
                    radius: 30,
                    child : Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text("M")
                      ),
                    ),
                  ),
                  title : Text("World COVID-19 News"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => WorldNewsActivity()));
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(6),
                  leading: CircleAvatar(
                    radius: 30,
                    child : Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text("M")
                      ),
                    ),
                  ),
                  title : Text("Vaccine Tracker"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => VaccineNewsActivity()));
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(6),
                  leading: CircleAvatar(
                    radius: 30,
                    child : Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text("M")
                      ),
                    ),
                  ),
                  title : Text("Country-wise COVID-19 News"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => CountryNewsActivity()));
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(6),
                  leading: CircleAvatar(
                    radius: 30,
                    child : Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text("M")
                      ),
                    ),
                  ),
                  title : Text("COVID-19 News"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => NewsActivity()));
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(6),
                  leading: CircleAvatar(
                    radius: 30,
                    child : Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text("M")
                      ),
                    ),
                  ),
                  title : Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => MyHomePage()));
                  },
                ),
                email != null ?
                ListTile(
                    contentPadding: EdgeInsets.all(6),
                    leading: CircleAvatar(
                      radius: 30,
                      child : Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("L")
                        ),
                      ),
                    ),
                    title : Text("Logout"),
                    onTap: () {
                      signOutGoogle();
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => Login()));
                    }
                )
                    :
                ListTile(
                    contentPadding: EdgeInsets.all(6),
                    leading: CircleAvatar(
                      radius: 30,
                      child : Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("L")
                        ),
                      ),
                    ),
                    title : Text("Login/Sign Up"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => Login()));
                    }
                ),
              ]
          )
      ),
      body: tabScreens[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.blur_circular_outlined),
              label: 'World News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: 'Country News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: 'Search',
            ),
          ]
      ),
    );
  }
}
