import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollection_app/controller/general_covid_controller.dart';
import 'package:recollection_app/screens/country_news_activity.dart';
import 'package:recollection_app/screens/vaccine_detail_screen.dart';
import 'package:recollection_app/screens/vaccine_tracker_activity.dart';
import 'package:recollection_app/screens/news_activity.dart';
import 'package:recollection_app/controller/news_controller.dart';
import 'package:recollection_app/screens/map_activity.dart';
import 'package:recollection_app/screens/login.dart';
import 'package:recollection_app/screens/signup.dart';
import 'package:recollection_app/screens/world_news_activity.dart';
import 'package:recollection_app/widgets/GoogleAuth.dart';
import 'package:recollection_app/widgets/accordion.dart';
import 'dart:core';
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home : SignUp(),
        routes: {
          VaccineDetailScreen.routeName : (context) => VaccineDetailScreen()
        }
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ScrollController _scrollController;
  bool lastStatus = true;
  double height = 200;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    const paleLavender = const Color(0xffdcd0ff);

    return Scaffold(
          appBar: AppBar(
            title: Text("Overview", style: TextStyle(fontFamily: 'QuickSand')),
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
          body : NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: height,
                  floating: true,
                  pinned: true,
                  snap: true,
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image(
                              image: AssetImage("assets/images/covid-19-expanded-banner.jpg"),
                              fit: BoxFit.cover,
                          ),
                        )
                    ],
                  ),
                )
              ];
            },
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  children : <Widget>[
                    Accordion("Overview", GeneralCovidController.getGeneralCovidInfo()["overview"].toString() +
                        "\n" +
                        "\n" + " " + "Source: World Health Organization(WHO)" +
                        "\n" ,
                        "https://www.who.int/health-topics/coronavirus#tab=tab_1",
                        true
                    ),
                    Accordion("Prevention", GeneralCovidController.getGeneralCovidInfo()["preventionGuideline"].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["preventions"][0].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["preventions"][1].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["preventions"][2].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["preventions"][3].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["preventions"][4].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["preventions"][5].toString() +
                        "\n" +
                        "\n" + " " + "Source: World Health Organization(WHO)" +
                        "\n" ,
                        "https://www.who.int/health-topics/coronavirus#tab=tab_2",
                        false
                    ),
                    Accordion("Symptoms", GeneralCovidController.getGeneralCovidInfo()["symptomsOverview"].toString() +
                        "\n" +
                        "\n" + "Most common symptoms:" +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["mostCommonSymptoms"][0].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["mostCommonSymptoms"][1].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["mostCommonSymptoms"][2].toString() +
                        "\n" +
                        "\n" + "Less common symptoms:" +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["lessCommonSymptoms"][0].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["lessCommonSymptoms"][1].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["lessCommonSymptoms"][2].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["lessCommonSymptoms"][3].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["lessCommonSymptoms"][4].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["lessCommonSymptoms"][5].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["lessCommonSymptoms"][6].toString() +
                        "\n" +
                        "\n" + "Serious symptoms:" +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["seriousSymptoms"][0].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["seriousSymptoms"][1].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["seriousSymptoms"][2].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["seriousSymptoms"][3].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["seriousSymptoms"][4].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["seriousSymptoms"][5].toString() +
                        "\n" + "\u2022" + " " + GeneralCovidController.getGeneralCovidInfo()["seriousSymptoms"][6].toString() +
                        "\n" +
                        "\n" + GeneralCovidController.getGeneralCovidInfo()["symptomsGuidelines"].toString() +
                        "\n" +
                        "\n" + " " + "Source: World Health Organization(WHO)" +
                        "\n" ,
                        "https://www.who.int/health-topics/coronavirus#tab=tab_3",
                        false
                    ),
                  ]
              ),
            )
          )// resizeToAvoidBottomPadding: false,
    );
  }
}


