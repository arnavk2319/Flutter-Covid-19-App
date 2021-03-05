import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollection_app/screens/country_news_activity.dart';
import 'package:recollection_app/screens/vaccine_new_activity.dart';
import 'package:recollection_app/screens/news_activity.dart';
import 'package:recollection_app/screens/map_activity.dart';
import 'package:recollection_app/controller/news_controller.dart';
import 'package:recollection_app/screens/login.dart';
import 'package:recollection_app/screens/signup.dart';
import 'package:recollection_app/screens/world_news_activity.dart';
import 'package:recollection_app/widgets/GoogleAuth.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:core';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : "My Recollection App",
      theme : ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: "QuickSand",
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
              headline6 : TextStyle(fontFamily: "OpenSans", fontSize: 20, fontWeight: FontWeight.bold)
            )
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6 :TextStyle(fontFamily: "OpenSans", fontSize: 18, fontWeight: FontWeight.bold)
        ),
      ),
      home : SignUp()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
        title: Text("Home", style: TextStyle(fontFamily: 'QuickSand')),
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
      ),
      body :
          Column(
            children: <Widget>[
              Container(
                child: Row (
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          // color: Theme.of(context).primaryColor,
                          child : Text("Add Item"),
                          // textColor: Colors.white,
                          onPressed: () {
                            // CovidController.getCountryWiseData("Afghanistan");
                            // CovidController.getAllCountryNames();
                            // _createNewsChildren();
                            // NewsController.getWorldNews();
                            NewsController.getCountryNews('us');
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // Container(
              //     child: WebView(
              //       initialUrl: Uri.dataFromString('<html><body><iframe width="400" height="400" src="https://data.ontario.ca/dataset/covid-19-vaccine-data-in-ontario/resource/8a89caa9-511c-4568-af89-7f2174b4378c/view/9e42f55b-723f-46dd-b0d9-643670e01fed" frameBorder="0"></iframe></body></html>', mimeType: 'text/html').toString(),
              //       javascriptMode: JavascriptMode.unrestricted,
              //     )
              // ),
            ],
          )
    );
  }
}


