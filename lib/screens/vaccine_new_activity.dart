import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollection_app/screens/country_news_activity.dart';
import 'package:recollection_app/screens/map_activity.dart';
import 'package:recollection_app/screens/login.dart';
import 'package:recollection_app/screens/world_news_activity.dart';
import 'package:recollection_app/screens/news_activity.dart';
import 'package:recollection_app/widgets/GoogleAuth.dart';
import 'package:recollection_app/main.dart';
import 'dart:core';

class VaccineNewsActivity extends StatefulWidget {
  @override
  _VaccineNewsActivityState createState() => _VaccineNewsActivityState();
}

class _VaccineNewsActivityState extends State<VaccineNewsActivity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Vaccine Tracker", style: TextStyle(fontFamily: 'QuickSand')),
        ),
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
        )
    );
  }
}
