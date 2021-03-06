import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:recollection_app/controller/news_controller.dart';
import 'package:recollection_app/main.dart';
import 'package:recollection_app/screens/map_activity.dart';
import 'package:recollection_app/screens/country_news_activity.dart';
import 'package:recollection_app/screens/world_news_activity.dart';
import 'package:recollection_app/screens/login.dart';
import 'package:recollection_app/screens/vaccine_tracker_activity.dart';
import 'package:recollection_app/widgets/GoogleAuth.dart';
import 'package:recollection_app/widgets/search_news_tab.dart';
import 'package:recollection_app/widgets/world_news_tab.dart';

class NewsActivity extends StatefulWidget {
  @override
  _NewsActivityState createState() => _NewsActivityState();
}

class _NewsActivityState extends State<NewsActivity>{

  var bookmarkPressed = true;
  int tabIndex = 0;

  List<Widget> tabScreens;
  ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    tabScreens = [
      WorldNewsTab(),
      SearchNewsTab(),
    ];
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0, duration: Duration(seconds: 3), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {

    const paleLavender = const Color(0xffdcd0ff);

    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 News", style: TextStyle(fontFamily: 'QuickSand')),
      ),
      backgroundColor: paleLavender,
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
                          child: Icon(Icons.colorize_outlined)
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
                          child: Icon(Icons.pie_chart_outline_outlined)
                      ),
                    ),
                  ),
                  title : Text("Country-wise Stats"),
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
                          child: Icon(Icons.my_library_books_outlined)
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
                          child: Icon(Icons.masks_outlined)
                      ),
                    ),
                  ),
                  title : Text("Overview"),
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
                            child: Icon(Icons.logout)
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
      // body: tabScreens[tabIndex],
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled){
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 0,
            )
          ];
        },
        body: tabScreens[tabIndex],
        ),
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
              icon: Icon(Icons.search_outlined),
              label: 'Search',
            ),
          ]
      ),
      floatingActionButton: InkWell(
        //This keeps the splash effect within the circle
        borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
        onTap: _scrollToTop,
        child: Padding(
            padding:EdgeInsets.all(10.0),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_upward_outlined,
                size: 30.0,
                color: Colors.deepPurple,
              ),
            )
        ),
      ),
    );
  }
}
